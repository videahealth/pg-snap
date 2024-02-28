package relations

import (
	"encoding/csv"
	"fmt"
	"os"
)

func ReadCSVColumnByName(filePath string, columnName string) ([]string, error) {
	// Open the CSV file
	file, err := os.Open(filePath)
	if err != nil {
		return nil, fmt.Errorf("error opening CSV file: %w", err)
	}
	defer file.Close()

	// Create a new CSV reader
	reader := csv.NewReader(file)

	// Read the first row to find the index of the column
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

	// Slice to hold values of the specific column
	var columnData []string

	// Read the CSV file
	for {
		record, err := reader.Read()
		if err != nil {
			break // Reached the end of the file
		}
		// Append the value of the specific column to the slice, if it exists
		if len(record) > columnIndex {
			columnData = append(columnData, record[columnIndex])
		}
	}

	return columnData, nil
}
