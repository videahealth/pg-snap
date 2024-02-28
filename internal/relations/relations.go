package relations

import (
	"fmt"
	"math"
	"strings"

	"github.com/videahealth/pg-snap/internal/db"
)

func reverse[S ~[]E, E any](s S) {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		s[i], s[j] = s[j], s[i]
	}
}

func GetTable(tables []db.Table, id string) (*db.Table, error) {
	for _, table := range tables {
		if table.Details.Identifier == id {
			return &table, nil
		}
	}
	return nil, fmt.Errorf("error table not found for name %s", id)
}

func GetTablePredecessors(schema string, name string, relations []db.ForeignKeyInfo) []db.ForeignKeyInfo {
	var preds []db.ForeignKeyInfo

	for _, rel := range relations {
		if schema == rel.ForeignSchema && name == rel.ForeignName {
			preds = append(preds, rel)
		}
	}
	return preds
}

func GetRelations(pg *db.Db, tables []db.Table, sampleTable string, numSample int) error {
	relations, err := pg.GetForeignKeys()

	if err != nil {
		return err
	}

	dag := &DAG{}

	for _, rel := range relations {
		node1 := dag.CreateOrGetNode(db.NormalizeName(rel.Schema, rel.Name))
		node2 := dag.CreateOrGetNode(db.NormalizeName(rel.ForeignSchema, rel.ForeignName))

		dag.AddNode(node1)
		dag.AddNode(node2)

		dag.AddEdge(node1, node2)
	}

	fmt.Println(dag.ToGraphviz())

	sorted := dag.TopologicalSort()
	reverse(sorted)

	for depth, group := range sorted {
		fmt.Printf("Depth %d: %v\n", depth, group)
	}

	first := sorted[0]
	rest := sorted[1:]
	L := 5

	var tablesComb []db.Table

	for _, tableId := range first {
		table, err := GetTable(tables, tableId)
		if err != nil {
			return err
		}
		numRows, err := table.GetNumRows()
		if err != nil {
			return err
		}
		rowsToQuery := int64(math.Round(float64(numRows) * float64(L) * 0.01))
		table.SampleQuery = fmt.Sprintf("SELECT * FROM %s LIMIT %d", table.Details.Identifier, rowsToQuery)
		tablesComb = append(tablesComb, *table)
	}

	for _, tableList := range rest {
		for _, tableId := range tableList {
			table, err := GetTable(tables, tableId)
			if err != nil {
				return err
			}
			predecessors := GetTablePredecessors(table.Details.Schema, table.Details.Name, relations)
			table.SampleQuery = BuildSelectQuery(table.Details.Identifier, predecessors)
			tablesComb = append(tablesComb, *table)
		}
	}

	for _, comb := range tablesComb {
		fmt.Println(comb.SampleQuery)
	}

	return nil
}

func BuildSelectQuery(mainTable string, predecessors []db.ForeignKeyInfo) string {
	var query strings.Builder
	query.WriteString(fmt.Sprintf("SELECT %s.* FROM %s", mainTable, mainTable))

	for _, fk := range predecessors {
		// Assuming the foreign key relationships are direct and there's no need for aliasing for simplicity
		joinClause := fmt.Sprintf(" LEFT JOIN %s.%s ON %s.%s = %s.%s",
			fk.ForeignSchema, fk.ForeignName, // JOIN table
			mainTable, fk.ColumnName, // main table column
			fk.ForeignName, fk.ForeignColumnName) // foreign table column

		query.WriteString(joinClause)
	}

	return query.String()
}
