use std::path::PathBuf;

use sqlx::postgres::PgRow;

use crate::db::Db;

const COLUMN_DETAILS_QUERY: &str = "
    WITH types AS (
        SELECT oid, typname
        FROM pg_type
    )
    SELECT 
        attname AS column_name,
        CASE WHEN attndims = 0 THEN t.typname ELSE t.typname || '[]' END AS data_type,
        CASE WHEN attnotnull THEN 'NO' ELSE 'YES' END AS is_nullable
    FROM 
        pg_attribute 
        JOIN types t ON pg_attribute.atttypid = t.oid
    WHERE 
        attrelid = (
            SELECT oid
            FROM pg_class
            WHERE relname = $1
        ) AND 
        attnum > 0 AND 
        NOT attisdropped
";

pub struct Table {
    pub name: String,
    pub schema: String,
    pub is_extension: Option<bool>,
    db_conn: Db,
    pub full_name: String,
}

impl Table {
    pub fn new(name: String, schema: String, db_conn: Db, is_extension: Option<bool>) -> Self {
        Table {
            name,
            schema,
            is_extension,
            db_conn,
            full_name: format!("{}.{}", schema, name),
        }
    }

    pub async fn get_columns(&self) -> anyhow::Result<Vec<PgRow>> {
        let mut client = self.db_conn.connect().await?;

        let columns = sqlx::query(COLUMN_DETAILS_QUERY)
            .bind(&self.full_name)
            .fetch_all(&mut client)
            .await?;

        Ok(columns)
    }

    pub async fn copy_in(&self, out_file: &PathBuf) -> anyhow::Result<u64> {
        let mut client = self.db_conn.connect().await?;
        let file = tokio::fs::File::open(out_file).await?;
        let copy_cmd = format!(
            "COPY \"{}\".\"{}\" TO STDOUT WITH CSV HEADER DELIMITER ','",
            self.name, self.schema
        );
        let mut copy_in = client.copy_in_raw(copy_cmd.as_str()).await?;
        copy_in.read_from(file).await?;
        let rows_inserted = copy_in.finish().await?;
        Ok(rows_inserted)
    }
}
