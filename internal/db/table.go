package db

import (
	"bufio"
	"bytes"
	"context"
	"encoding/gob"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/charmbracelet/log"
	"github.com/videahealth/pg-snap/internal/utils"
)

type Col struct {
	Name string
	Type string
}

type TableInfo struct {
	Name       string
	Schema     string
	Identifier string
	Display    string
}

type Table struct {
	Details     *TableInfo
	db          *Db
	Id          string
	SampleQuery string
	NumRows     int64
	Cols        []Col
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

func NewTable(name string, schema string, cols []Col) *Table {
	identifer := NormalizeName(schema, name)
	display := fmt.Sprintf("%s.%s", schema, name)

	return &Table{
		Details: &TableInfo{
			Name:       name,
			Schema:     schema,
			Identifier: identifer,
			Display:    display,
		},
		Id:   display,
		Cols: cols,
	}
}

func (t *Table) AddDbConn(db *Db) {
	t.db = db
}

func (t *Table) CopyOut(path, query string) (int64, error) {
	file, err := os.OpenFile(path, os.O_CREATE|os.O_RDWR, 0666)
	if err != nil {
		return 0, err
	}
	defer file.Close()
	file.Seek(0, 0)
	sql := fmt.Sprintf("COPY (%s) TO STDOUT WITH CSV HEADER DELIMITER ','", query)
	if query == "" {
		sql = fmt.Sprintf("COPY (SELECT * FROM %s) TO STDOUT WITH CSV HEADER DELIMITER ','", t.Details.Identifier)
	}
	rows, err := t.db.CopyFrom(context.Background(), file, sql)
	if err != nil {
		return 0, err
	}
	return rows, nil
}

func (t *Table) CopyOutPaginated(path, query string, pageSize int64) error {
	file, err := os.OpenFile(path, os.O_CREATE|os.O_RDWR, 0666)
	if err != nil {
		return err
	}
	defer file.Close()

	var offset int64 = 0
	for {
		var sql string
		head := ""
		if offset == 0 {
			head = " HEADER DELIMITER ','"
		}
		if query == "" {
			sql = fmt.Sprintf("COPY (SELECT * FROM %s LIMIT %d OFFSET %d) TO STDOUT WITH CSV%s", t.Id, pageSize, offset, head)
		} else {
			sql = fmt.Sprintf("COPY (%s LIMIT %d OFFSET %d) TO STDOUT WITH CSV%s", query, pageSize, offset, head)
		}

		rows, err := t.db.CopyFrom(context.Background(), file, sql)
		if err != nil {
			fmt.Println(sql)
			return err
		}

		if rows == 0 {
			break
		}

		offset += pageSize
	}

	return nil
}

func (t *Table) GetNumRows() (int64, error) {
	rows := t.db.Conn.QueryRow(context.Background(), fmt.Sprintf("SELECT count(*) as cnt from %s", t.Details.Identifier))
	var count int64
	if err := rows.Scan(&count); err != nil {
		return 0, err
	}
	return count, nil
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

func (t *Table) PerformCopy(root string, query string) int64 {
	log.Debug(utils.SprintfNoNewlines("COPYING data from table %s", t.Details.Display))

	dirPath := filepath.Join(root, t.Details.Display)

	if err := os.MkdirAll(dirPath, os.ModePerm); err != nil {
		log.Error("Error copying for table %s: %s", t.Details.Display, err)
	}

	path := filepath.Join(dirPath, "data.csv")
	dataPath := filepath.Join(dirPath, "table.bin")
	rows, err := t.CopyOut(path, query)
	if err != nil {
		log.Error("Error copying data for table", "table", t.Details.Display, "err", err)
	}

	err = t.SerializeTable(dataPath)

	if err != nil {
		log.Error("Error serializing data for table %s: %w", t.Details.Display, err)
	}

	if err := os.MkdirAll(dirPath, os.ModePerm); err != nil {
		log.Error("Error serializing data for table %s: %s", t.Details.Display, err)
	}

	return rows

}

func NormalizeName(s, n string) string {
	return fmt.Sprintf("\"%s\".\"%s\"", s, n)
}
