use std::{collections::HashMap, path::Path};

use self::parse::JsonConfig;

mod parse;

#[derive(Debug)]
pub struct Config {
    pub skip_tables: Vec<String>,
    pub sample: Sample,
}

#[derive(Debug)]
pub struct Sample {
    pub start: TableInfo,
    pub default_order_by: String,
    pub tables: HashMap<String, Table>,
    pub default_rows: Option<u32>,
}

#[derive(Debug)]
pub struct TableInfo {
    pub name: String,
    pub schema: String,
    pub rows: u32,
}

#[derive(Debug)]
pub struct Table {
    pub name: String,
    pub schema: String,
    pub rows: Option<u32>,
    pub default_order_by: Option<String>,
}

impl Config {
    pub fn new<P: AsRef<Path>>(path: P) -> anyhow::Result<Self> {
        let cfg = JsonConfig::new(path)?;
        let mut sample_tables = HashMap::<String, Table>::new();

        let tables = cfg.sample.tables;

        for table in tables {
            let key = format!("{}.{}", table.schema, table.name);
            if sample_tables.contains_key(&key.to_owned()) {
                return Err(anyhow::anyhow!(
                    "{}.{} table has duplicate entries",
                    table.schema,
                    table.name
                ));
            }
            sample_tables.insert(
                key.to_owned(),
                Table {
                    default_order_by: table.default_order_by,
                    name: table.name,
                    rows: table.rows,
                    schema: table.schema,
                },
            );
        }

        let sample = Sample {
            default_order_by: cfg.sample.default_order_by,
            default_rows: cfg.sample.default_rows,
            start: TableInfo {
                name: cfg.sample.start.name,
                rows: cfg.sample.start.rows,
                schema: cfg.sample.start.schema,
            },
            tables: sample_tables,
        };

        Ok(Config {
            sample,
            skip_tables: cfg.skip_tables,
        })
    }
}
