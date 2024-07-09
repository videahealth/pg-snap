use anyhow::{Context, Result};
use serde::{Deserialize, Serialize};
use std::fs::File;
use std::io::{self, Read};
use std::path::PathBuf;

#[derive(Serialize, Deserialize, Debug)]
pub struct Config {
    pub subset: Option<SubsetConfig>,
    pub skip_tables: Vec<String>,
    pub skip_schemas: Vec<String>,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct SubsetConfig {
    pub table: String,
    pub schema: String,
    pub where_clause: String,
    pub max_rows_per_table: Option<i32>,
    pub max_cycles: Option<usize>,
    pub passthrough: Option<Vec<String>>,
}

pub fn load_config(path: &PathBuf) -> Result<Config> {
    let file =
        File::open(path).context(format!("opening config file: {path:?} file does not exist"))?;
    let mut bytes = Vec::new();
    let mut reader = io::BufReader::new(file);
    reader
        .read_to_end(&mut bytes)
        .context("Error reading config file")?;

    let config: Config =
        serde_json::from_slice(&bytes).context("Error deserializing config file")?;

    Ok(config)
}
