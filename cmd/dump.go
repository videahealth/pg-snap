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
	"github.com/videahealth/pg-snap/internal/utils"
)

func ParseSkipTables(st string) map[string]struct{} {
	parts := strings.Split(st, ",")
	tableSet := make(map[string]struct{})
	for _, part := range parts {
		tableSet[part] = struct{}{}
	}

	return tableSet
}

func ExtractAndRemoveFKConstraints(input string) (string, string, error) {
	lines := strings.Split(input, "\n")

	var remainingContent string
	var extractedContent string
	capture := false

	for _, line := range lines {
		if strings.HasPrefix(line, "-- Name:") {
			if strings.Contains(line, "Type: FK CONSTRAINT") {
				capture = true
			} else {
				capture = false
				remainingContent += line + "\n"
			}
		}

		if capture {
			extractedContent += line + "\n"
		} else if !strings.HasPrefix(line, "-- Name:") {
			remainingContent += line + "\n"
		}
	}

	if extractedContent == "" && remainingContent == "" {
		return "", "", errors.New("no content processed")
	}

	return extractedContent, remainingContent, nil
}

func Dump(ctx context.Context, cmd *cli.Command) error {
	dbParams := *utils.ParseFromCli(cmd)
	pg, err := db.NewDb(context.Background(), dbParams)

	if err != nil {
		return err
	}

	skipTablesStr := cmd.String("skip-tables")
	skipTables := ParseSkipTables(skipTablesStr)
	tables, err := pg.GetAllTables(skipTables)

	if err != nil {
		return err
	}

	pgDbVersion := pg.GetVersion()
	pgDumpVersion, err := pgcommand.GetPgCmdVersion("pg_dump")

	if err != nil {
		return err
	}

	if err := utils.ValidateDbVersion(pgDbVersion, pgDumpVersion); err != nil {
		return errors.New("major postgres version does not match pg_dump")
	}

	root := "./data-dump"

	concurrencyLimit := make(chan struct{}, 5)

	var wg sync.WaitGroup

	for _, table := range tables {
		wg.Add(1)

		concurrencyLimit <- struct{}{}

		go func(tbl db.Table) {
			defer wg.Done()

			dirPath := filepath.Join(root, tbl.Details.Name)

			if err := os.MkdirAll(dirPath, os.ModePerm); err != nil {
				fmt.Printf("Error copying for table %s: %s", tbl.Details.Identifier, err)
			}

			path := filepath.Join(dirPath, "data.csv")
			dataPath := filepath.Join(dirPath, "table.bin")

			rows, err := tbl.CopyOut(path)
			if err != nil {
				fmt.Printf("Error copying: %s\n", err)
			}

			fmt.Printf("COPIED %d rows from %s\n", rows, tbl.Details.Identifier)

			err = tbl.SerializeTable(dataPath)

			if err != nil {
				fmt.Printf("Error serializing: %s\n", err)
			}

			if err := os.MkdirAll(dirPath, os.ModePerm); err != nil {
				fmt.Printf("Error serializing data for table %s: %s", tbl.Details.Identifier, err)
			}

			<-concurrencyLimit
		}(table)
	}

	wg.Wait()

	fmt.Println("Getting DDL")

	ddlPath, err := filepath.Abs(filepath.Join(root, "ddl.sql"))
	if err != nil {
		return err
	}
	fkPath, err := filepath.Abs(filepath.Join(root, "fk_constraints.sql"))
	if err != nil {
		return err
	}
	ddlFile, err := os.OpenFile(ddlPath, os.O_CREATE|os.O_RDWR, 0666)
	if err != nil {
		return err
	}
	fkFile, err := os.OpenFile(fkPath, os.O_CREATE|os.O_RDWR, 0666)
	if err != nil {
		return err
	}

	dumpOutput, err := pgcommand.DumpDb(&dbParams)

	if err != nil {
		return err
	}

	fks, ddl, err := ExtractAndRemoveFKConstraints(dumpOutput)

	if err != nil {
		return err
	}

	_, err = ddlFile.WriteString(ddl)
	if err != nil {
		return err
	}
	_, err = fkFile.WriteString(fks)
	if err != nil {
		return err
	}

	return nil
}
