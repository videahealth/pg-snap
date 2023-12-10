use crate::{
    db::Db,
    structs::PgTable,
    table::Table,
    utils::{extract_and_remove_fk_constraints, get_major_version, parse_skip_tables, should_skip},
};
use anyhow::anyhow;
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

    let remote_v = pg.get_version().await.expect("Error getting PG version");
    let pg_dump_v = get_pg_dump_version().expect("Error executing pg dump");
    let major_version =
        get_major_version(remote_v.clone()).expect("Error getting major postgres version");

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

    let query_rows = pg.get_tables().await.expect("Error fetching pg tables");

    let rows: Vec<Table> = query_rows
        .into_iter()
        .filter(|r| !should_skip(r.schema.as_str(), r.name.as_str(), &skip_tables))
        .map(|v| Table::new(v.name, v.schema, pg.clone(), None, None))
        .collect();

    let base_dir = "./data-dump".to_string();
    let base_dir_path: &Path = base_dir.as_ref();
    fs::create_dir_all(base_dir.clone()).expect("Error creating directory");

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
            fs::create_dir_all(table_path).expect("Error creating directory");

            let data_path = table_path.join("data.csv");
            let table_data_path = table_path.join("table.bin");

            let num_rows = table
                .copy_out(&data_path)
                .await
                .expect("Error copying table data");

            info!("Copied {num_rows} for {table_schema}.{table_name}");

            let pg_table =
                PgTable::new(table_name.to_string(), table_schema.to_string(), data_path);
            pg_table
                .save_to_file(table_data_path)
                .await
                .expect("Error saving table info");

            Ok::<(), Box<dyn std::error::Error + Send>>(())
        });

        join_set.spawn(handle);
    }

    while let Some(output) = join_set.join_next().await {
        if let Err(e) = output.expect("Error in worker") {
            eprintln!("Error in worker: {e}");
        }
    }

    info!("Using pg_dump to extract database DDL");
    let res = dump_schema_to_file(&user, &pw, &host, 5432, &db).expect("Error writing sql file");

    let fk_content_path = base_dir_path.join("fk_constraints.sql");
    let ddl_content_path = base_dir_path.join("ddl.sql");

    let (fk_commands, other_commands) =
        extract_and_remove_fk_constraints(res).expect("Error extracting DDL file");

    fs::write(fk_content_path, fk_commands).expect("Err");
    fs::write(ddl_content_path, other_commands).expect("Err");

    Ok(())
}

pub fn dump_schema_to_file(
    username: &str,
    password: &str,
    host: &str,
    port: u16,
    dbname: &str,
) -> std::io::Result<String> {
    // Create and configure the pg_dump command
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

    let output = command
        .output()
        .expect("Failed to execute pg_dump command.");

    if !output.status.success() {
        eprintln!(
            "Error executing pg_dump: {}",
            String::from_utf8_lossy(&output.stderr)
        );
        return Err(std::io::Error::new(
            std::io::ErrorKind::Other,
            "pg_dump command failed",
        ));
    }

    let result = String::from_utf8(output.stdout).expect("Error reading stdout");

    Ok(result)
}

pub fn get_pg_dump_version() -> std::io::Result<String> {
    // Create and configure the pg_dump command
    let mut command = Command::new("pg_dump");

    command.arg("--version");

    let output = command
        .output()
        .expect("Failed to execute pg_dump command.");

    if !output.status.success() {
        eprintln!(
            "Error executing pg_dump: {}",
            String::from_utf8_lossy(&output.stderr)
        );
        return Err(std::io::Error::new(
            std::io::ErrorKind::Other,
            "pg_dump command failed",
        ));
    }

    let result = String::from_utf8(output.stdout).expect("Error reading stdout");

    Ok(result)
}
