package relations

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"sync/atomic"

	"github.com/charmbracelet/log"
	"github.com/videahealth/pg-snap/internal/db"
	"github.com/videahealth/pg-snap/internal/utils"
)

type VisitMode string

const (
	VisitSuccessors   VisitMode = "successors"
	VisitPredecessors VisitMode = "predecessors"
)

type Row struct {
	Table   *db.Table
	ColName string
	Data    string
}

type Subset struct {
	Relations        []db.ForeignKeyInfo
	Tables           []*db.Table
	StartTableName   string
	StartTableSchema string
	SubsetQuery      string
	DAG              DAG
	RootFolder       string
	MaxRowsPerTable  int32
}

func NewSubset(pg *db.Db, tables []*db.Table, startTable, startSchema, rootFolder, query string, maxRowsPerTable int32) (*Subset, error) {
	relations := pg.GetForeignKeys()

	var rels []db.ForeignKeyInfo

	for _, rel := range relations {

		mainTable, _ := GetTable(tables, db.NormalizeName(rel.Schema, rel.Name))
		otherTable, _ := GetTable(tables, db.NormalizeName(rel.ForeignSchema, rel.ForeignName))
		if mainTable != nil && otherTable != nil {
			rels = append(rels, rel)
		}
	}

	var maxRows int32
	if maxRowsPerTable == 0 {
		maxRows = -1
	} else {
		maxRows = maxRowsPerTable
	}

	return &Subset{
		Relations:        rels,
		Tables:           tables,
		StartTableName:   startTable,
		StartTableSchema: startSchema,
		SubsetQuery:      fmt.Sprintf("SELECT * FROM %s WHERE %s", db.NormalizeName(startSchema, startTable), query),
		DAG:              BuildRelations(rels),
		RootFolder:       rootFolder,
		MaxRowsPerTable:  maxRows,
	}, nil
}

// TraverseAndCopyData performs a subset algorithm to copy Table data across a directed acyclic graph (DAG) with the following steps:
//  1. Identifies a new closed system DAG starting from the `startNode`.
//  2. Traverses the graph from the start, generating a list of nodes connected (directly or indirectly) to the `startNode`.
//  3. Iterates over each node, visiting all its predecessors and successors to understand the graph's connectivity.
//  4. Checks if a node's data has already been copied; if so, it skips to the next node to avoid duplication.
//  5. If the node is the `startNode`, it copies its data immediately and proceeds no further with this node.
//  6. For other nodes, it determines the connected nodes based on the traversal direction. If data for these connected nodes has been copied,
//     it resolves the foreign key (FK) relationships. It then copies the data that connects from the current node to the nodes being visited,
//     ensuring data integrity and relational consistency.
func (s *Subset) TraverseAndCopyData() error {

	copiedData := make(map[string]bool)
	gVisited := make(map[string]bool)
	startTable := db.NormalizeName(s.StartTableSchema, s.StartTableName)
	startNode := s.DAG.FindNodeByData(startTable)
	if startNode == nil {
		return fmt.Errorf("table %s not found in database", startTable)
	}
	newDAG := s.DAG.FindClosedSystemFullDAG(startNode)
	var ops atomic.Uint64
	total := len(s.Tables)

	visitNode := func(node *Node, visitMode VisitMode) error {
		table, err := GetTable(s.Tables, node.Data)

		gVisited[node.Data] = true

		if err != nil {
			log.Fatalf("error getting table: %s", err)
			return nil
		}

		isRootNode := node.Data == db.NormalizeName(s.StartTableSchema, s.StartTableName)

		if !copiedData[node.Data] {
			if isRootNode {
				rows := table.PerformCopy(s.RootFolder, s.SubsetQuery)
				utils.DisplayProgress(&ops, rows, total, table.Details.Display)
				copiedData[node.Data] = true
			} else {
				var conditions []string
				var queryNodes []*Node

				switch visitMode {
				case VisitSuccessors:
					queryNodes = node.Children
				case VisitPredecessors:
					queryNodes = newDAG.FindPredecessors(node)
				}
				for _, p := range queryNodes {
					vis := gVisited[p.Data]
					if vis && copiedData[p.Data] {
						var q string
						if visitMode == VisitSuccessors {
							q, err = BuildSuccessorQuery(p.Data, node.Data, s.Relations, s.Tables)
							if err != nil {
								return err
							}
						} else {
							q, err = BuildPredecessorQuery(p.Data, node.Data, s.Relations, s.Tables)
							if err != nil {
								return err
							}
						}
						if q != "" {
							conditions = append(conditions, q)
						}
					}
				}

				if len(conditions) > 0 {
					if node.Data == "\"public\".\"food_des\"" {
						fmt.Println(len(conditions))
					}
					queryCondition := strings.Join(conditions, " OR ")
					var selectSt string
					if s.MaxRowsPerTable == -1 || visitMode == VisitPredecessors {
						selectSt = fmt.Sprintf("SELECT * FROM %s WHERE %s", node.Data, queryCondition)
					} else {
						selectSt = fmt.Sprintf("SELECT * FROM %s WHERE %s LIMIT %d", node.Data, queryCondition, s.MaxRowsPerTable)
					}
					rows := table.PerformCopy(s.RootFolder, selectSt)
					utils.DisplayProgress(&ops, rows, total, table.Details.Display)
					copiedData[node.Data] = true
				}
			}
		}
		return nil
	}

	nodes := newDAG.TraverseGraphFromStart(startNode)
	for {
		totalCopied := 0
		for _, visited := range copiedData {
			if visited {
				totalCopied++
			}
		}
		if totalCopied >= len(newDAG.Nodes) {
			break
		}
		for _, node := range nodes {
			if !copiedData[node.Data] {
				if err := visitNode(node, VisitPredecessors); err != nil {
					return err
				}
				if err := visitNode(node, VisitSuccessors); err != nil {
					return err
				}
			}
		}
	}

	return nil
}

