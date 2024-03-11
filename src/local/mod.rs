use std::{
    ffi::OsStr,
    fs::{self, remove_file, OpenOptions},
    path::{Path, PathBuf},
};

use crate::db::table::Table;
use anyhow::{anyhow, Context, Result};

use self::zip::{compress, decompress};

mod zip;

pub struct Local {
    pub root_path: PathBuf,
    output_name: String,
}

impl Local {
    pub fn new(name: &str) -> Local {
        let root = Path::new(".").join(name);
        let root_path = PathBuf::from(root);
        Local {
            root_path,
            output_name: name.to_owned(),
        }
    }

    pub fn load(name: &str) -> Result<Local> {
        let mut root: PathBuf = Path::new(".").join(name);
        if !root.exists() {
            return Err(anyhow!("Given file: {} does not exist", name));
        }
        if root.is_file() && root.extension().and_then(OsStr::to_str) == Some("zip") {
            let orig_root = root.clone();
            let str_file = root.to_str().ok_or(anyhow!("Error getting zip file"))?;
            root = decompress(str_file).context("decompressing file")?;
            remove_file(&orig_root).map_err(|err| anyhow!("Failed to delete zip file: {}", err))?;
        }

        let root_path = if root.is_dir() {
            root
        } else {
            root.parent()
                .unwrap_or_else(|| Path::new("."))
                .to_path_buf()
        };

        return Ok(Local {
            root_path,
            output_name: name.to_owned(),
        });
    }

    pub fn dump_dir(&self) -> Result<&PathBuf> {
        if !Path::new(&self.root_path).exists() {
            fs::create_dir_all(&self.root_path).context("Error creating directory for dump")?;
        }
        Ok(&self.root_path)
    }

    pub fn get_dump_file(&self) -> Result<PathBuf> {
        let latest_dir = self.dump_dir()?;
        let output_path = Path::new(&latest_dir).join("dump.sql");
        let _ = OpenOptions::new()
            .read(true)
            .write(true)
            .create(true)
            .open(&output_path);
        let abs = fs::canonicalize(&output_path).context("Error conoicalizing dump file path")?;
        Ok(abs)
    }

    pub async fn load_pg_tables(&self) -> Result<Vec<Table>> {
        let latest_dir = self.dump_dir()?;
        let latest_path = PathBuf::from(latest_dir);
        let mut tables: Vec<Table> = Vec::new();

        for entry in fs::read_dir(latest_path)? {
            let entry = entry?;
            let path = entry.path();

            if path.is_dir() {
                let table_data = Path::new(&path).join("table.bin");
                let table = Table::from_file(&table_data).await?;
                tables.push(table);
            }
        }

        Ok(tables)
    }

    pub fn compress(&self) -> Result<String> {
        let comp_dir = self
            .root_path
            .to_str()
            .ok_or(anyhow!("Error getting output dir"))?;
        let root_path = Path::new(".").join(format!("{}.zip", self.output_name));
        let root = root_path
            .to_str()
            .ok_or(anyhow!("Error getting output dir"))?;
        compress(comp_dir, root)?;
        fs::remove_dir_all(&self.root_path)?;
        Ok(comp_dir.to_string())
    }
}
