use anyhow::Result;
use colored::Colorize;
use log::{info, warn};
use std::{collections::HashSet, path::PathBuf};
use tokio::task::{self, JoinError, JoinSet};

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

    pub async fn concurrently_copy(&self, tables: &[Table]) -> Result<()> {
        let concurrency = self.concurrency.unwrap_or(1);

        let mut join_set: JoinSet<JoinSetResult> = JoinSet::new();

        for table in tables {
            while join_set.len() >= concurrency {
                let _ = join_set.join_next().await.unwrap().unwrap();
            }

            let folder = self.root_folder.clone();
            let new_db = self.db.clone();
            let table = table.clone();

            let handle = task::spawn(async move {
                match copy_data(new_db, folder, table.clone(), None).await {
                    Err(e) => warn!("Error copying table {}: {e}", table.id),
                    Ok(_) => {}
                }
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

    pub async fn run(&self) -> Result<()> {
        let subset_config = self.subset_config.clone();
        match subset_config {
            Some(cfg) => {
                let cycles = cfg.max_cycles.unwrap_or(1);
                let subset = Subset::new(
                    self.tables.clone(),
                    self.relations.clone(),
                    self.db.clone(),
                    cfg.table,
                    cfg.schema,
                    self.root_folder.clone(),
                    cfg.max_rows_per_table,
                    cfg.where_clause,
                    cycles,
                );
                let subset_tables = subset.traverse_and_copy_data().await?;

                if let Some(passthrough) = cfg.passthrough {
                    let passthrough_map: HashSet<_> = passthrough.clone().into_iter().collect();
                    let intersection: HashSet<_> = subset_tables
                        .intersection(&passthrough_map)
                        .cloned()
                        .collect();
                    for int in intersection {
                        warn!(
                            "Overwriting subset table {} since its also in passthrough",
                            int
                        );
                    }

                    let tables_to_copy: Vec<_> = self
                        .tables
                        .clone()
                        .into_iter()
                        .filter(|v| passthrough_map.contains(&v.details.display))
                        .collect();

                    if !tables_to_copy.is_empty() {
                        self.concurrently_copy(&tables_to_copy).await?
                    }
                }
                Ok(())
            }
            None => self.concurrently_copy(&self.tables).await,
        }
    }
}

pub async fn copy_data(
    db: Db,
    root_dir: PathBuf,
    table: Table,
    query: Option<&str>,
) -> Result<u64> {
    let data_dir = table.get_data_dir(&root_dir)?;
    let num_rows = db.copy_out(&data_dir, table.id.as_str(), query).await?;
    info!(
        "Copied {} rows from {}",
        num_rows.to_string().green(),
        table.details.display.yellow()
    );
    table.save_to_file(&root_dir).await?;
    Ok(num_rows)
}
