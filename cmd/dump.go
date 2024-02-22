package cmd

import (
	"context"
	"errors"
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"sync"

	"github.com/urfave/cli/v3"
	"github.com/videahealth/pg-snap/internal/db"
	"github.com/videahealth/pg-snap/internal/pgcommand"
)

func ParseSkipTables(st string) map[string]struct{} {
	parts := strings.Split(st, ",")
	tableSet := make(map[string]struct{})
	for _, part := range parts {
		tableSet[part] = struct{}{}
	}

	return tableSet
}

func CopyData(root string, table *db.Table) error {
	dirPath := filepath.Join(root, table.Name)

	if err := os.MkdirAll(dirPath, os.ModePerm); err != nil {
		return err
	}

	path := filepath.Join(dirPath, "data.csv")

	err := table.CopyOut(path)
	if err != nil {
		return err
	}

	return nil
}

func Dump(ctx context.Context, cmd *cli.Command) error {
	pg, err := db.NewDb(context.Background(), "postgres", "postgres", "localhost", 5432, "pg")

	if err != nil {
		return err
	}

	skipTablesStr := cmd.String("skip-tables")
	skipTables := ParseSkipTables(skipTablesStr)
	tables, err := pg.GetAllTables(skipTables)

	if err != nil {
		return err
	}

	v := pg.GetVersion()
	dump, err := pgcommand.NewDump(pg)
	res := dump.GetVersion(
		pgcommand.ExecOptions{
			StreamPrint:       true,
			StreamDestination: os.Stdout,
		},
	)

	if err != nil {
		return err
	}

	dbVersion, err := GetMajorVersion(v)

	if err != nil {
		return err
	}

	if !strings.Contains(res, dbVersion) {
		return errors.New("major postgres version does not match pg_dump")
	}

	if err != nil {
		return err
	}

	root := "./data-dump"

	concurrencyLimit := make(chan struct{}, 4)

	var wg sync.WaitGroup

	for _, table := range tables {
		wg.Add(1)

		concurrencyLimit <- struct{}{}

		go func(tbl *db.Table) {
			defer wg.Done()

			if err := CopyData(root, tbl); err != nil {
				fmt.Printf("Error copying: %s\n", err)
			}

			<-concurrencyLimit
		}(&table)
	}

	wg.Wait()

	path, err := filepath.Abs(filepath.Join(root, "ddl.sql"))
	if err != nil {
		return err
	}

	_, err = os.OpenFile(path, os.O_CREATE|os.O_RDWR, 0666)

	if err != nil {
		return err
	}

	r := dump.DumpDb(path)

	fmt.Println(r)

	return nil
}
