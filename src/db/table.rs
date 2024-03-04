use anyhow::Result;
use serde::{Deserialize, Serialize};
use std::{
    fs,
    path::{Path, PathBuf},
};
use tokio::fs::File;
use tokio::io::AsyncWriteExt;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Col {
    pub name: String,
    pub col_type: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TableInfo {
    pub name: String,
    pub schema: String,
    pub identifier: String,
    pub display: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Table {
    pub details: TableInfo,
    pub id: String,
    pub sample_query: Option<String>,
    pub num_rows: Option<i64>,
    pub cols: Vec<Col>,
}

#[derive(Debug, Clone)]
pub struct ForeignKeyInfo {
    pub schema: String,
    pub name: String,
    pub column_name: String,
    pub foreign_schema: String,
    pub foreign_name: String,
    pub foreign_column_name: String,
    pub source_table_id: String,
    pub foreign_table_id: String,
    pub foreign_col_type: String,
    pub col_type: String,
}

impl Table {
    pub fn new(name: String, schema: String, cols: Vec<Col>) -> Table {
        let identifier = format!("\"{}\".\"{}\"", schema, name);
        let display = format!("{}.{}", schema, name);
        let details = TableInfo {
            display,
            identifier: identifier.clone(),
            name,
            schema,
        };
        Table {
            cols,
            details,
            id: identifier,
            num_rows: None,
            sample_query: None,
        }
    }

    pub fn get_data_dir(&self, root: &PathBuf) -> Result<PathBuf> {
        let name = &self.details.display;
        let folder = Path::new(root).join(name);
        fs::create_dir_all(folder.clone()).expect("Error getting data dir for table");
        let file = folder.join("data.csv");
        Ok(file)
    }

    pub async fn save_to_file(&self, root: &PathBuf) -> Result<()> {
        let name = &self.details.display;
        let folder = Path::new(root).join(name);
        fs::create_dir_all(folder.clone()).expect("Error getting data dir for table");
        let file = folder.join("table.bin");

        let serialized_data = bincode::serialize(self)?;
        let mut file = File::create(file).await?;
        file.write_all(&serialized_data).await?;

        Ok(())
    }

    pub async fn from_file(path: &PathBuf) -> Result<Self> {
        let contents = fs::read(path)?;
        let deserialized: Self = bincode::deserialize(&contents)?;
        Ok(deserialized)
    }
}

impl ForeignKeyInfo {
    pub fn new(
        schema: String,
        name: String,
        column_name: String,
        foreign_schema: String,
        foreign_name: String,
        foreign_column_name: String,
        foreign_col_type: String,
        col_type: String,
    ) -> ForeignKeyInfo {
        let source_table_id = format!("\"{}\".\"{}\"", schema, name);
        let foreign_table_id = format!("\"{}\".\"{}\"", foreign_schema, foreign_name);

        ForeignKeyInfo {
            schema,
            name,
            column_name,
            foreign_schema,
            foreign_name,
            foreign_column_name,
            source_table_id,
            foreign_table_id,
            foreign_col_type,
            col_type,
        }
    }
}
