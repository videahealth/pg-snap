use crate::db::consts::SQL_TYPE_MAPPING;
use crate::db::table::{ForeignKeyInfo, Table};
use crate::db::Db;
use crate::db_walk::copy_data;
use crate::utils::csv::read_csv_column_by_name;
use anyhow::{anyhow, Result};
use petgraph::graph::{DiGraph, NodeIndex};
use std::collections::{HashMap, HashSet};
use std::path::PathBuf;

use super::dag::{
    find_children, find_closed_system_full_dag, find_predecessors, get_node_index_from_data,
    traverse_graph_from_start,
};

#[derive(PartialEq, Debug)]
enum VisitMode {
    Predecessor,
    Successor,
}

pub struct Subset {
    relations: Vec<ForeignKeyInfo>,
    tables: Vec<Table>,
    start_table_id: String,
    subset_query: String,
    dag: DiGraph<String, ()>,
    root_folder: PathBuf,
    max_rows_per_table: Option<i32>,
    db: Db,
}

impl Subset {
    pub fn new(
        tables: Vec<Table>,
        relations: Vec<ForeignKeyInfo>,
        db: Db,
        start_table_name: String,
        start_table_schema: String,
        root_folder: PathBuf,
        max_rows_per_table: Option<i32>,
        subset_query_where: String,
    ) -> Self {
        let dag = build_relations(&relations);
        let start_table_id = format!("\"{}\".\"{}\"", start_table_schema, start_table_name);
        let subset_query = format!(
            "SELECT * FROM {} WHERE {}",
            start_table_id, subset_query_where
        );
        Subset {
            relations,
            tables,
            start_table_id,
            db,
            subset_query,
            dag,
            root_folder,
            max_rows_per_table,
        }
    }

    fn build_conditions(
        &self,
        foreign_table_csv_path: &str,
        cols: &[ForeignKeyInfo],
        visit_mode: VisitMode,
    ) -> Result<Vec<String>> {
        let mut conditions: Vec<String> = Vec::new();

        for fk in cols {
            let fk_col = match visit_mode {
                VisitMode::Predecessor => &fk.foreign_column_name,
                VisitMode::Successor => &fk.column_name,
            };
            let csv_col = match visit_mode {
                VisitMode::Predecessor => &fk.column_name,
                VisitMode::Successor => &fk.foreign_column_name,
            };

            let fk_col_type = match visit_mode {
                VisitMode::Predecessor => &fk.col_type,
                VisitMode::Successor => &fk.foreign_col_type,
            };

            let data = read_csv_column_by_name(foreign_table_csv_path, csv_col)?;
            if data.is_empty() {
                continue;
            }

            let col_data = format_cols(data, &fk_col_type)?;

            if col_data.is_empty() {
                continue;
            }

            let condition = format!("\"{}\" IN ({})", fk_col, col_data);
            conditions.push(condition);
        }

        Ok(conditions)
    }

    fn build_successor_query(
        &self,
        foreign_table_id: &str,
        main_table_id: &str,
    ) -> Result<Option<String>> {
        let foreign_table = self
            .tables
            .iter()
            .find(|t| t.id == foreign_table_id)
            .ok_or(anyhow!("Error finding tabe"))?;

        let fks = get_table_fk(foreign_table_id, main_table_id, &self.relations);
        let foreign_table_csv_pathbuf = foreign_table.get_data_dir(&self.root_folder)?;

        let foreign_table_csv_path = foreign_table_csv_pathbuf
            .to_str()
            .ok_or(anyhow!("Unable to get csv path for foreign table"))?;

        let conditions =
            self.build_conditions(foreign_table_csv_path, &fks, VisitMode::Successor)?;

        if conditions.is_empty() {
            return Ok(Some(conditions.join(" OR ")));
        }

        Ok(None)
    }

    fn build_predecessor_query(
        &self,
        foreign_table_id: &str,
        main_table_id: &str,
    ) -> Result<Option<String>> {
        let foreign_table = self
            .tables
            .iter()
            .find(|t| t.id == foreign_table_id)
            .ok_or(anyhow!("Error finding tabe"))?;

        let fks = get_table_fk(main_table_id, foreign_table_id, &self.relations);
        let foreign_table_csv_pathbuf = foreign_table.get_data_dir(&self.root_folder)?;

        let foreign_table_csv_path = foreign_table_csv_pathbuf
            .to_str()
            .ok_or(anyhow!("Unable to get csv path for foreign table"))?;

        let conditions =
            self.build_conditions(foreign_table_csv_path, &fks, VisitMode::Successor)?;

        if conditions.len() > 0 {
            return Ok(Some(conditions.join(" OR ")));
        }

        Ok(None)
    }

