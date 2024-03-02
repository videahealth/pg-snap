package relations

import (
	"encoding/csv"
	"fmt"
	"os"
)

func ReadCSVColumnByName(filePath string, columnName string) ([]string, error) {
	file, err := os.Open(filePath)
	if err != nil {
		return nil, fmt.Errorf("error opening CSV file: %w", err)
	}
	defer file.Close()

	reader := csv.NewReader(file)

	header, err := reader.Read()
	if err != nil {
		return nil, fmt.Errorf("error reading CSV header: %w", err)
	}

	columnIndex := -1
	for i, name := range header {
		if name == columnName {
			columnIndex = i
			break
		}
	}

	if columnIndex == -1 {
		return nil, fmt.Errorf("column '%s' not found", columnName)
	}

	var columnData []string

	for {
		record, err := reader.Read()
		if err != nil {
			break
		}
		if len(record) > columnIndex {
			columnData = append(columnData, record[columnIndex])
		}
	}

	return columnData, nil
}
