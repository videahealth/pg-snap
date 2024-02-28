package relations

// https://www.tonic.ai/blog/condenser-a-database-subsetting-tool

import (
	"fmt"
	"strings"
)

type Node struct {
	Data     string
	Children []*Node
}

type DAG struct {
	Nodes map[string]*Node
}

func (dag *DAG) CreateOrGetNode(data string) *Node {
	if dag.Nodes == nil {
		dag.Nodes = make(map[string]*Node)
	}
	if node, exists := dag.Nodes[data]; exists {
		return node
	}
	newNode := &Node{
		Data: data,
	}
	dag.Nodes[data] = newNode
	return newNode
}

func (dag *DAG) AddNode(node *Node) {
	if dag.Nodes == nil {
		dag.Nodes = make(map[string]*Node)
	}
	if _, exists := dag.Nodes[node.Data]; !exists {
		dag.Nodes[node.Data] = node
	}
}

func (dag *DAG) AddEdge(parent, child *Node) {
	exists := false
	for _, existingChild := range parent.Children {
		if existingChild == child {
			exists = true
			break
		}
	}
	if !exists {
		parent.Children = append(parent.Children, child)
	}
}

func (dag *DAG) FindClosedSystemFullDAG(startNode *Node) *DAG {
	connected := make(map[string]bool)
	var findConnected func(*Node)
	findConnected = func(node *Node) {
		if connected[node.Data] {
			return
		}
		connected[node.Data] = true
		for _, child := range node.Children {
			findConnected(child)
		}
		for _, possibleParent := range dag.Nodes {
			for _, child := range possibleParent.Children {
				if child.Data == node.Data {
					findConnected(possibleParent)
				}
			}
		}
	}
	findConnected(startNode)

	newDAG := &DAG{Nodes: make(map[string]*Node)}
	for nodeData := range connected {
		originalNode := dag.Nodes[nodeData]
		newNode := &Node{Data: originalNode.Data}
		newDAG.Nodes[nodeData] = newNode
	}
	for _, newNode := range newDAG.Nodes {
		for _, originalChild := range dag.Nodes[newNode.Data].Children {
			if _, exists := newDAG.Nodes[originalChild.Data]; exists {
				newDAG.Nodes[newNode.Data].Children = append(newDAG.Nodes[newNode.Data].Children, newDAG.Nodes[originalChild.Data])
			}
		}
	}

	return newDAG
}

func (dag *DAG) FindPredecessors(startNode *Node) []*Node {
	var predecessors []*Node
	for _, node := range dag.Nodes {
		for _, child := range node.Children {
			if child == startNode {
				predecessors = append(predecessors, node)
			}
		}
	}
	return predecessors
}

// Modified DFS to traverse through predecessors
func (dag *DAG) DFSPredecessors(startNode *Node, callback func(node *Node) bool) {
	visited := make(map[*Node]bool)

	var dfsRecursive func(node *Node)
	dfsRecursive = func(node *Node) {
		visited[node] = true

		if !callback(node) {
			return
		}

		predecessors := dag.FindPredecessors(node)
		for _, pred := range predecessors {
			if !visited[pred] {
				dfsRecursive(pred)
			}
		}
	}

	dfsRecursive(startNode)
}

func (dag *DAG) TraverseGraphFromStart(startNode *Node) []*Node {
	visited := make(map[*Node]bool)
	var result []*Node

	var dfsRecursive func(node *Node)
	dfsRecursive = func(node *Node) {
		if visited[node] {
			return
		}
		visited[node] = true

		result = append(result, node)

		for _, pred := range dag.FindPredecessors(node) {
			dfsRecursive(pred)
		}
	}

	dfsRecursive(startNode)

	for _, node := range dag.Nodes {
		if !visited[node] {
			dfsRecursive(node)
		}
	}

	return result
}

func (dag *DAG) DFS(startNode *Node, callback func(node *Node) bool) {
	visited := make(map[*Node]bool) // Keep track of visited nodes

	var dfsRecursive func(node *Node)
	dfsRecursive = func(node *Node) {
		visited[node] = true

		if !callback(node) {
			return
		}

		for _, child := range node.Children {
			if !visited[child] {
				dfsRecursive(child)
			}
		}
	}

	dfsRecursive(startNode)
}

func (dag *DAG) PrettyPrintNode(node *Node, depth int) {
	indent := strings.Repeat(" ", depth*4)
	fmt.Printf("%s- %s\n", indent, node.Data)
	for _, child := range node.Children {
		dag.PrettyPrintNode(child, depth+1)
	}
}

func (dag *DAG) PrettyPrint() {
	roots := dag.FindRoots()
	for _, root := range roots {
		dag.PrettyPrintNode(root, 0)
	}
}

func (dag *DAG) FindRoots() []*Node {
	childSet := make(map[string]bool)
	for _, node := range dag.Nodes {
		for _, child := range node.Children {
			childSet[child.Data] = true
		}
	}

	// Find nodes not in childSet; those are roots
	var roots []*Node
	for _, node := range dag.Nodes {
		if !childSet[node.Data] {
			roots = append(roots, node)
		}
	}
	return roots
}

func (dag *DAG) FindNodeByData(data string) *Node {
	var resultNode *Node = nil

	callback := func(node *Node) bool {
		if node.Data == data {
			resultNode = node
			return false
		}
		return true
	}

	for _, node := range dag.Nodes {
		if resultNode != nil {
			break
		}
		dag.DFS(node, callback)
	}

	return resultNode
}

func (dag *DAG) findRoots() []*Node {
	inDegree := make(map[string]int)
	for _, node := range dag.Nodes {
		for _, child := range node.Children {
			inDegree[child.Data]++
		}
	}

	var roots []*Node
	for _, node := range dag.Nodes {
		if inDegree[node.Data] == 0 {
			roots = append(roots, node)
		}
	}
	return roots
}

func (dag *DAG) ToGraphviz() string {
	var builder strings.Builder
	builder.WriteString("digraph G {\n")

	var printNode func(*Node, map[string]bool)
	printed := make(map[string]bool)

	printNode = func(node *Node, visited map[string]bool) {
		if _, done := printed[node.Data]; done {
			return
		}
		printed[node.Data] = true
		for _, child := range node.Children {
			builder.WriteString(fmt.Sprintf("    %s -> %s\n", strings.ReplaceAll(
				strings.ReplaceAll(node.Data, `"`, ""), ".", "_"),
				strings.ReplaceAll(strings.ReplaceAll(child.Data, `"`, ""), ".", "_")),
			)
			if _, seen := visited[child.Data]; !seen {
				visited[child.Data] = true
				printNode(child, visited)
			}
		}
	}

	roots := dag.FindRoots()
	for _, root := range roots {
		printNode(root, make(map[string]bool))
	}

	builder.WriteString("}")
	return builder.String()
}

func (dag *DAG) TopologicalSort() [][]string {
	visited := make(map[string]bool)
	depth := make(map[string]int)
	var dfs func(*Node, int)

	dfs = func(node *Node, currentDepth int) {
		if visited[node.Data] {
			if currentDepth <= depth[node.Data] {
				return
			}
		}
		visited[node.Data] = true
		depth[node.Data] = currentDepth

		for _, child := range node.Children {
			dfs(child, currentDepth+1)
		}
	}

	for _, root := range dag.findRoots() {
		dfs(root, 0)
	}

	maxDepth := 0
	for _, d := range depth {
		if d > maxDepth {
			maxDepth = d
		}
	}

	result := make([][]string, maxDepth+1)
	for nodeData, d := range depth {
		result[d] = append(result[d], nodeData)
	}

	return result
}
