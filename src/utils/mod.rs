use std::{collections::HashSet, io};

use rand::{distributions::Alphanumeric, thread_rng, Rng};
use regex::Regex;
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

pub fn should_skip(
    table_schema: &str,
    table_name: &str,
    skip_tables: &HashSet<String>,
    skip_schemas: &HashSet<String>,
) -> bool {
    // Combine schema and table name to check against skip_tables patterns
    let full_table_name = format!("{}.{}", table_schema, table_name);

    // Check skip_tables
    for pattern in skip_tables {
        // Convert pattern to regex, adding ^ at the start and $ at the end for exact matches
        let regex_pattern = format!("^{}$", regex::escape(pattern).replace("\\*", ".*"));
        let re = Regex::new(&regex_pattern).expect("Invalid regex pattern in skip_tables");

        if re.is_match(&full_table_name) || re.is_match(&table_name) {
            return true;
        }
    }

    // Check skip_schemas
    for pattern in skip_schemas {
        // Convert pattern to regex, adding ^ at the start and $ at the end for exact matches
        let regex_pattern = format!("^{}$", regex::escape(pattern).replace("\\*", ".*"));
        let re = Regex::new(&regex_pattern).expect("Invalid regex pattern in skip_schemas");

        if re.is_match(table_schema) {
            return true;
        }
    }

    false
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::collections::HashSet;

    #[test]
    fn test_should_skip_table() {
        let mut skip_tables = HashSet::new();
        let mut skip_schemas = HashSet::new();

        skip_tables.insert("public.Temp*".to_string());
        skip_tables.insert("myschema.MyTable".to_string());
        skip_schemas.insert("someschema".to_string());

        assert_eq!(
            should_skip("public", "TempTable", &skip_tables, &skip_schemas),
            true
        );
        assert_eq!(
            should_skip("public", "TempAnother", &skip_tables, &skip_schemas),
            true
        );
        assert_eq!(
            should_skip("myschema", "MyTable", &skip_tables, &skip_schemas),
            true
        );
        assert_eq!(
            should_skip("public", "MyTable", &skip_tables, &skip_schemas),
            false
        );
        assert_eq!(
            should_skip("public", "OtherTable", &skip_tables, &skip_schemas),
            false
        );
    }

    #[test]
    fn test_should_skip_schema() {
        let mut skip_tables = HashSet::new();
        let mut skip_schemas = HashSet::new();

        skip_tables.insert("public.Temp*".to_string());
        skip_tables.insert("myschema.MyTable".to_string());
        skip_schemas.insert("someschema".to_string());

        assert_eq!(
            should_skip("someschema", "AnyTable", &skip_tables, &skip_schemas),
            true
        );
        assert_eq!(
            should_skip("anotherschema", "AnyTable", &skip_tables, &skip_schemas),
            false
        );
    }

    #[test]
    fn test_should_skip_full_table_name() {
        let mut skip_tables = HashSet::new();
        let mut skip_schemas = HashSet::new();

        skip_tables.insert("public.Temp*".to_string());
        skip_tables.insert("myschema.MyTable".to_string());
        skip_schemas.insert("someschema".to_string());

        assert_eq!(
            should_skip("public", "TempTable", &skip_tables, &skip_schemas),
            true
        );
        assert_eq!(
            should_skip("public", "TempAnother", &skip_tables, &skip_schemas),
            true
        );
        assert_eq!(
            should_skip("myschema", "MyTable", &skip_tables, &skip_schemas),
            true
        );
        assert_eq!(
            should_skip("public", "MyTable", &skip_tables, &skip_schemas),
            false
        );
        assert_eq!(
            should_skip("anotherschema", "TempTable", &skip_tables, &skip_schemas),
            false
        );
    }

    #[test]
    fn test_should_not_skip() {
        let mut skip_tables = HashSet::new();
        let mut skip_schemas = HashSet::new();

        skip_tables.insert("public.Temp*".to_string());
        skip_tables.insert("myschema.MyTable".to_string());
        skip_schemas.insert("someschema".to_string());

        assert_eq!(
            should_skip("public", "RegularTable", &skip_tables, &skip_schemas),
            false
        );
        assert_eq!(
            should_skip("otherschema", "TempTable", &skip_tables, &skip_schemas),
            false
        );
    }
}
