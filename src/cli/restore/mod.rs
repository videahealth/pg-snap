use crate::{
    db::{table::Table, Db},
    local::Local,
    pg_command::PgCommand,
    utils::ask_for_confirmation,
};
use log::{info, warn};
use std::{
    collections::HashSet,
    fs,
    path::{Path, PathBuf},
};
use tokio::task::{self, JoinError, JoinSet};

use super::{Command, DbParams, Restore};
use anyhow::{anyhow, Context, Result};
use colored::Colorize;

pub struct RestoreCmd {
    pub concurrency: Option<usize>,
    pub db: DbParams,
    pub file: String,
    pub skip_confirmation: bool,
}

impl RestoreCmd {
    pub fn new(args: Restore) -> Self {
        Self {
            concurrency: args.common.concurrency,
            file: args.dump_path,
            skip_confirmation: args.yes,
            db: DbParams {
                db: args.db.db,
                host: args.db.host,
                password: args.db.password,
                username: args.db.username,
                port: args.db.port,
            },
        }
    }
}

impl Command for RestoreCmd {
    async fn run(&self) -> Result<()> {
        let local =
            Local::load(&self.file).context("Error reading input file archive or dump folder")?;

        let tables = local
            .load_pg_tables()
            .await
            .context("Error deserializing pg tables")?;
        let latest_dir = local.dump_dir().context("Error getting dump directory")?;
        let conn = Db::connect(self.db.clone())
            .await
            .context("Error connecting to db")?;
        let mut new_db = Db::new(self.db.clone(), conn)
            .await
            .context("Error initializing db")?;

        let ext_tables = new_db
            .get_extension_tables()
            .await
            .context("Error querying pg")?;
        let ext_tables_set: HashSet<String> = ext_tables
            .into_iter()
            .map(|v| format!("{}.{}", v.schema, v.name))
            .collect();

        let concurrency = self.concurrency.unwrap_or(1);

        let conf_string = format!(
            "Warning! this operation will drop the database {}, do you wish to continue?",
            self.db.db
        );

        if !self.skip_confirmation {
            ask_for_confirmation(&conf_string);
        }

        new_db.recreate_database().await?;

        let ddl_path = Path::new(&latest_dir).join("ddl.sql");
        let fk_path = Path::new(&latest_dir).join("foreign_keys.sql");

        let ddl_path_str = ddl_path.to_str().ok_or(anyhow!("Error getting DDL path"))?;
        let fk_path_str = fk_path.to_str().ok_or(anyhow!("Error getting FK path"))?;

        let pg_command = PgCommand::new(&self.db);

        info!("Applying database DDL");
        pg_command
            .restore(ddl_path_str)
            .context("Error running psql command")?;

        let mut join_set: JoinSet<Result<(), JoinError>> = JoinSet::new();

        info!("Restoring {} tables", tables.len());
        for tbl in tables {
            let ext_tables_set_clone = ext_tables_set.clone();
            let database = new_db.clone();
            let latest_dir_clone = latest_dir.clone();

            while join_set.len() >= concurrency {
                let _ = join_set.join_next().await.unwrap().unwrap();
            }

            let handle = task::spawn(async move {
                match &tbl.get_data_dir(&latest_dir_clone) {
                    Ok(path) => {
                        if let Err(e) = read_from_file_and_write_to_db(
                            path,
                            &tbl,
                            &database,
                            &ext_tables_set_clone,
                        )
                        .await
                        {
                            warn!(
                                "Error copying data for table: {}.{}: {}",
                                tbl.details.schema, tbl.details.name, e
                            );
                        }
                    }
                    Err(e) => {
                        warn!(
                            "Error getting data path for table: {}.{}: {}",
                            tbl.details.schema, tbl.details.name, e
                        );
                    }
                }
            });

            join_set.spawn(handle);
        }

        while let Some(output) = join_set.join_next().await {
            if let Err(e) = output? {
                eprintln!("Error in worker: {e}")
            }
        }

        info!("Applying database foreign keys");
        pg_command
            .restore(fk_path_str)
            .context("Error running psql command")?;

        fs::remove_dir_all(local.root_path)?;

        match new_db.write_table_sequences().await {
            Err(e) => {
                warn!("Error executing SEQ updates: {}", e);
                Ok(())
            }
            Ok(_) => {
                info!("Executed SEQ updates");
                Ok(())
            }
        }
    }
}

async fn read_from_file_and_write_to_db(
    path: &Path,
    table: &Table,
    pg: &Db,
    ext_tables: &HashSet<String>,
) -> Result<()> {
    let full_path: PathBuf = path.canonicalize()?;

    let full_table_name = format!("{}.{}", table.details.schema, table.details.name);

    let mut table_to_copy = table.details.name.to_owned();
    let mut schema_to_copy: Option<&str> = Some(table.details.schema.as_str());

    let mut is_tmp_table = false;

    if ext_tables.contains(&full_table_name) {
        let tmp_table = pg
            .create_temp_table(table_to_copy, table.details.schema.to_string())
            .await?;

        table_to_copy = tmp_table;
        schema_to_copy = None;
        is_tmp_table = true;
    }
    match pg
        .copy_in(&full_path, table_to_copy.as_str(), schema_to_copy)
        .await
    {
        Ok(v) => {
            info!(
                "Copied {} rows from {}",
                v.to_string().green(),
                table.details.display.yellow()
            );
            if is_tmp_table {
                pg.copy_from_tmp_table(
                    format!("\"{}\".\"{}\"", table.details.schema, table.details.name).as_str(),
                    format!("\"{}\"", table_to_copy).as_str(),
                )
                .await?;
            }
        }
        Err(e) => {
            warn!(
                "Error copying for table {}.{}: {}",
                table.details.schema, table.details.name, e
            );
        }
    }

    Ok(())
}
