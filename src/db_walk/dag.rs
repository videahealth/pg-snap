use std::collections::VecDeque;
use std::collections::{HashMap, HashSet};

use petgraph::visit::EdgeRef;
use petgraph::visit::IntoNodeIdentifiers;
use petgraph::visit::VisitMap;
use petgraph::visit::Visitable;
use petgraph::{
    graph::{DiGraph, NodeIndex},
    Direction,
};

pub fn get_node_index_from_data(graph: &DiGraph<String, ()>, start_node_data: &str) -> NodeIndex {
    let mut data_to_index: HashMap<&String, NodeIndex> = HashMap::new();
    for node_index in graph.node_indices() {
        let data = &graph[node_index];
        data_to_index.insert(data, node_index);
    }

    let node = data_to_index
        .get(&start_node_data.to_string())
        .expect("Start node not found");

    node.clone()
}

pub fn find_closed_system_full_dag(
    graph: &DiGraph<String, ()>,
    start_node: NodeIndex,
) -> DiGraph<String, ()> {
    let mut visited = graph.visit_map();
    let mut to_visit = VecDeque::new();
    let mut connected_nodes = HashSet::new();

    to_visit.push_back(start_node);
    while let Some(node) = to_visit.pop_front() {
        if !visited.visit(node) {
            continue;
        }
        connected_nodes.insert(node);

        for neighbor in graph.neighbors_directed(node, Direction::Outgoing) {
            if !visited.is_visited(&neighbor) {
                to_visit.push_back(neighbor);
            }
        }

        for neighbor in graph.neighbors_directed(node, Direction::Incoming) {
            if !visited.is_visited(&neighbor) {
                to_visit.push_back(neighbor);
            }
        }
    }

    // Reconstruct the graph with only the connected nodes
    let mut new_graph = DiGraph::new();
    let mut old_to_new = std::collections::HashMap::new();

    for &node in &connected_nodes {
        let data = graph.node_weight(node).unwrap().clone();
        let new_node = new_graph.add_node(data);
        old_to_new.insert(node, new_node);
    }

    for &node in &connected_nodes {
        if let Some(&new_node) = old_to_new.get(&node) {
            for edge in graph.edges(node) {
                let target = edge.target();
                if connected_nodes.contains(&target) {
                    if let Some(&new_target) = old_to_new.get(&target) {
                        new_graph.add_edge(new_node, new_target, ());
                    }
                }
            }
        }
    }

    new_graph
}

pub fn find_children(graph: &DiGraph<String, ()>, node_index: NodeIndex) -> Vec<NodeIndex> {
    graph
        .neighbors_directed(node_index, Direction::Outgoing)
        .collect()
}

pub fn find_predecessors(graph: &DiGraph<String, ()>, node_index: NodeIndex) -> Vec<NodeIndex> {
    graph
        .neighbors_directed(node_index, Direction::Incoming)
        .collect()
}

pub fn traverse_graph_from_start(
    graph: &DiGraph<String, ()>,
    start_node: NodeIndex,
) -> Vec<NodeIndex> {
    let mut visited = HashSet::new();
    let mut result = Vec::new();

    // Custom DFS that considers both forward and backward edges
    fn dfs_recursive(
        node: petgraph::prelude::NodeIndex,
        graph: &DiGraph<String, ()>,
        visited: &mut HashSet<petgraph::prelude::NodeIndex>,
        result: &mut Vec<petgraph::prelude::NodeIndex>,
    ) {
        if visited.insert(node) {
            result.push(node);
            // Traverse successors
            for neighbor in graph.neighbors(node) {
                dfs_recursive(neighbor, graph, visited, result);
            }
            // Traverse predecessors
            for neighbor in graph.neighbors_directed(node, Direction::Incoming) {
                dfs_recursive(neighbor, graph, visited, result);
            }
        }
    }

    // Start DFS from the given start node
    dfs_recursive(start_node, graph, &mut visited, &mut result);

    // Ensure all nodes are visited by initiating DFS for unvisited nodes
    for node in graph.node_identifiers() {
        if !visited.contains(&node) {
            dfs_recursive(node, graph, &mut visited, &mut result);
        }
    }

    result
}
