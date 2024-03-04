use anyhow::{anyhow, Result};
use csv::ReaderBuilder;
use std::io::BufRead;
use std::{fs::File, path::PathBuf};

pub fn read_csv_column_by_name(file_path: &str, column_name: &str) -> Result<Vec<String>> {
    let file = File::open(file_path)?;
    let mut rdr = ReaderBuilder::new().from_reader(file);
    let headers = rdr.headers()?.clone();

    let column_index = headers.iter().position(|h| h == column_name);
    let column_index = match column_index {
        Some(idx) => idx,
        None => return Err(anyhow!("column '{}' not found", column_name)),
    };

    let mut column_data = Vec::new();
    for result in rdr.records() {
        let record = result?;
        if let Some(value) = record.get(column_index) {
            column_data.push(value.to_string());
        }
    }

    Ok(column_data)
}

pub fn read_first_line(path: &PathBuf) -> anyhow::Result<String> {
    let file = File::open(path)?;
    let reader = std::io::BufReader::new(file);
    let mut lines = reader.lines();
    match lines.next() {
        Some(line) => {
            let quoted: Vec<String> = line?
                .split(',')
                .map(|column| format!("\"{}\"", column))
                .collect();
            Ok(quoted.join(","))
        }
        None => Err(anyhow!("File was empty")),
    }
}
