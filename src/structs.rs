use std::collections::HashMap;
use std::path::PathBuf;
use std::vec;

use tokio::io::AsyncReadExt;
use tokio::io::AsyncWriteExt;

use tokio::fs::File;
use tokio_postgres::Row;

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
pub struct TableColumns {
    pub column_name: String,
    pub data_type: String,
    pub is_nullable: String,
}

impl TableColumns {
    pub fn from_cols(columns: &Vec<Row>) -> Vec<TableColumns> {
        let mut table_cols = vec![];

        for column in columns {
            let column_name: &str = column.get(0);
            let data_type: &str = column.get(1);
            let is_nullable: &str = column.get(2);

            table_cols.push(TableColumns {
                column_name: column_name.to_string(),
                data_type: data_type.to_string(),
                is_nullable: is_nullable.to_string(),
            });
        }

        table_cols
    }
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct PgTable {
    pub schema: String,
    pub name: String,
    pub columns: Vec<TableColumns>,
    pub data_file: PathBuf,
}

impl PgTable {
    pub fn new(
        name: String,
        schema: String,
        data_file: PathBuf,
        columns: Vec<TableColumns>,
    ) -> Self {
        PgTable {
            name,
            schema,
            columns,
            data_file,
        }
    }

    pub async fn save_to_file(&self, path: PathBuf) -> Result<(), Box<dyn std::error::Error>> {
        // Serialize the struct to binary
        let serialized_data = bincode::serialize(self)?;

        // Write the binary data to a file
        let mut file = File::create(path).await?;
        file.write_all(&serialized_data).await?;

        Ok(())
    }

    pub async fn from_file(path: PathBuf) -> Result<Self, Box<dyn std::error::Error>> {
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
