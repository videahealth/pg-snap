use std::{collections::HashSet, io};

use rand::{distributions::Alphanumeric, thread_rng, Rng};

pub mod csv;
use std::io::Write;

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
