use crate::{
    db::Db,
    structs::PgTable,
    table::Table,
    utils::{
        execute_command, extract_and_remove_fk_constraints, get_major_version, parse_skip_tables,
        should_skip,
    },
};
use anyhow::{anyhow, Context, Result};
use std::{collections::HashSet, fs, path::Path, process::Command};
use tokio::task::{self, JoinError, JoinSet};

type ThreadResult = Result<(), Box<dyn std::error::Error + Send>>;
type JoinSetResult = Result<ThreadResult, JoinError>;

pub async fn dump_db(
    host: String,
    user: String,
    db: String,
    pw: String,
    skip_tables_str: Option<String>,
    concurrency: Option<usize>,
) -> anyhow::Result<()> {
    let pg = Db::new(host.clone(), user.clone(), db.clone(), pw.clone());

    let remote_v = pg.get_version().await?;
    let pg_dump_v = get_pg_dump_version()?;
    let major_version = get_major_version(remote_v.clone())?;

    if !pg_dump_v.contains(&major_version) {
        return Err(anyhow!(
            "\nError: Remote postgres major version: {}\n does not match \npg_dump major version: {}",
            remote_v,
            pg_dump_v
        ));
    }

    let skip_tables = match skip_tables_str.clone() {
        Some(tbls) => parse_skip_tables(&tbls),
        None => HashSet::new(),
    };

    let max_workers = concurrency.unwrap_or(5);
    info!("Running with concurrency of {}", max_workers);

    let query_rows = pg.get_tables().await.context("Error fetching pg tables")?;

    let rows: Vec<Table> = query_rows
        .into_iter()
        .filter(|r| !should_skip(r.schema.as_str(), r.name.as_str(), &skip_tables))
        .map(|v| Table::new(v.name, v.schema, pg.clone(), None, None))
        .collect();

    let base_dir = "./data-dump".to_string();
    let base_dir_path: &Path = base_dir.as_ref();
    fs::create_dir_all(base_dir.clone()).context("Error creating directory")?;

    let mut join_set: JoinSet<JoinSetResult> = JoinSet::new();

    info!("Introspecting and taking a snapshot");
    for table in rows {
        while join_set.len() >= max_workers {
            let _ = join_set.join_next().await.unwrap().unwrap();
        }

        let base_dir_clone = base_dir.clone();

        let handle = task::spawn(async move {
            let table_schema: &str = &table.schema;
            let table_name: &str = &table.name;

            let table_dir = format!("{}/{}", base_dir_clone, table_name);
            let table_path = Path::new(&table_dir);
            let _ = fs::create_dir_all(table_path).context("Error creating directory");

            let data_path = table_path.join("data.csv");
            let table_data_path = table_path.join("table.bin");

            let num_rows = table
                .copy_out(&data_path)
                .await
                .context("Error copying table data")?;

            info!("Copied {num_rows} for {table_schema}.{table_name}");

            let pg_table =
                PgTable::new(table_name.to_string(), table_schema.to_string(), data_path);
            let _ = pg_table
                .save_to_file(table_data_path)
                .await
                .context("Error saving table info");

            Ok::<(), Box<dyn std::error::Error + Send>>(())
        });

        join_set.spawn(handle);
    }

    while let Some(output) = join_set.join_next().await {
        if let Err(e) = output.context("Error in worker") {
            eprintln!("Error in worker: {e}");
        }
    }

    info!("Using pg_dump to extract database DDL");
    let res =
        dump_schema_to_file(&user, &pw, &host, 5432, &db).context("Error writing sql file")?;

    let fk_content_path = base_dir_path.join("fk_constraints.sql");
    let ddl_content_path = base_dir_path.join("ddl.sql");

    let (fk_commands, other_commands) =
        extract_and_remove_fk_constraints(res).context("Error extracting DDL file")?;

    let _ = fs::write(fk_content_path, fk_commands).context("Err");
    let _ = fs::write(ddl_content_path, other_commands).context("Err");

    Ok(())
}
pub fn dump_schema_to_file(
    username: &str,
    password: &str,
    host: &str,
    port: u16,
    dbname: &str,
) -> Result<String> {
    let mut command = Command::new("pg_dump");
    command
        .env("PGPASSWORD", password)
        .arg("-U")
        .arg(username)
        .arg("-h")
        .arg(host)
        .arg("-p")
        .arg(port.to_string())
        .arg("-d")
        .arg(dbname)
        .arg("--schema-only");

    execute_command("pg_dump", &mut command)
}

pub fn get_pg_dump_version() -> Result<String> {
    let mut command = Command::new("pg_dump");
    command.arg("--version");

    execute_command("pg_dump", &mut command)
}
