package db

import (
	"context"
	"fmt"
	"os"
)

type Table struct {
	Name      string
	Schema    string
	Identifer string
	db        *Db
}

func NewTable(name string, schema string, db *Db) Table {
	identifer := fmt.Sprintf("\"%s\".\"%s\"", schema, name)
	return Table{
		Name:      name,
		Schema:    schema,
		Identifer: identifer,
		db:        db,
	}
}

func (t *Table) CopyOut(path string) error {
	file, err := os.OpenFile(path, os.O_CREATE|os.O_RDWR, 0666)
	if err != nil {
		return err
	}
	defer file.Close()
	sql := fmt.Sprintf("COPY (SELECT * FROM %s) TO STDOUT WITH CSV HEADER", t.Identifer)
	if err := t.db.CopyFrom(context.Background(), file, sql); err != nil {
		return err
	}
	return nil
}
