use std::collections::HashMap;

#[derive(Debug, Clone)]
pub struct Node {
    pub data: String,
    pub children: Vec<Node>,
}

impl Node {
    pub fn new(data: String) -> Self {
        Node {
            data,
            children: Vec::new(),
        }
    }
}

#[derive(Debug)]
pub struct DAG {
    pub nodes: HashMap<String, Node>,
}

impl DAG {
    pub fn new() -> Self {
        DAG {
            nodes: HashMap::new(),
        }
    }

    pub fn create_or_get_node(&mut self, data: String) -> &Node {
        self.nodes
            .entry(data.clone())
            .or_insert_with(|| Node::new(data))
    }

    pub fn add_edge(&mut self, parent_data: String, child_data: String) {
        let nodes = self.nodes.clone();
        if let Some(parent_node) = self.nodes.get_mut(&parent_data) {
            let exists = parent_node
                .children
                .iter()
                .any(|child| child.data == child_data);

            if !exists {
                if let Some(child_node) = nodes.get(&child_data) {
                    parent_node.children.push(child_node.clone());
                }
            }
        }
    }

    pub fn find_closed_system_full_dag(&self, start_data: &str) -> DAG {
        let mut connected = std::collections::HashSet::new();
        let mut stack = vec![start_data];

        while let Some(current_data) = stack.pop() {
            if !connected.insert(current_data.to_string()) {
                continue;
            }

            if let Some(node) = self.nodes.get(current_data) {
                for child in &node.children {
                    stack.push(&child.data);
                }
            }

            for (data, possible_parent) in &self.nodes {
                if possible_parent
                    .children
                    .iter()
                    .any(|child| child.data == current_data)
                {
                    stack.push(data);
                }
            }
        }

        let mut new_dag = DAG::new();
        for node_data in connected.iter() {
            if let Some(original_node) = self.nodes.get(node_data) {
                let new_node = Node::new(original_node.data.clone());
                new_dag.nodes.insert(new_node.data.clone(), new_node);
            }
        }

        for (data, _) in new_dag.nodes.clone() {
            if let Some(original_node) = self.nodes.get(&data) {
                for original_child in &original_node.children {
                    if new_dag.nodes.contains_key(&original_child.data) {
                        new_dag.add_edge(data.clone(), original_child.data.clone());
                    }
                }
            }
        }

        new_dag
    }

    pub fn find_predecessors(&self, start_data: &str) -> Vec<Node> {
        let mut predecessors = Vec::new();

        for node in self.nodes.values() {
            for child in &node.children {
                if child.data == start_data {
                    predecessors.push(node.clone());
                    break;
                }
            }
        }

        predecessors
    }

    pub fn traverse_graph_from_start(&self, start_data: &str) -> Vec<Node> {
        let mut visited = std::collections::HashSet::new();
        let mut result = Vec::new();

        self.dfs(start_data, &mut visited, &mut result);

        for (data, _) in self.nodes.iter() {
            if !visited.contains(data) {
                self.dfs(data, &mut visited, &mut result);
            }
        }

        result
    }

    fn dfs(
        &self,
        node_data: &str,
        visited: &mut std::collections::HashSet<String>,
        result: &mut Vec<Node>,
    ) {
        if visited.insert(node_data.to_string()) {
            if let Some(node) = self.nodes.get(node_data) {
                result.push(node.clone());

                for pred in self.find_predecessors(node_data) {
                    self.dfs(&pred.data, visited, result);
                }
            }
        }
    }
}
