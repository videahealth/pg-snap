package db

import (
	"bufio"
	"bytes"
	"context"
	"encoding/gob"
	"fmt"
	"os"
	"strings"
)

type TableInfo struct {
	Name       string
	Schema     string
	Identifier string
}

type Table struct {
	Details *TableInfo
	db      *Db
}

// readFirstLine reads the first line from the file for use as column names in the COPY command.
// Implement this function based on your specific needs, such as using bufio.Scanner.
func readFirstLine(file *os.File) (string, error) {

	scanner := bufio.NewScanner(file)
	if scanner.Scan() {
		firstLine := scanner.Text()
		segments := strings.Split(firstLine, ",")
		for i, segment := range segments {
			segments[i] = fmt.Sprintf("\"%s\"", segment)
		}
		quotedLine := strings.Join(segments, ",")
		return quotedLine, nil
	}

	if err := scanner.Err(); err != nil {
		return "", fmt.Errorf("error reading file: %w", err)
	}

	return "", fmt.Errorf("file is empty")
}

func NewTable(name string, schema string, db *Db) Table {
	identifer := fmt.Sprintf("\"%s\".\"%s\"", schema, name)
	return Table{
		Details: &TableInfo{
			Name:       name,
			Schema:     schema,
			Identifier: identifer,
		},
		db: db,
	}
}

func (t *Table) CopyOut(path string) (int64, error) {
	file, err := os.OpenFile(path, os.O_CREATE|os.O_RDWR, 0666)
	if err != nil {
		return 0, err
	}
	defer file.Close()
	sql := fmt.Sprintf("COPY %s TO STDOUT WITH CSV HEADER DELIMITER ','", t.Details.Identifier)
	rows, err := t.db.CopyFrom(context.Background(), file, sql)
	if err != nil {
		return 0, err
	}
	return rows, nil
}

func (t *Table) CopyIn(path string, name string, schema *string) (int64, error) {
	file, err := os.Open(path)
	if err != nil {
		return 0, err
	}
	firstLine, err := readFirstLine(file)
	file.Seek(0, 0)
	if err != nil {
		return 0, err
	}
	defer file.Close()

	var copyCmd string
	if schema != nil {
		copyCmd = fmt.Sprintf("COPY \"%s\".\"%s\"(%s) FROM STDIN WITH CSV HEADER DELIMITER ','", *schema, name, firstLine)
	} else {
		copyCmd = fmt.Sprintf("COPY \"%s\"(%s) FROM STDIN WITH CSV HEADER DELIMITER ','", name, firstLine)
	}

	rows, err := t.db.CopyTo(context.Background(), file, copyCmd)
	if err != nil {
		return 0, err
	}
	return rows, nil
}

func (t *Table) SerializeTable(path string) error {
	var b bytes.Buffer

	enc := gob.NewEncoder(&b)
	if err := enc.Encode(t.Details); err != nil {
		return err
	}

	serializedData := b.Bytes()

	err := os.WriteFile(path, serializedData, 0644)
	if err != nil {
		return err
	}

	return nil
}

func DeserializeTable(path string, db *Db) (*Table, error) {
	// Read the serialized data from the file
	serializedData, err := os.ReadFile(path)
	if err != nil {
		return nil, err
	}

	var b bytes.Buffer
	b.Write(serializedData)

	dec := gob.NewDecoder(&b)

	var table Table
	if err := dec.Decode(&table.Details); err != nil {
		return nil, err
	}
	table.db = db

	return &table, nil
}
