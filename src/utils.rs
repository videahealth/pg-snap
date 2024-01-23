use anyhow::anyhow;
use anyhow::Context;
use anyhow::Result;
use rand::distributions::Alphanumeric;
use rand::{thread_rng, Rng};
use std::io::Write;
use std::io::{BufRead, ErrorKind};
use std::process::Command;
use std::{collections::HashSet, fs::File, io, path::PathBuf};

pub fn parse_skip_tables(arg: &str) -> HashSet<String> {
    arg.split(',').map(String::from).collect()
}

pub fn should_skip(table_schema: &str, table_name: &str, skip_tables: &HashSet<String>) -> bool {
    let full_name = format!("{}.{}", table_schema, table_name);
    let schema_wildcard = format!("{}.*", table_schema);
    let table_prefix = format!("{}.", table_schema);

    skip_tables.contains(&full_name)
        || skip_tables.contains(&schema_wildcard)
        || skip_tables.iter().any(|s| {
            s.starts_with(&table_prefix)
                && table_name.starts_with(&s[table_prefix.len()..s.len() - 1])
        })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_should_skip() {
        let mut skip_tables = HashSet::new();
        skip_tables.insert("public.*".to_string());
        skip_tables.insert("test.Events*".to_string());

        // Check whole schema skipping
        assert_eq!(should_skip("public", "AnyTable", &skip_tables), true);
        // Check table prefix skipping
        assert_eq!(should_skip("test", "EventsTable", &skip_tables), true);
        // Check exact table skipping (not in our skip_tables set for now)
        assert_eq!(should_skip("test", "ExactTable", &skip_tables), false);
        // Check non-specified schema
        assert_eq!(should_skip("other", "AnyTable", &skip_tables), false);
        // Check non-matching prefix
        assert_eq!(should_skip("test", "NotEventsTable", &skip_tables), false);
    }
}

pub fn extract_and_remove_fk_constraints(input: String) -> std::io::Result<(String, String)> {
    let lines = input.split('\n');

    let mut remaining_content = String::new();
    let mut extracted_content = String::new();
    let mut capture = false;

    for line in lines {
        if line.starts_with("-- Name:") {
            if line.contains("Type: FK CONSTRAINT") {
                // Start capturing this block for extraction
                capture = true;
            } else {
                // Continue appending to the remaining content
                capture = false;
                remaining_content += line;
                remaining_content += "\n";
            }
        }

        if capture {
            extracted_content += line;
            extracted_content += "\n";
        } else if !line.starts_with("-- Name:") {
            remaining_content += line;
            remaining_content += "\n";
        }
    }

    Ok((extracted_content, remaining_content))
}

pub fn ask_for_confirmation(prompt: &str) {
    print!("{} (y/n): ", prompt);
    io::stdout().flush().unwrap();

    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();
    let confirmation = input.trim().to_lowercase();

    match confirmation.as_str() {
        "y" | "yes" => {}
        "n" | "no" => {
            std::process::exit(1);
        }
        _ => {
            println!("Invalid input. Please enter 'y' for yes or 'n' for no.");
            ask_for_confirmation(prompt);
        }
    }
}

pub fn rnd_string() -> String {
    thread_rng()
        .sample_iter(&Alphanumeric)
        .take(10)
        .map(|x| x as char)
        .collect()
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

pub fn get_major_version(v: String) -> anyhow::Result<String> {
    let major_version = v
        .split(".")
        .next()
        .ok_or(anyhow!("Error getting postgres version"))?;
    Ok(major_version.to_string())
}

pub fn execute_command(command_name: &str, command: &mut Command) -> Result<String> {
    let output = match command.output() {
        Ok(output) => output,
        Err(e) => {
            if e.kind() == ErrorKind::NotFound {
                return Err(anyhow::anyhow!(
                    "{} command not found in system PATH",
                    command_name
                ));
            } else {
                return Err(anyhow::anyhow!(
                    "Failed to execute {} command",
                    command_name
                ));
            }
        }
    };

    if !output.status.success() {
        return Err(anyhow::anyhow!(
            "Error executing {}: {}",
            command_name,
            String::from_utf8_lossy(&output.stderr)
        ));
    }

    String::from_utf8(output.stdout).context(format!(
        "Error reading stdout from {} command",
        command_name
    ))
}