    async fn visit_node(
        &self,
        node: &NodeIndex,
        visit_mode: VisitMode,
        visited_map: &mut HashSet<String>,
        copied_map: &mut HashSet<String>,
    ) -> Result<()> {
        let visiting_table_id: &String = &self.dag[node.to_owned()];
        let visiting_table = self
            .tables
            .iter()
            .find(|t| t.id == *visiting_table_id)
            .ok_or(anyhow!("Error finding tabe"))?;

        // visited_map.
        visited_map.insert(visiting_table_id.clone());

        let is_root_node = self.start_table_id.eq(visiting_table_id);

        if copied_map.contains(visiting_table_id) {
            return Ok(());
        }

        if is_root_node {
            copy_data(
                self.db.clone(),
                self.root_folder.clone(),
                visiting_table.clone(),
                Some(&self.subset_query),
            )
            .await?;
            copied_map.insert(visiting_table_id.clone());
        }

        let mut conditions: Vec<String> = Vec::new();
        let query_nodes = match visit_mode {
            VisitMode::Predecessor => find_predecessors(&self.dag, *node),
            VisitMode::Successor => find_children(&self.dag, *node),
        };

        for query_node in query_nodes {
            let table_id: &String = &self.dag[query_node.to_owned()];
            let visited = visited_map.contains(table_id);
            let copied_data = copied_map.contains(table_id);

            if visited && copied_data {
                let q = match visit_mode {
                    VisitMode::Predecessor => {
                        self.build_predecessor_query(table_id, visiting_table_id)?
                    }
                    VisitMode::Successor => {
                        self.build_successor_query(table_id, visiting_table_id)?
                    }
                };

                if let Some(query) = q {
                    conditions.push(query);
                }
            }
        }

        if conditions.len() == 0 {
            return Ok(());
        }

        let query_condition = conditions.join(" OR ");

        let select_statement = match self.max_rows_per_table {
            Some(max_rows) if visit_mode != VisitMode::Predecessor => {
                format!(
                    "SELECT * FROM {} WHERE {} LIMIT {}",
                    visiting_table_id, query_condition, max_rows
                )
            }
            _ => {
                format!(
                    "SELECT * FROM {} WHERE {}",
                    visiting_table_id, query_condition
                )
            }
        };

        copy_data(
            self.db.clone(),
            self.root_folder.clone(),
            visiting_table.clone(),
            Some(&select_statement),
        )
        .await?;
        copied_map.insert(visiting_table_id.clone());

        Ok(())
    }

    pub async fn traverse_and_copy_data(&self) -> Result<()> {
        let mut copied_data: HashSet<String> = HashSet::new();
        let mut visited_data: HashSet<String> = HashSet::new();

        let ni = get_node_index_from_data(&self.dag, &self.start_table_id);

        let closed_system_dag = find_closed_system_full_dag(&self.dag, ni);

        let visited_from_start = traverse_graph_from_start(&closed_system_dag, ni);

        let total = visited_from_start.len();

        loop {
            let total_copied = &copied_data.len();

            if total_copied >= &total {
                break;
            }

            for node in &visited_from_start {
                let table_id: &String = &self.dag[node.to_owned()];

                if !copied_data.contains(table_id) {
                    self.visit_node(
                        node,
                        VisitMode::Predecessor,
                        &mut visited_data,
                        &mut copied_data,
                    )
                    .await?;
                    self.visit_node(
                        node,
                        VisitMode::Successor,
                        &mut visited_data,
                        &mut copied_data,
                    )
                    .await?;
                }
            }
        }

        Ok(())
    }
}

fn format_cols(data: Vec<String>, col_type: &str) -> Result<String> {
    let mut data_vals: Vec<String> = Vec::new();

    let category = SQL_TYPE_MAPPING
        .get(col_type)
        .ok_or_else(|| anyhow!("unsupported data type {}", col_type))?;

    for d in data {
        if d.is_empty() {
            continue;
        }
        match category {
            &"String types" | &"UUID types" | &"varchar" => {
                data_vals.push(format!("'{}'", d));
            }
            &"Numeric types" | &"Integer types" => {
                data_vals.push(d.to_string());
            }
            &"Boolean types" => {
                data_vals.push(d.to_string());
            }
            &"Date/time types" => {
                data_vals.push(format!("'{}'", d));
            }
            &"Binary types" => {
                data_vals.push(format!("'{}'", d));
            }
            _ => {
                return Err(anyhow!(
                    "unsupported category {} for data type {}",
                    category,
                    col_type
                ))
            }
        }
    }

    Ok(data_vals.join(","))
}

pub fn get_table_fk(
    foreign_table_id: &str,
    main_table_id: &str,
    relations: &[ForeignKeyInfo],
) -> Vec<ForeignKeyInfo> {
    relations
        .iter()
        .filter(|rel| {
            rel.foreign_table_id == foreign_table_id && rel.source_table_id == main_table_id
        })
        .cloned()
        .collect()
}

fn build_relations(relations: &Vec<ForeignKeyInfo>) -> DiGraph<String, ()> {
    let mut dag = DiGraph::new();
    let mut nodes = HashMap::new();

    for rel in relations {
        let node1_key = &rel.source_table_id;
        let node2_key = &rel.foreign_table_id;

        let node1_index = *nodes
            .entry(node1_key.clone())
            .or_insert_with(|| dag.add_node(node1_key.clone()));
        let node2_index = *nodes
            .entry(node2_key.clone())
            .or_insert_with(|| dag.add_node(node2_key.clone()));

        if dag.find_edge(node1_index, node2_index).is_none() {
            dag.add_edge(node1_index, node2_index, ());
        }
    }

    dag
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_format_cols_with_string_types() {
        let data = vec![String::from("Alice"), String::from("Bob")];
        let col_type = "text";
        let formatted = format_cols(data, col_type).unwrap();
        assert_eq!(formatted, "'Alice','Bob'");
    }

    #[test]
    fn test_format_cols_with_numeric_types() {
        let data = vec![String::from("123"), String::from("456")];
        let col_type = "int4";
        let formatted = format_cols(data, col_type).unwrap();
        assert_eq!(formatted, "123,456");
    }

    #[test]
    fn test_format_cols_with_boolean_types() {
        let data = vec![String::from("true"), String::from("false")];
        let col_type = "bool";
        let formatted = format_cols(data, col_type).unwrap();
        assert_eq!(formatted, "true,false");
    }

    #[test]
    fn test_format_cols_with_unsupported_type() {
        let data = vec![String::from("data")];
        let col_type = "UNSUPPORTED_TYPE";
        let result = format_cols(data, col_type);
        assert!(result.is_err());
        assert_eq!(
            result.unwrap_err().to_string(),
            "unsupported data type UNSUPPORTED_TYPE"
        );
    }
}
