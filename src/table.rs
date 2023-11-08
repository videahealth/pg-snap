use std::path::PathBuf;

use tokio::{fs::File, io::BufWriter};

use crate::{db::Db, utils::read_first_line};
use anyhow::anyhow;
use bytes::Bytes;
use futures_util::StreamExt;
use tokio::io::AsyncWriteExt;

pub struct Table {
    pub name: String,
    pub schema: String,
    pub is_extension: Option<bool>,
    db_conn: Db,
    pub full_name: String,
    pub data_file_path: Option<PathBuf>,
}

impl Table {
    pub fn new(
        name: String,
        schema: String,
        db_conn: Db,
        is_extension: Option<bool>,
        data_file_path: Option<PathBuf>,
    ) -> Self {
        Table {
            name: name.clone(),
            schema: schema.clone(),
            is_extension,
            db_conn,
            full_name: format!("{}.{}", schema, name),
            data_file_path: data_file_path,
        }
    }

    pub fn get_data_file_path(&self) -> anyhow::Result<PathBuf> {
        if let Some(f) = &self.data_file_path {
            Ok(f.clone())
        } else {
            Err(anyhow!("Data file path not found"))
        }
    }

    /// Issue a COPY FROM STDIN statement and transition the connection to streaming data to Postgres.
    pub async fn copy_in(
        &self,
        out_file: &PathBuf,
        name: &str,
        schema: Option<&str>,
    ) -> anyhow::Result<u64> {
        let mut client = self.db_conn.connect().await?;
        let file = tokio::fs::File::open(out_file).await?;
        let first_line = read_first_line(out_file).expect("Failed to read the first line");

        let copy_cmd = match schema {
            Some(schema) => format!(
                "COPY \"{}\".\"{}\"({}) FROM STDIN WITH CSV HEADER DELIMITER ','",
                schema, name, first_line,
            ),
            None => format!(
                "COPY \"{}\"({}) FROM STDIN WITH CSV HEADER DELIMITER ','",
                name, first_line,
            ),
        };

        let mut copy_in = client.copy_in_raw(copy_cmd.as_str()).await?;
        copy_in.read_from(file).await?;
        let rows_inserted = copy_in.finish().await?;
        Ok(rows_inserted)
    }

    /// Issue a COPY TO STDOUT statement and transition the connection to streaming data from Postgres.
    pub async fn copy_out(&self, in_file: &PathBuf) -> anyhow::Result<u64> {
        let mut client = self.db_conn.connect().await?;
        let file = File::create(in_file).await?;
        let mut writer = BufWriter::new(file);

        let copy_cmd = format!(
            "COPY \"{}\".\"{}\" TO STDOUT WITH CSV HEADER DELIMITER ','",
            self.schema, self.name
        );

        let mut copy_out = client.copy_out_raw(copy_cmd.as_str()).await?;

        let mut row_count = 0u64;

        while let Some(chunk) = copy_out.next().await {
            let bytes: Bytes = chunk?;
            writer.write_all(&bytes).await?;
            row_count += bytecount::count(&bytes, b'\n') as u64;
        }

        if row_count > 0 {
            row_count -= 1;
        }

        writer.flush().await?;

        Ok(row_count)
    }
}
