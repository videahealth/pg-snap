package dump

import (
	"reflect"
	"testing"
)

func TestParseSkipTables(t *testing.T) {
	tests := []struct {
		name string
		st   string
		want map[string]struct{}
	}{
		{
			name: "empty string",
			st:   "",
			want: map[string]struct{}{},
		},
		{
			name: "single item",
			st:   "table1",
			want: map[string]struct{}{"table1": {}},
		},
		{
			name: "multiple items",
			st:   "table1,table2,table3",
			want: map[string]struct{}{"table1": {}, "table2": {}, "table3": {}},
		},
		{
			name: "leading and trailing spaces",
			st:   " table1 , table2 , table3 ",
			// Assuming the function does not trim spaces. If it should, adjust the function and the expected result accordingly.
			want: map[string]struct{}{" table1 ": {}, " table2 ": {}, " table3 ": {}},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := ParseSkipTables(tt.st); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("ParseSkipTables(%v) = %v, want %v", tt.st, got, tt.want)
			}
		})
	}
}
