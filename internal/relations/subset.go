package relations

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

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
	Tables           []db.Table
	StartTableName   string
	StartTableSchema string
	SubsetQuery      string
	DAG              DAG
}

func NewSubset(pg *db.Db, tables []db.Table) (*Subset, error) {
	relations, err := pg.GetForeignKeys()
	if err != nil {
		return nil, err
	}

	var rels []db.ForeignKeyInfo

	for _, rel := range relations {
		mainTable, _ := GetTable(tables, db.NormalizeName(rel.Schema, rel.Name))
		otherTable, _ := GetTable(tables, db.NormalizeName(rel.ForeignSchema, rel.ForeignName))
		if mainTable != nil && otherTable != nil {
			rels = append(rels, rel)
		}
	}

	return &Subset{
		Relations:        rels,
		Tables:           tables,
		StartTableName:   "ImagingPatients",
		StartTableSchema: "public",
		SubsetQuery:      `select * from "ImagingPatients" where id in (5717,5716,5715,5705,5704,5703,5702)`,
		DAG:              BuildRelations(rels),
	}, nil
}

func (s *Subset) Visit() {
	copiedData := make(map[*Node]bool)
	gVisited := make(map[*Node]bool)
	startNode := s.DAG.FindNodeByData(db.NormalizeName(s.StartTableSchema, s.StartTableName))
	newDAG := s.DAG.FindClosedSystemFullDAG(startNode)

	visitNode := func(node *Node, visitMode VisitMode) bool {
		table, err := GetTable(s.Tables, node.Data)

		gVisited[node] = true

		if err != nil {
			log.Fatalf("error getting table: %s", err)
			return false
		}

		if !copiedData[node] {
			if node.Data == db.NormalizeName(s.StartTableSchema, s.StartTableName) {
				PerformCopy(*table, s.SubsetQuery)
				copiedData[node] = true
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
					vis := gVisited[p]

					if vis && copiedData[p] {
						var q string
						if visitMode == VisitSuccessors {
							q = BuildSuccessorQuery(p.Data, node.Data, s.Relations, s.Tables)
						} else {
							q = BuildPredecessorQuery(p.Data, node.Data, s.Relations, s.Tables)
						}
						if q != "" {
							conditions = append(conditions, q)
						}
					}
				}

				if len(conditions) > 0 {
					queryCondition := strings.Join(conditions, " OR ")
					selectSt := fmt.Sprintf("SELECT * FROM %s WHERE %s", node.Data, queryCondition)
					PerformCopy(*table, selectSt)
					copiedData[node] = true
				}
			}
		}
		return true
	}

	nodes := newDAG.TraverseGraphFromStart(startNode)
	for _, node := range nodes {
		visitNode(node, VisitSuccessors)
		visitNode(node, VisitPredecessors)
	}

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
			if !copiedData[node] {
				visitNode(node, VisitPredecessors)
				visitNode(node, VisitSuccessors)
			}
		}
	}
}

func GetTableDetailsAndCsvPath(tables []db.Table, toCopyId string, foreignTableId string) (toCopy *db.Table, foreignTable *db.Table, foreignTableCsvPath string, err error) {
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

func BuildConditions(toCopyId string, foreignTableCsvPath string, cols []db.ForeignKeyInfo, visitMode VisitMode) []string {
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

		colData := FormatCols(data, fkColType)
		if len(colData) == 0 {
			continue
		}
		condition := fmt.Sprintf("\"%s\" IN (%s)", fkCol, colData) // Adjust based on the function requirements
		conditions = append(conditions, condition)
	}

	return conditions
}

func BuildSuccessorQuery(foreignTableId string, toCopyId string, relations []db.ForeignKeyInfo, tables []db.Table) string {
	toCopy, foreignTable, foreignTableCsvPath, err := GetTableDetailsAndCsvPath(tables, toCopyId, foreignTableId)
	if err != nil {
		log.Fatalf("error in preparation: %s", err)
	}

	cols := GetTableFk(foreignTable.Details.Schema, foreignTable.Details.Name, toCopy.Details.Schema, toCopy.Details.Name, relations)
	conditions := BuildConditions(toCopyId, foreignTableCsvPath, cols, VisitSuccessors)

	if len(conditions) != 0 {
		return strings.Join(conditions, " OR ")
	}
	return ""
}

func BuildPredecessorQuery(foreignTableId string, toCopyId string, relations []db.ForeignKeyInfo, tables []db.Table) string {
	toCopy, foreignTable, foreignTableCsvPath, err := GetTableDetailsAndCsvPath(tables, toCopyId, foreignTableId)
	if err != nil {
		log.Fatalf("error in preparation: %s", err)
	}

	cols := GetTableFk(toCopy.Details.Schema, toCopy.Details.Name, foreignTable.Details.Schema, foreignTable.Details.Name, relations)
	conditions := BuildConditions(toCopyId, foreignTableCsvPath, cols, VisitPredecessors)

	if len(conditions) != 0 {
		return strings.Join(conditions, " OR ")
	}
	return ""
}

func FormatCols(data []string, colType string) string {
	var dataVals []string

	for _, d := range data {
		if d == "" {
			continue
		}
		switch t := colType; t {
		case "character":
			dataVals = append(dataVals, fmt.Sprintf(`'%s'`, d))
		case "text":
			dataVals = append(dataVals, fmt.Sprintf(`'%s'`, d))
		case "integer":
			dataVals = append(dataVals, d)
		case "bigint":
			dataVals = append(dataVals, d)
		case "character varying":
			dataVals = append(dataVals, fmt.Sprintf(`'%s'`, d))
		case "uuid":
			dataVals = append(dataVals, fmt.Sprintf(`'%s'`, d))
		default:
			log.Errorf("unsopported data type %s", t)
			os.Exit(1)
		}
	}

	return strings.Join(dataVals, ",")
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

func PerformCopy(tbl db.Table, query string) {
	root := "./data-dump"

	log.Debug(utils.SprintfNoNewlines("COPYING data from table %s", tbl.Details.Display))

	dirPath := filepath.Join(root, tbl.Details.Display)

	if err := os.MkdirAll(dirPath, os.ModePerm); err != nil {
		log.Error("Error copying for table %s: %s", tbl.Details.Display, err)
	}

	path := filepath.Join(dirPath, "data.csv")
	dataPath := filepath.Join(dirPath, "table.bin")

	err := tbl.CopyOutPaginated(path, query, int64(100))
	if err != nil {
		log.Error("Error copying data for table %s: %w", tbl.Details.Display, err)
	}

	err = tbl.SerializeTable(dataPath)

	if err != nil {
		log.Error("Error serializing data for table %s: %w", tbl.Details.Display, err)
	}

	if err := os.MkdirAll(dirPath, os.ModePerm); err != nil {
		log.Error("Error serializing data for table %s: %s", tbl.Details.Display, err)
	}

}