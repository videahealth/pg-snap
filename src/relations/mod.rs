use crate::config::Config;
use crate::db::DbTableRelations;
use crate::table::Table;
use anyhow::anyhow;
use petgraph::visit::IntoNodeReferences;
use petgraph::Direction;
use petgraph::{
    graph::{DiGraph, NodeIndex},
    visit::{Dfs, Reversed},
};
use std::collections::HashMap;

pub struct TableRelation<'a> {
    pub table_schema: &'a str,
    pub table_name: &'a str,
    pub column_name: &'a str,
    pub foreign_table_schema: &'a str,
    pub foreign_table_name: &'a str,
    pub foreign_column_name: &'a str,
}

pub fn get_tables_to_copy<'a>(
    table_relations: &[DbTableRelations],
    tables: &'a [Table],
) -> anyhow::Result<()> {
    let config = Config::new("config.json")?;
    println!("Config: {:?}", config);
    let graph = build_graph_from_relations(&table_relations, &tables)?;
    let node = find_node_by_name_and_schema(&graph, "Organizations", "public");

    match node {
        Some(ni) => {
            if !has_no_children(&graph, ni) {
                println!("Node depends on other tables!");
                return Ok(());
            }
            visit_all_nodes_backwards(&graph, ni)
        }
        None => println!("Node not found!"),
    }

    Ok(())
}

pub fn build_graph_from_relations<'a>(
    table_relations: &[DbTableRelations],
    tables: &'a [Table],
) -> anyhow::Result<DiGraph<&'a Table, &'a Table>> {
    let mut graph: DiGraph<&'a Table, &'a Table> = DiGraph::new();

    let mut table_to_node: HashMap<(String, String), NodeIndex> = HashMap::new();
    let mut relations_map: HashMap<(String, String), TableRelation> = HashMap::new();
    let mut tables_map: HashMap<(String, String), &Table> = HashMap::new();

    for relation in table_relations {
        let key = (relation.table_schema.clone(), relation.table_name.clone());
        relations_map.insert(
            key,
            TableRelation {
                column_name: &relation.column_name,
                foreign_column_name: &relation.foreign_column_name,
                foreign_table_name: &relation.foreign_table_name,
                foreign_table_schema: &relation.foreign_table_schema,
                table_name: &relation.table_name,
                table_schema: &relation.table_schema,
            },
        );
    }

    for table in tables.clone() {
        let key = (table.schema.clone(), table.name.clone());
        tables_map.insert(key, &table);
    }

    for table in tables {
        let table_clone = table;

        let current_table_result =
            relations_map.get(&(table.schema.to_string(), table.name.to_string()));

        match current_table_result {
            Some(current_table) => {
                let source_table_key: (String, String) = (
                    current_table.table_schema.to_owned(),
                    current_table.table_name.to_owned(),
                );
                let target_table_key = (
                    current_table.foreign_table_schema.to_owned(),
                    current_table.foreign_table_name.to_owned(),
                );

                let target_table = tables_map.get(&target_table_key).ok_or_else(|| {
                    anyhow!(
                        "Error: Relation not found for {}.{}",
                        target_table_key.0,
                        target_table_key.1,
                    )
                })?;

                let source_index = *table_to_node
                    .entry(source_table_key.clone())
                    .or_insert_with(|| graph.add_node(table));

                let target_index = *table_to_node
                    .entry(target_table_key.clone())
                    .or_insert_with(|| graph.add_node(target_table));

                graph.add_edge(source_index, target_index, table_clone);
            }
            None => continue,
        }
    }

    Ok(graph)
}

fn has_no_children<'a>(graph: &'a DiGraph<&'a Table, &'a Table>, node_index: NodeIndex) -> bool {
    graph
        .edges_directed(node_index, Direction::Outgoing)
        .count()
        == 0
}

pub fn find_node_by_name_and_schema<'a>(
    graph: &'a DiGraph<&'a Table, &'a Table>,
    name: &str,
    schema: &str,
) -> Option<NodeIndex> {
    graph.node_references().find_map(|(idx, table)| {
        if table.name == name && table.schema == schema {
            Some(idx)
        } else {
            None
        }
    })
}

pub fn visit_all_nodes_backwards<'a>(
    graph: &'a DiGraph<&'a Table, &'a Table>,
    start_node: NodeIndex,
) {
    // Create a depth-first search (DFS) visitor for the graph, using Reversed to invert edge directions
    let mut dfs = Dfs::new(Reversed(graph), start_node);

    while let Some(nx) = dfs.next(Reversed(graph)) {
        // Here you can access the node `nx`
        // For example, to print or process the node data (`&'a Table`), you can do something like:
        let table = graph[nx];

        println!("Visited : {:?}.{:?}", table.schema, table.name);
        // To access the Table data, use:
        // let table = graph[nx];
        // Do something with `table`, e.g., print its details
    }
}
