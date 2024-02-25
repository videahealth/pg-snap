package db

import (
	"testing"
)

func TestShouldSkip(t *testing.T) {
	tests := []struct {
		name         string
		tableSchema  string
		tableName    string
		skipTables   map[string]struct{}
		expectedSkip bool
	}{
		{
			name:        "Direct full name match",
			tableSchema: "public",
			tableName:   "users",
			skipTables: map[string]struct{}{
				"public.users": {},
			},
			expectedSkip: true,
		},
		{
			name:        "Schema wildcard match",
			tableSchema: "public",
			tableName:   "orders",
			skipTables: map[string]struct{}{
				"public.*": {},
			},
			expectedSkip: true,
		},
		{
			name:        "Table prefix match",
			tableSchema: "public",
			tableName:   "user_profiles",
			skipTables: map[string]struct{}{
				"public.user_": {},
			},
			expectedSkip: true,
		},
		{
			name:         "No match",
			tableSchema:  "public",
			tableName:    "products",
			skipTables:   map[string]struct{}{},
			expectedSkip: false,
		},
		{
			name:        "Table wildcard test",
			tableSchema: "Public",
			tableName:   "Event_34234",
			skipTables: map[string]struct{}{
				"public.Event*": {},
			},
			expectedSkip: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := ShouldSkip(tt.tableSchema, tt.tableName, tt.skipTables); got != tt.expectedSkip {
				t.Errorf("ShouldSkip() = %v, expected %v", got, tt.expectedSkip)
			}
		})
	}
}
