use std::fs::File;
use std::io::{self};
use std::path::{Path, PathBuf};
use std::process::Command;

use tokio::task::{JoinError, JoinSet};
use tokio::{fs, task};

use crate::db::recreate_database;
use crate::structs::PgTable;
use crate::utils::ask_for_confirmation;
use std::io::BufRead;

pub async fn restore_db(
    host: String,
    user: String,
    db: String,
    pw: String,
    concurrency: Option<usize>,
) {
    let base_dir = Path::new("./data-dump");
    let tables = load_pg_tables(base_dir).await;

    let max_workers = concurrency.unwrap_or(3);
    info!("Running with concurrency of {}", max_workers);

    let conf_string =
        format!("Warning! this operation will drop the database {db}, do you wish to continue?");

    ask_for_confirmation(&conf_string);

    recreate_database(host.clone(), user.clone(), db.clone(), pw.clone())
        .await
        .expect("Error dropping and recrating database");

    let ddl_file_path = base_dir.join("ddl.sql");

    match execute_ddl_file(&db, &user, &pw, &host, &ddl_file_path).await {
        Err(e) => warn!("Error executing DDL: {}", e),
        Ok(_) => info!("Executed DDL"),
    };

    let mut join_set: JoinSet<Result<(), JoinError>> = JoinSet::new();

    info!("Uploading snapshot and applying DDL");
    for tbl in tables {
        let host_clone = host.clone();
        let user_clone = user.clone();
        let db_clone = db.clone();
        let pw_clone = pw.clone();

        while join_set.len() >= max_workers {
            let _ = join_set.join_next().await.unwrap().unwrap();
        }

        let handle = task::spawn(async move {
            if let Err(e) = read_from_file_and_write_to_db(
                &tbl.data_file,
                &tbl.name,
                &tbl.schema,
                &db_clone,
                &user_clone,
                &pw_clone,
                &host_clone,
            )
            .await
            {
                warn!(
                    "Error copying data for table: {}.{}: {}",
                    tbl.name, tbl.schema, e
                )
            }
        });

        join_set.spawn(handle);
    }

    while let Some(output) = join_set.join_next().await {
        match output.expect("Error in worker") {
            Err(e) => eprintln!("Error in worker: {e}"),
            Ok(_) => (),
        }
    }

    let fk_file_path = base_dir.join("fk_constraints.sql");

    match execute_ddl_file(&db, &user, &pw, &host, &fk_file_path).await {
        Err(e) => warn!("Error executing FK constraints: {}", e),
        Ok(_) => info!("Executed FK constraints"),
    };
}

async fn load_pg_tables(dir_path: &Path) -> Vec<PgTable> {
    let mut pg_tables: Vec<PgTable> = vec![];

    // Read the directory
    let mut entries = fs::read_dir(dir_path).await.expect("Could not read dir");

    // Process each entry in the directory
    while let Some(entry) = entries
        .next_entry()
        .await
        .expect("Could not get next entry")
    {
        if entry
            .file_type()
            .await
            .expect("Could not get file type")
            .is_dir()
        {
            let full_path = entry.path().join("table.bin");

            pg_tables.push(
                PgTable::from_file(full_path)
                    .await
                    .expect("Could not deserialize file"),
            )
        }
    }

    pg_tables
}

fn read_first_line(path: PathBuf) -> io::Result<String> {
    let file = File::open(path)?;
    let reader = std::io::BufReader::new(file);
    let mut lines = reader.lines();
    match lines.next() {
        Some(line) => {
            let quoted: Vec<String> = line?
                .split(',')
                .map(|column| format!("\"{}\"", column))
                .collect();
            Ok(quoted.join(","))
        }
        None => Err(io::Error::new(
            io::ErrorKind::UnexpectedEof,
            "File was empty",
        )),
    }
}

async fn read_from_file_and_write_to_db(
    path: &PathBuf,
    table_name: &str,
    table_schema: &str,
    dbname: &str,
    username: &str,
    password: &str,
    host: &str,
) -> io::Result<()> {
    let full_path: PathBuf = path.canonicalize()?;
    let full_path_clone = full_path.clone();
    let full_path_str = full_path_clone
        .to_str()
        .expect("Failed to convert PathBuf to str");

    let first_line = read_first_line(full_path).expect("Failed to read the first line");

    let copy_cmd = format!(
        "\\copy \"{}\".\"{}\"({}) FROM '{}' WITH CSV HEADER DELIMITER ','",
        table_schema, table_name, first_line, full_path_str
    );

    let output = Command::new("psql")
        .env("PGPASSWORD", password)
        .arg("-U")
        .arg(username)
        .arg("-h")
        .arg(host)
        .arg("-d")
        .arg(dbname)
        .arg("-c")
        .arg(copy_cmd)
        .output()?;

    if output.status.success() {
        if !output.stdout.is_empty() {
            info!(
                "{}.{}: {}",
                table_name,
                table_schema,
                String::from_utf8_lossy(&output.stdout)
            );
        }
    } else {
        if !output.stderr.is_empty() {
            warn!("Error: {}", String::from_utf8_lossy(&output.stderr));
        }
    }

    Ok(())
}

async fn execute_ddl_file(
    dbname: &str,
    username: &str,
    password: &str,
    host: &str,
    path: &PathBuf,
) -> io::Result<()> {
    let full_path: PathBuf = path.canonicalize()?;
    let full_path_clone = full_path.clone();
    let full_path_str = full_path_clone
        .to_str()
        .expect("Failed to convert PathBuf to str");

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
