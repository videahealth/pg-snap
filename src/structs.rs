use std::collections::HashMap;
use std::path::PathBuf;
use tokio::io::AsyncReadExt;
use tokio::io::AsyncWriteExt;

use anyhow::Result;
use tokio::fs::File;

use crate::db::Constraint;
use crate::db::ForeignKey;
use crate::db::Index;
use crate::db::UserDefinedEnum;

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct PgDb {
    pub relations: Vec<ForeignKeyRelation>,
    pub table_map: HashMap<String, PgTable>,
    pub extensions: HashMap<String, String>,
    pub user_defined_enums: Vec<UserDefinedEnum>,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct PgTable {
    pub schema: String,
    pub name: String,
    // pub columns: Vec<TableColumns>,
    pub data_file: PathBuf,
}

impl PgTable {
    pub fn new(
        name: String,
        schema: String,
        data_file: PathBuf,
        // columns: Vec<TableColumns>,
    ) -> Self {
        PgTable {
            name,
            schema,
            // columns,
            data_file,
        }
    }

    pub async fn save_to_file(&self, path: PathBuf) -> Result<()> {
        // Serialize the struct to binary
        let serialized_data = bincode::serialize(self)?;

        // Write the binary data to a file
        let mut file = File::create(path).await?;
        file.write_all(&serialized_data).await?;

        Ok(())
    }

    pub async fn from_file(path: PathBuf) -> Result<Self> {
        // Open the file and read its contents
        let mut file = File::open(path).await?;
        let mut buffer = Vec::new();
        file.read_to_end(&mut buffer).await?;

        // Deserialize the binary data into the struct
        let deserialized: Self = bincode::deserialize(&buffer)?;

        Ok(deserialized)
    }
}

#[derive(Debug, PartialEq, Eq, Clone, Serialize, Deserialize)]
pub struct ForeignKeyRelation {
    pub foreign_table: String,
    pub primary_table: String,
    pub foreign_column: String,
    pub primary_column: String,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct TableDDL {
    pub foreign_keys: Vec<ForeignKey>,
    pub constraints: Vec<Constraint>,
    pub indexes: Vec<Index>,
}
