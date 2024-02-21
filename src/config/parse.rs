use std::{fs::File, path::Path};

use serde::{Deserialize, Serialize};
use std::io::Read;

#[derive(Serialize, Deserialize, Debug)]
pub struct JsonConfig {
    pub skip_tables: Vec<String>,
    pub sample: JsonSample,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct JsonSample {
    pub start: JsonTableInfo,
    pub default_order_by: String,
    pub tables: Vec<JsonTable>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub default_rows: Option<u32>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct JsonTableInfo {
    pub name: String,
    pub schema: String,
    pub rows: u32,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct JsonTable {
    pub name: String,
    pub schema: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub rows: Option<u32>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub default_order_by: Option<String>,
}

impl JsonConfig {
    pub fn new<P: AsRef<Path>>(path: P) -> anyhow::Result<Self> {
        let mut file = File::open(path)?;
        let mut contents = String::new();
        file.read_to_string(&mut contents)?;
        let config: JsonConfig = serde_json::from_str(&contents)?;
        Ok(config)
    }
}
