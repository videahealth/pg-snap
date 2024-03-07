use anyhow::Result;
use colored::Colorize;
use log::info;
use std::path::PathBuf;
use tokio::task::{self, JoinError, JoinSet};
mod dag_custom;

use crate::{
    config::SubsetConfig,
    db::{
        table::{ForeignKeyInfo, Table},
        Db,
    },
};

use self::subset::Subset;

mod dag;
mod subset;

type ThreadResult = Result<(), Box<dyn std::error::Error + Send>>;
type JoinSetResult = Result<ThreadResult, JoinError>;

pub struct DbWalk {
    db: Db,
    subset_config: Option<SubsetConfig>,
    tables: Vec<Table>,
    relations: Vec<ForeignKeyInfo>,
    root_folder: PathBuf,
    concurrency: Option<usize>,
}

impl DbWalk {
    pub fn new(
        db: Db,
        relations: Vec<ForeignKeyInfo>,
        tables: Vec<Table>,
        subset_config: Option<SubsetConfig>,
        root_folder: PathBuf,
        concurrency: Option<usize>,
    ) -> DbWalk {
        DbWalk {
            subset_config,
            db,
            relations,
            tables,
            root_folder,
            concurrency,
        }
    }

    pub async fn run(&self) -> Result<()> {
        let subset_config = self.subset_config.clone();
        match subset_config {
            Some(cfg) => {
                let subset = Subset::new(
                    self.tables.clone(),
                    self.relations.clone(),
                    self.db.clone(),
                    cfg.table,
                    cfg.schema,
                    self.root_folder.clone(),
                    cfg.max_rows_per_table,
                    cfg.where_clause,
                );
                subset.traverse_and_copy_data().await?;
                Ok(())
            }
            None => {
                let concurrency = self.concurrency.unwrap_or(1);

                let mut join_set: JoinSet<JoinSetResult> = JoinSet::new();

                for table in self.tables.clone() {
                    while join_set.len() >= concurrency {
                        let _ = join_set.join_next().await.unwrap().unwrap();
                    }

                    let folder = self.root_folder.clone();
                    let new_db = self.db.clone();
                    let table = table.clone();

                    let handle = task::spawn(async move {
                        copy_data(new_db, folder, table, None).await.unwrap();
                        Ok::<(), Box<dyn std::error::Error + Send>>(())
                    });

                    join_set.spawn(handle);
                }

                while let Some(output) = join_set.join_next().await {
                    if let Err(e) = output? {
                        eprintln!("Error in worker: {e}");
                    }
                }

                Ok(())
            }
        }
    }
}

pub async fn copy_data(db: Db, root_dir: PathBuf, table: Table, query: Option<&str>) -> Result<()> {
    let data_dir = table.get_data_dir(&root_dir)?;
    let num_rows = db.copy_out(&data_dir, table.id.as_str(), query).await?;
    info!(
        "Copied {} rows from {}",
        num_rows.to_string().green(),
        table.details.display.yellow()
    );
    table.save_to_file(&root_dir).await?;
    Ok(())
}
