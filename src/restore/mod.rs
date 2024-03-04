use std::collections::HashSet;
use std::path::{Path, PathBuf};
use std::process::Command;

use tokio::task::{JoinError, JoinSet};
use tokio::{fs, task};

use crate::db::Db;
use crate::structs::PgTable;
use crate::table::Table;
use crate::utils::{ask_for_confirmation, execute_command, get_major_version};
use anyhow::Result;
use anyhow::{anyhow, Context};

pub async fn restore_db(
    host: String,
    user: String,
    db: String,
    pw: String,
    concurrency: Option<usize>,
) -> anyhow::Result<()> {
    let database = Db::new(host.clone(), user.clone(), db.clone(), pw.clone());

    let remote_v = database.get_version().await?;
    let pg_restore_v = get_pg_restore_version()?;
    let major_version = get_major_version(remote_v.clone())?;

    if !pg_restore_v.contains(&major_version) {
        return Err(anyhow!(
            "\nError: Remote postgres major version: {}\n does not match \npg_restore major version: {}",
            remote_v,
            pg_restore_v
        ));
    }

    let base_dir = Path::new("./data-dump");
    let pg_tables = load_pg_tables(base_dir).await?;

    let ext_tables = database
        .get_extension_tables()
        .await
        .context("Error getting table extensions")?;
    let ext_tables_set: HashSet<String> = ext_tables
        .into_iter()
        .map(|v| format!("{}.{}", v.schema, v.name))
        .collect();

    let tables: Vec<Table> = pg_tables
        .iter()
        .map(|v| {
            let is_extension = ext_tables_set.contains(&format!("{}.{}", v.schema, v.name));

            Table::new(
                v.name.clone(),
                v.schema.clone(),
                database.clone(),
                Some(is_extension),
                Some(v.data_file.clone()),
            )
        })
        .collect();

    let max_workers = concurrency.unwrap_or(3);
    info!("Running with concurrency of {}", max_workers);

    let conf_string =
        format!("Warning! this operation will drop the database {db}, do you wish to continue?");

    ask_for_confirmation(&conf_string);

    database
        .recreate_database()
        .await
        .context("Error dropping and recrating database")?;

    let ddl_file_path = base_dir.join("ddl.sql");

    match execute_ddl_file(&db, &user, &pw, &host, &ddl_file_path).await {
        Err(e) => warn!("Error executing DDL: {}", e),
        Ok(_) => info!("Executed DDL"),
    };

    let mut join_set: JoinSet<Result<(), JoinError>> = JoinSet::new();

    info!("Uploading snapshot and applying DDL");
    for tbl in tables {
        let ext_tables_set_clone = ext_tables_set.clone();
        let database = database.clone();

        while join_set.len() >= max_workers {
            let _ = join_set.join_next().await.unwrap().unwrap();
        }

        let handle = task::spawn(async move {
            match &tbl.get_data_file_path().context("Error getting data path") {
                Ok(path) => {
                    if let Err(e) =
                        read_from_file_and_write_to_db(path, &tbl, &database, &ext_tables_set_clone)
                            .await
                    {
                        warn!(
                            "Error copying data for table: {}.{}: {}",
                            tbl.schema, tbl.name, e
                        );
                    }
                }
                Err(e) => {
                    warn!(
                        "Error getting data path for table: {}.{}: {}",
                        tbl.schema, tbl.name, e
                    );
                }
            }
        });

        join_set.spawn(handle);
    }

    while let Some(output) = join_set.join_next().await {
        if let Err(e) = output.context("Error in worker")? {
            eprintln!("Error in worker: {e}")
        }
    }

    let fk_file_path = base_dir.join("fk_constraints.sql");

    match execute_ddl_file(&db, &user, &pw, &host, &fk_file_path).await {
        Err(e) => warn!("Error executing FK constraints: {}", e),
        Ok(_) => info!("Executed FK constraints"),
    };

    let database = database.clone();

    match database.write_table_sequences().await {
        Err(e) => {
            warn!("Error executing SEQ updates: {}", e);
            return Ok(());
        }
        Ok(_) => {
            info!("Executed SEQ updates");
            return Ok(());
        }
    }
}

async fn load_pg_tables(dir_path: &Path) -> Result<Vec<PgTable>> {
    let mut pg_tables: Vec<PgTable> = vec![];

    // Read the directory
    let mut entries = fs::read_dir(dir_path).await.context("Could not read dir")?;

    // Process each entry in the directory
    while let Some(entry) = entries
        .next_entry()
        .await
        .context("Could not get next entry")?
    {
        if entry
            .file_type()
            .await
            .context("Could not get file type")?
            .is_dir()
        {
            let full_path = entry.path().join("table.bin");

            let pg_table_file = PgTable::from_file(full_path).await?;

            pg_tables.push(pg_table_file)
        }
    }

    Ok(pg_tables)
}

async fn read_from_file_and_write_to_db(
    path: &Path,
    table: &Table,
    pg: &Db,
    ext_tables: &HashSet<String>,
) -> Result<()> {
    let full_path: PathBuf = path.canonicalize()?;

    let full_table_name = format!("{}.{}", table.schema, table.name);

    let mut table_to_copy = table.name.to_owned();
    let mut schema_to_copy: Option<&str> = Some(table.schema.as_str());

    let mut is_tmp_table = false;

    if ext_tables.contains(&full_table_name) {
        let tmp_table = pg
            .create_temp_table(table_to_copy, table.schema.to_string())
            .await?;

        table_to_copy = tmp_table;
        schema_to_copy = None;
        is_tmp_table = true;
    }

    match table
        .copy_in(&full_path, table_to_copy.as_str(), schema_to_copy)
        .await
    {
        Ok(v) => {
            info!("Copied {} rows from {}.{}", v, table.schema, table.name);
            if is_tmp_table {
                pg.copy_from_tmp_table(
                    format!("\"{}\".\"{}\"", table.schema, table.name).as_str(),
                    format!("\"{}\"", table_to_copy).as_str(),
                )
                .await?;
            }
        }
        Err(e) => {
            warn!(
                "Error copying for table {}.{}: {}",
                table.schema, table.name, e
            );
        }
    }

    Ok(())
}

async fn execute_ddl_file(
    dbname: &str,
    username: &str,
    password: &str,
    host: &str,
    path: &Path,
) -> Result<()> {
    let full_path: PathBuf = path.canonicalize()?;
    let full_path_clone = full_path.clone();
    let full_path_str = full_path_clone
        .to_str()
        .context("Failed to convert PathBuf to str")?;

    let output = Command::new("psql")
        .env("PGPASSWORD", password)
        .arg("-U")
        .arg(username)
        .arg("-h")
        .arg(host)
        .arg("-d")
        .arg(dbname)
        .arg("-f")
        .arg(full_path_str)
        .output()?;

    if !output.stderr.is_empty() {
        warn!("Error: {}", String::from_utf8_lossy(&output.stderr));
    }

    Ok(())
}

pub fn get_pg_restore_version() -> Result<String> {
    let mut command = Command::new("pg_restore");
    command.arg("--version");

    execute_command("pg_restore", &mut command)
}
