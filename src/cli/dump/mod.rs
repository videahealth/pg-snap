use crate::{
    config::{load_config, Config},
    db::{Db, DumpParser},
    db_walk::DbWalk,
    local::Local,
    pg_command::PgCommand,
};
use log::info;
use std::{collections::HashSet, path::PathBuf};

use super::{Command, DbParams, Dump};
use anyhow::{Context, Result};

pub struct DumpCmd {
    pub config: Option<PathBuf>,
    pub concurrency: Option<usize>,
    pub db: DbParams,
    pub compress: bool,
    pub output_name: Option<String>,
}

impl DumpCmd {
    pub fn new(args: Dump) -> Self {
        Self {
            concurrency: args.common.concurrency,
            config: args.config,
            compress: args.compress,
            output_name: args.name,
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

impl Command for DumpCmd {
    async fn run(&self) -> Result<()> {
        let output_name = if let Some(n) = self.output_name.clone() {
            n
        } else {
            self.db.db.to_owned()
        };
        let local = Local::new(&output_name);
        let root_dir = local.dump_dir().context("Error loading dump dir")?;

        let pg_command = PgCommand::new(&self.db);

        let dump_file = local.get_dump_file().context("Error loading dump file")?;

        let config: Option<Config> = if let Some(cfg_path) = &self.config {
            Some(load_config(cfg_path)?)
        } else {
            None
        };

        let (skip_tables, skip_schemas, subset_config) = match config {
            Some(c) => {
                let st: HashSet<String> = HashSet::from_iter(c.skip_tables.into_iter());
                let ss: HashSet<String> = HashSet::from_iter(c.skip_schemas.into_iter());
                let sscfg = match c.subset {
                    Some(sc) => Some(sc),
                    None => None,
                };
                (st, ss, sscfg)
            }
            None => (HashSet::new(), HashSet::new(), None),
        };

        info!("Introspecing db and taking snapshot");
        pg_command
            .dump(&dump_file, skip_tables.clone(), skip_schemas.clone())
            .context("Error running pg_dump command")?;

        // Initialize db connection and extract tables from dump file
        let conn = Db::connect(self.db.clone())
            .await
            .context("Error connecting to db")?;
        let new_db = Db::new(self.db.clone(), conn)
            .await
            .context("Error initializing db")?;

        let dump_parser = DumpParser::parse_from(&dump_file, skip_tables, skip_schemas)
            .context("Error parsing dump file")?;
        let tables = dump_parser.tables.clone();
        let relations = dump_parser.relations.clone();

        dump_parser
            .split_fk_constraints(root_dir)
            .context("Error parsing dump file fk contraints")?;

        let db_walk = DbWalk::new(
            new_db,
            relations,
            tables,
            subset_config,
            root_dir.to_path_buf(),
            self.concurrency,
        );
        db_walk.run().await.context("Error extracting data")?;

        if self.compress {
            let comp = local.compress().context("Error compressing output")?;
            info!("Created dump output in zip file: {comp}");
        } else {
            info!("Created dump output in folder: {root_dir:?}");
        }
        Ok(())
    }
}
