package cmd

import (
	"context"
	"errors"
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"sync"

	"github.com/urfave/cli/v3"
	"github.com/videahealth/pg-snap/internal/db"
	"github.com/videahealth/pg-snap/internal/pgcommand"
	"github.com/videahealth/pg-snap/internal/utils"
)

func LoadPgTables(dirPath string, dbConn *db.Db) ([]db.Table, error) {
	var pgTables []db.Table

	dirFS := os.DirFS(dirPath)

	entries, err := fs.ReadDir(dirFS, ".")
	if err != nil {
		return nil, err
	}

	for _, entry := range entries {
		if entry.IsDir() {
			fullPath := filepath.Join(dirPath, entry.Name(), "table.bin")

			pgTable, err := db.DeserializeTable(fullPath, dbConn)
			if err != nil {
				return nil, err
			}

			pgTables = append(pgTables, *pgTable)
		}
	}

	return pgTables, nil
}

func IsExtTable(exts []db.ExtTable, table *db.Table) bool {
	for _, exTable := range exts {
		if exTable.Name == table.Details.Name && exTable.Schema == table.Details.Schema {
			return true
		}
	}
	return false
}

func readFromFileAndWriteToDb(path string, table *db.Table, pg *db.Db, isExtTable bool) error {
	fullPath, err := filepath.Abs(path)
	if err != nil {
		return fmt.Errorf("failed to get absolute path: %w", err)
	}

	// fullTableName := fmt.Sprintf("%s.%s", table.Details.Schema, table.Details.Name)
	tableToCopy := table.Details.Name
	var schemaToCopy *string = &table.Details.Schema
	isTmpTable := false

	if isExtTable {
		tmpTable, err := pg.CreateTempTable(tableToCopy, table.Details.Schema)
		if err != nil {
			return fmt.Errorf("failed to create temp table. tableToCopy=%s, Schema=%s: %w", tableToCopy, table.Details.Schema, err)
		}
		tableToCopy = tmpTable
		schemaToCopy = nil
		isTmpTable = true
	}

	fmt.Printf("Copying table %s.%s\n", table.Details.Schema, table.Details.Name)

	rowsCopied, err := table.CopyIn(fullPath, tableToCopy, schemaToCopy)
	if err != nil {
		return fmt.Errorf("error copying for table %s.%s: %w", table.Details.Schema, table.Details.Name, err)
	}
	fmt.Printf("Copied %d rows from %s.%s\n", rowsCopied, table.Details.Schema, table.Details.Name)

	if isTmpTable {
		if _, err := pg.CopyFromTempTable(table.Details.Identifier, tableToCopy); err != nil {
			return fmt.Errorf("error copying from temp table %s.%s: %w", table.Details.Schema, table.Details.Name, err)
		}
	}

	return nil
}

func Restore(ctx context.Context, cmd *cli.Command) error {
	dbParams := *utils.ParseFromCli(cmd)
	pg, err := db.NewDb(context.Background(), dbParams)

	if err != nil {
		return err
	}

	pgDbVersion := pg.GetVersion()
	pgDumpVersion, err := pgcommand.GetPgCmdVersion("pg_restore")

	if err != nil {
		return err
	}

	if err := utils.ValidateDbVersion(pgDbVersion, pgDumpVersion); err != nil {
		return errors.New("major postgres version does not match pg_dump")
	}

	root := "./data-dump"

	tables, err := LoadPgTables(root, pg)

	if err != nil {
		return err
	}

	utils.AskForConfirmation(fmt.Sprintf("Warning! this operation will drop the database %s, do you wish to continue?", dbParams.Db))

	if err := pg.DropAndCreateDb(); err != nil {
		return err
	}

	ddlPath, err := filepath.Abs(filepath.Join(root, "ddl.sql"))
	if err != nil {
		return err
	}

	if err := pgcommand.ExecuteDDLFile(&dbParams, ddlPath); err != nil {
		return err
	}

	extTables, err := pg.GetExtensions()
	if err != nil {
		return err
	}

	concurrencyLimit := make(chan struct{}, 5)
	var wg sync.WaitGroup

	for _, table := range tables {
		wg.Add(1)

		concurrencyLimit <- struct{}{}

		go func(tbl db.Table) {
			defer wg.Done()

			isExtention := IsExtTable(extTables, &tbl)
			dirPath := filepath.Join(root, tbl.Details.Name, "data.csv")

			if err := readFromFileAndWriteToDb(dirPath, &tbl, pg, isExtention); err != nil {
				fmt.Println(err)
			}

			<-concurrencyLimit
		}(table)
	}
	wg.Wait()

	fmt.Println("Executing table DDLs")

	fksPath, err := filepath.Abs(filepath.Join(root, "fk_constraints.sql"))
	if err != nil {
		return err
	}

	if err := pgcommand.ExecuteDDLFile(&dbParams, fksPath); err != nil {
		return err
	}

	fmt.Println("Writing SEQ")

	if err := pg.WriteTableSequences(); err != nil {
		return err
	}

	return nil
}
