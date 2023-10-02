use crate::{
    db::Db,
    structs::{PgTable, TableColumns},
    utils::{
        create_and_canonicalize_path, extract_and_remove_fk_constraints, parse_skip_schemas,
        parse_skip_tables, should_skip,
    },
};
use futures::StreamExt;
use std::{
    collections::{HashMap, HashSet},
    fs,
    path::{Path, PathBuf},
    process::Command,
    sync::Arc,
};
use tokio::{
    fs::File,
    io::AsyncWriteExt,
    sync::Mutex,
    task::{self, JoinError, JoinSet},
};
use tokio_postgres::{Client, Error, Row};

pub async fn dump_db(
    host: String,
    user: String,
    db: String,
    pw: String,
    skip_tables_str: Option<String>,
) -> Result<(), Error> {
    let pg = Db::connect(host.clone(), user.clone(), db.clone(), pw.clone())
        .await
        .expect("Error connecting to db");

    let skip_tables = match skip_tables_str.clone() {
        Some(tbls) => parse_skip_tables(&tbls),
        None => HashSet::new(),
    };
    let skip_schemas = match skip_tables_str {
        Some(schem) => parse_skip_schemas(&schem),
        None => HashSet::new(),
    };

    // Now we can execute a simple statement that just returns its parameter.
    let query_rows = pg.client
        .query("SELECT schemaname, tablename FROM pg_catalog.pg_tables WHERE schemaname NOT LIKE 'pg_%' AND schemaname != 'information_schema'", &[])
        .await?;

    let rows: Vec<Row> = query_rows
        .into_iter()
        .filter(|r| {
            let table_schema: &str = r.get(0);
            let table_name: &str = r.get(1);

            if should_skip(table_schema, table_name, &skip_tables) {
                info!("Skipping table {table_schema}.{table_name}");
                false
            } else {
                true
            }
        })
        .collect();

    let base_dir = format!("./data-dump");
    let base_dir_path: &Path = base_dir.as_ref();
    fs::create_dir_all(base_dir.clone()).expect("Error creating directory");

    const MAX_WORKERS: usize = 5;
    let mut join_set: JoinSet<Result<Result<(), Box<dyn std::error::Error + Send>>, JoinError>> =
        JoinSet::new();

    let table_map = Arc::new(Mutex::new(HashMap::new()));

    for table in rows {
        while join_set.len() >= MAX_WORKERS {
            let _ = join_set.join_next().await.unwrap().unwrap();
        }

        let host_clone = host.clone();
        let user_clone = user.clone();
        let db_clone = db.clone();
        let pw_clone = pw.clone();
        let base_dir_clone = base_dir.clone();
        let table_map_clone = table_map.clone();

        let handle = task::spawn(async move {
            let pg_db = Db::connect(host_clone, user_clone, db_clone, pw_clone)
                .await
                .expect("Error connecting to db");
            let client = &pg_db.client;

            let table_schema: &str = table.get(0);
            let table_name: &str = table.get(1);

            info!("Dumping table {table_schema}.{table_name}");

            // Fetch column details for each table
            let columns = pg_db
                .get_table_details(table_name)
                .await
                .expect("Error could now retrieve columns");

            let table_dir = format!("{}/{}", base_dir_clone, table_name);
            let table_path = Path::new(&table_dir);
            fs::create_dir_all(&table_path).expect("Error creating directory");

            let data_path = table_path.join("data.csv");
            let table_data_path = table_path.join("table.bin");

            info!(
                "Fetching data from postgres {}.{}",
                table_schema, table_name
            );
            info!("Writing out results {}.{}", table_schema, table_name);

            if let Err(e) = write_rows_to_csv(&client, &data_path, table_name, table_schema).await {
                fs::remove_dir_all(&table_path).expect("Failed to delete directory");
                panic!("Failed to write: {}", e);
            }

            let pg_table = PgTable::new(
                table_name.to_string(),
                table_schema.to_string(),
                data_path,
                TableColumns::from_cols(&columns),
            );
            pg_table
                .save_to_file(table_data_path)
                .await
                .expect("Error saving table info");

            let mut map = table_map_clone.lock().await;
            map.insert(format!("{table_schema}.{table_name}"), pg_table);

            Ok::<(), Box<dyn std::error::Error + Send>>(())
        });

        join_set.spawn(handle);
    }

    while let Some(output) = join_set.join_next().await {
        match output.expect("Error in worker") {
            Err(e) => eprintln!("Error in worker: {e}"),
            Ok(_) => (),
        }
    }

    let skip_tables_vec = skip_tables.into_iter().collect();
    let skip_schemas_vec = skip_schemas.into_iter().collect();

    let res = dump_schema_to_file(
        &user,
        &pw,
        &host,
        5432,
        &db,
        skip_tables_vec,
        skip_schemas_vec,
    )
    .expect("Error writing sql file");

    let fk_content_path = base_dir_path.join("fk_constraints.sql");
    let ddl_content_path = base_dir_path.join("ddl.sql");

    let (fk_commands, other_commands) =
        extract_and_remove_fk_constraints(res).expect("Error extracting DDL file");

    fs::write(fk_content_path, fk_commands).expect("Err");
    fs::write(ddl_content_path, other_commands).expect("Err");

    Ok(())
}

async fn write_rows_to_csv(
    client: &Client,
    path: &PathBuf,
    table_name: &str,
    table_schema: &str,
) -> Result<(), Error> {
    let full_path: PathBuf = create_and_canonicalize_path(path).expect("Error reading file");

    let path_str: &str = full_path
        .to_str()
        .expect("Failed to convert PathBuf to str");

    let copy_cmd = format!(
        "COPY \"{table_schema}\".\"{table_name}\" TO STDOUT WITH CSV HEADER DELIMITER ','",
        table_schema = table_schema,
        table_name = table_name
    );

    let stmt = client.prepare(copy_cmd.as_str()).await?;
    let unpinned_stream = client.copy_out(&stmt).await?;

    // Open a file to write to
    let mut file = File::create(Path::new(path_str))
        .await
        .expect("Error creating file");
    let mut stream = Box::pin(unpinned_stream); // pin the stream

    // Stream through the result and write to the file
    while let Some(row) = stream.next().await {
        match row {
            Ok(bytes) => {
                file.write(&bytes).await.expect("Error writing file");
            }
            Err(err) => {
                eprintln!("Error reading row: {}", err);
                return Err(err);
            }
        }
    }

    Ok(())
}

pub fn dump_schema_to_file(
    username: &str,
    password: &str,
    host: &str,
    port: u16,
    dbname: &str,
    exclude_tables: Vec<String>,
    exclude_schemas: Vec<String>,
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

    for table in exclude_tables {
        command.arg("-T").arg(table);
    }

    for schema in exclude_schemas {
        command.arg("--exclude-schema").arg(schema);
    }

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
