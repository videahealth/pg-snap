use std::collections::HashSet;
use std::fs::File;
use std::path::{Path, PathBuf};
use std::process::Command;

use tokio::task::{JoinError, JoinSet};
use tokio::{fs, task};
use tokio_postgres::Row;

use crate::db::Db;
use crate::structs::PgTable;
use crate::utils::ask_for_confirmation;
use anyhow::{anyhow, Error, Result};
use rand::distributions::Alphanumeric;
use rand::{thread_rng, Rng};
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

    let ext_tables = get_tables_from_extensions(&db, &user, &pw, &host)
        .await
        .expect("Error getting table extensions");
    let ext_tables_set: HashSet<String> = ext_tables
        .into_iter()
        .map(|v| format!("{}.{}", v.schema_name, v.table_name))
        .collect();

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
        let ext_tables_set_clone = ext_tables_set.clone();

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
                &ext_tables_set_clone,
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

    match write_seq(&db, &user, &pw, &host).await {
        Err(e) => warn!("Error executing SEQ updates: {}", e),
        Ok(_) => info!("Executed SEQ updates"),
    }
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

fn read_first_line(path: PathBuf) -> Result<String> {
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
        None => Err(anyhow!("File was empty")),
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
    ext_tables: &HashSet<String>,
) -> Result<()> {
    let full_path: PathBuf = path.canonicalize()?;
    let full_path_clone = full_path.clone();
    let full_path_str = full_path_clone
        .to_str()
        .expect("Failed to convert PathBuf to str");

    let full_table_name = format!("{}.{}", table_schema, table_name);

    let mut table_to_copy = table_name.to_owned();
    let mut schema_to_copy: Option<String> = Some(table_schema.to_owned());

    let mut is_tmp_table = false;

    if ext_tables.contains(&full_table_name) {
        let db = Db::connect(
            host.to_string(),
            username.to_string(),
            dbname.to_string(),
            password.to_string(),
        )
        .await
        .expect("Unable to connect to db");
        let tmp_table = create_temp_table(&db, table_to_copy.as_str(), table_schema).await?;
        table_to_copy = tmp_table;
        schema_to_copy = None;
        is_tmp_table = true;
    }

    let first_line = read_first_line(full_path).expect("Failed to read the first line");

    let copy_cmd = match schema_to_copy {
        Some(schema) => format!(
            "\\copy \"{}\".\"{}\"({}) FROM '{}' WITH CSV HEADER DELIMITER ','",
            schema, table_to_copy, first_line, full_path_str
        ),
        None => format!(
            "\\copy \"{}\"({}) FROM '{}' WITH CSV HEADER DELIMITER ','",
            table_to_copy, first_line, full_path_str
        ),
    };

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
                table_schema,
                table_name,
                String::from_utf8_lossy(&output.stdout)
            );
        }

        if is_tmp_table {
            let db = Db::connect(
                host.to_string(),
                username.to_string(),
                dbname.to_string(),
                password.to_string(),
            )
            .await?;
            copy_from_tmp_table(
                &db,
                format!("\"{}\".\"{}\"", table_schema, table_to_copy).as_str(),
                format!("\"{}\"", table_to_copy).as_str(),
            )
            .await?;
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
) -> Result<()> {
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

async fn write_seq(dbname: &str, username: &str, password: &str, host: &str) -> Result<(), Error> {
    let db = Db::connect(
        host.to_string(),
        username.to_string(),
        dbname.to_string(),
        password.to_string(),
    )
    .await
    .expect("Unable to connect to db");

    db.client.execute("
    with sequences as (select *
            from (select table_schema,
                        table_name,
                        column_name,
                        pg_get_serial_sequence(format('%I.%I', table_schema, table_name),
                                                column_name) as col_sequence
                from information_schema.columns
                where table_schema not in ('pg_catalog', 'information_schema')) t
            where col_sequence is not null),
    maxvals as (select table_schema,
                table_name,
                column_name,
                col_sequence,
                (xpath('/row/max/text()',
                        query_to_xml(format('select max(%I) from %I.%I', column_name, table_schema, table_name),
                                    true, true, ''))
                    )[1]::text::bigint as max_val
        from sequences)
    select table_schema,
    table_name,
    column_name,
    col_sequence,
    coalesce(max_val, 0) as max_val,
    setval(col_sequence, coalesce(max_val, 1)) --<< this will change the sequence
    from maxvals;
    ", &[]).await?;

    Ok(())
}

fn rnd_string() -> String {
    thread_rng()
        .sample_iter(&Alphanumeric)
        .take(10)
        .map(|x| x as char)
        .collect()
}

async fn create_temp_table(db: &Db, table_name: &str, table_schema: &str) -> Result<String, Error> {
    let tmp_table_name = format!("{}_{}", table_name, rnd_string());

    let stmnt = format!(
        "
    CREATE TABLE \"{}\"
    AS
    SELECT * 
    FROM \"{}\".\"{}\"
    WITH NO DATA;
    ",
        tmp_table_name, table_schema, table_name
    );

    db.client.execute(stmnt.as_str(), &[]).await?;

    Ok(tmp_table_name)
}

async fn copy_from_tmp_table(db: &Db, main_table: &str, tmp_table: &str) -> Result<(), Error> {
    let stmnt = format!(
        "
        INSERT INTO {}
        SELECT *
        FROM {}
        ON CONFLICT DO NOTHING
    ",
        main_table, tmp_table
    );

    db.client.execute(stmnt.as_str(), &[]).await?;
    db.client
        .execute(format!("DROP TABLE {}", tmp_table).as_str(), &[])
        .await?;

    Ok(())
}

struct ExtTables {
    table_name: String,
    schema_name: String,
}

impl ExtTables {
    pub fn from_cols(columns: &Vec<Row>) -> Vec<ExtTables> {
        let mut table_cols = vec![];

        for column in columns {
            let table_name: &str = column.get(0);
            let schema_name: &str = column.get(1);

            table_cols.push(ExtTables {
                table_name: table_name.to_string(),
                schema_name: schema_name.to_string(),
            });
        }

        table_cols
    }
}

async fn get_tables_from_extensions(
    dbname: &str,
    username: &str,
    password: &str,
    host: &str,
) -> Result<Vec<ExtTables>> {
    let db = Db::connect(
        host.to_string(),
        username.to_string(),
        dbname.to_string(),
        password.to_string(),
    )
    .await
    .expect("Unable to connect to db");

    let columns = db
        .client
        .query(
            "
    SELECT
    cl.relname AS table_name,
    ns.nspname AS schema_name,
    ext.extname AS extension_name
  FROM pg_class cl
  JOIN pg_namespace ns ON cl.relnamespace = ns.oid
  JOIN pg_depend dep ON dep.objid = cl.oid
  JOIN pg_extension ext ON dep.refobjid = ext.oid
  WHERE cl.relkind = 'r'
    AND ns.nspname NOT IN ('pg_catalog', 'information_schema');  
    ",
            &[],
        )
        .await?;

    Ok(ExtTables::from_cols(&columns))
}
