package relations

import (
	"fmt"
	"reflect"
	"strings"
	"testing"

	"github.com/videahealth/pg-snap/internal/db"
)

func TestFormatCols(t *testing.T) {
	var tests = []struct {
		data    []string
		colType string
		want    string
	}{
		{[]string{"a", "b", "c", "d"}, "text", "'a','b','c','d'"},
		{[]string{"235435", "9999099", "3454352", "324234"}, "int4", "235435,9999099,3454352,324234"},
		{[]string{"2024-03-02T00:52:41.245Z", "2024-03-02T00:52:41.245Z", "2024-03-02T00:52:41.245Z"}, "timestamptz", "'2024-03-02T00:52:41.245Z','2024-03-02T00:52:41.245Z','2024-03-02T00:52:41.245Z'"},
	}

	for _, tt := range tests {
		testname := fmt.Sprintf("FormatCols([%s],%s)", strings.Join(tt.data, ","), tt.colType)
		t.Run(testname, func(t *testing.T) {
			got, err := FormatCols(tt.data, tt.colType)
			if err != nil {
				t.Errorf("ERROR: %s", err)
			}
			if got != tt.want {
				t.Errorf("%s; got %s want %s", testname, got, tt.want)
			}
		})
	}
}

func TestGetTableFk(t *testing.T) {
	mockRelations := []db.ForeignKeyInfo{
		{
			Schema:            "public",
			Name:              "user_id_fk",
			ColumnName:        "user_id",
			ForeignSchema:     "auth",
			ForeignName:       "users",
			ForeignColumnName: "id",
			SourceTableId:     "1",
			ForeignTableId:    "2",
			ForeignColType:    "uuid",
			ColType:           "uuid",
		},
		{
			Schema:            "orders",
			Name:              "product_id_fk",
			ColumnName:        "product_id",
			ForeignSchema:     "inventory",
			ForeignName:       "products",
			ForeignColumnName: "id",
			SourceTableId:     "3",
			ForeignTableId:    "4",
			ForeignColType:    "int",
			ColType:           "int",
		},
	}

	tests := []struct {
		name          string
		ftSchema      string
		ftName        string
		schema        string
		tableName     string
		relations     []db.ForeignKeyInfo
		wantRelations []db.ForeignKeyInfo
	}{
		{
			name:          "Match found in auth.users",
			ftSchema:      "auth",
			ftName:        "users",
			schema:        "public",
			tableName:     "user_id_fk",
			relations:     mockRelations,
			wantRelations: []db.ForeignKeyInfo{mockRelations[0]},
		},
		{
			name:          "Match found in inventory.products",
			ftSchema:      "inventory",
			ftName:        "products",
			schema:        "orders",
			tableName:     "product_id_fk",
			relations:     mockRelations,
			wantRelations: []db.ForeignKeyInfo{mockRelations[1]},
		},
		{
			name:          "No match found",
			ftSchema:      "nonexistent",
			ftName:        "table",
			schema:        "public",
			tableName:     "user_id_fk",
			relations:     mockRelations,
			wantRelations: nil,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := GetTableFk(tt.ftSchema, tt.ftName, tt.schema, tt.tableName, tt.relations)
			if !reflect.DeepEqual(got, tt.wantRelations) {
				t.Errorf("GetTableFk() = %v, want %v", got, tt.wantRelations)
			}
		})
	}
}