func GetTableDetailsAndCsvPath(tables []*db.Table, toCopyId string, foreignTableId string) (toCopy *db.Table, foreignTable *db.Table, foreignTableCsvPath string, err error) {
	toCopy, err = GetTable(tables, toCopyId)
	if err != nil {
		log.Fatalf("error getting table: %s", err)
	}
	foreignTable, err = GetTable(tables, foreignTableId)
	if err != nil {
		log.Fatalf("error getting table: %s", err)
	}
	foreignTableCsvPath = filepath.Join("./data-dump", foreignTable.Details.Display, "data.csv")
	return
}

func BuildConditions(toCopyId string, foreignTableCsvPath string, cols []db.ForeignKeyInfo, visitMode VisitMode) ([]string, error) {
	var conditions []string

	for _, fk := range cols {
		fkCol := fk.ForeignColumnName
		csvCol := fk.ColumnName
		fkColType := fk.ColType
		if visitMode == VisitSuccessors {
			fkCol = fk.ColumnName
			csvCol = fk.ForeignColumnName
			fkColType = fk.ForeignColType
		}

		data, err := ReadCSVColumnByName(foreignTableCsvPath, csvCol)
		if err != nil {
			log.Fatalf("error getting csv data for table: %s: %s", foreignTableCsvPath, err)
			os.Exit(1)
			continue
		}
		if len(data) == 0 {
			continue
		}

		colData, err := FormatCols(data, fkColType)
		if err != nil {
			return []string{}, err
		}
		if len(colData) == 0 {
			continue
		}
		condition := fmt.Sprintf("\"%s\" IN (%s)", fkCol, colData) // Adjust based on the function requirements
		conditions = append(conditions, condition)
	}

	return conditions, nil
}

func BuildSuccessorQuery(foreignTableId string, toCopyId string, relations []db.ForeignKeyInfo, tables []*db.Table) (string, error) {
	toCopy, foreignTable, foreignTableCsvPath, err := GetTableDetailsAndCsvPath(tables, toCopyId, foreignTableId)
	if err != nil {
		log.Fatalf("error in preparation: %s", err)
	}

	cols := GetTableFk(foreignTable.Details.Schema, foreignTable.Details.Name, toCopy.Details.Schema, toCopy.Details.Name, relations)
	conditions, err := BuildConditions(toCopyId, foreignTableCsvPath, cols, VisitSuccessors)

	if err != nil {
		return "", err
	}

	if len(conditions) != 0 {
		return strings.Join(conditions, " OR "), nil
	}
	return "", nil
}

func BuildPredecessorQuery(foreignTableId string, toCopyId string, relations []db.ForeignKeyInfo, tables []*db.Table) (string, error) {
	toCopy, foreignTable, foreignTableCsvPath, err := GetTableDetailsAndCsvPath(tables, toCopyId, foreignTableId)
	if err != nil {
		log.Fatalf("error in preparation: %s", err)
	}

	cols := GetTableFk(toCopy.Details.Schema, toCopy.Details.Name, foreignTable.Details.Schema, foreignTable.Details.Name, relations)
	conditions, err := BuildConditions(toCopyId, foreignTableCsvPath, cols, VisitPredecessors)
	if err != nil {
		return "", err
	}
	if len(conditions) != 0 {
		return strings.Join(conditions, " OR "), nil
	}
	return "", nil
}

func FormatCols(data []string, colType string) (string, error) {
	var dataVals []string

	category, ok := db.SQLTypeMapping[colType]
	if !ok {
		log.Fatalf("unsupported data type %s", colType)
	}

	for _, d := range data {
		if d == "" {
			continue
		}
		switch {
		case category == "String types" || category == "UUID types" || colType == "varchar" || strings.Contains(category, "Character types"):
			dataVals = append(dataVals, fmt.Sprintf(`'%s'`, d))
		case category == "Numeric types" || category == "Integer types":
			dataVals = append(dataVals, d)
		case category == "Boolean types":
			dataVals = append(dataVals, d)
		case category == "Date/time types":
			dataVals = append(dataVals, fmt.Sprintf(`'%s'`, d))
		case category == "Binary types":
			dataVals = append(dataVals, fmt.Sprintf(`'%s'`, d))
		default:
			return "", fmt.Errorf("unsupported category %s for data type %s", category, colType)
		}
	}

	return strings.Join(dataVals, ","), nil
}

func GetTableFk(ftSchema, ftName, schema, name string, relations []db.ForeignKeyInfo) []db.ForeignKeyInfo {
	var preds []db.ForeignKeyInfo

	for _, rel := range relations {
		if ftSchema == rel.ForeignSchema && ftName == rel.ForeignName && rel.Name == name && rel.Schema == schema {
			preds = append(preds, rel)
		}
	}
	return preds
}

func BuildRelations(relations []db.ForeignKeyInfo) DAG {
	dag := &DAG{}

	for _, rel := range relations {
		node1 := dag.CreateOrGetNode(db.NormalizeName(rel.Schema, rel.Name))
		node2 := dag.CreateOrGetNode(db.NormalizeName(rel.ForeignSchema, rel.ForeignName))

		dag.AddNode(node1)
		dag.AddNode(node2)

		dag.AddEdge(node1, node2)
	}

	return *dag
}

func GetTable(tables []*db.Table, id string) (*db.Table, error) {
	for _, table := range tables {
		if table.Details.Identifier == id {
			return table, nil
		}
	}
	return nil, fmt.Errorf("error table not found for name %s", id)
}
