package cmd

import (
	"context"
	"errors"
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"sync"
	"sync/atomic"

	"github.com/charmbracelet/log"
	"github.com/spf13/cobra"
	"github.com/videahealth/pg-snap/cmd/helpers"
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

func DecompressDir(filePath string, out string) error {
	file, err := os.Open(filePath)

	if err != nil {
		return err
	}

	err = utils.Decompress(file, out)

	if err != nil {
		return err
	}

	return nil
}

func ReadFromFileAndWriteToDb(path string, table *db.Table, pg *db.Db, isExtTable bool, ops *atomic.Uint64, total int) error {
	fullPath, err := filepath.Abs(path)
	if err != nil {
		return fmt.Errorf("failed to get absolute path: %w", err)
	}

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

	log.Debug(utils.SprintfNoNewlines("COPYING data from table %s", table.Details.Display))

	rowsCopied, err := table.CopyIn(fullPath, tableToCopy, schemaToCopy)
	if err != nil {
		return fmt.Errorf("error copying for table %s.%s: %w", table.Details.Schema, table.Details.Name, err)
	}

	ops.Add(1)
	progress := ops.Load()

	log.Info(utils.SprintfNoNewlines("COPIED %s rows from %s",
		utils.Colored(utils.Green, fmt.Sprint(rowsCopied)),
		utils.Colored(utils.Yellow, table.Details.Display)),
		"progress",
		utils.SprintfNoNewlines("%d / %d", progress, total))

	if isTmpTable {
		if _, err := pg.CopyFromTempTable(table.Details.Identifier, tableToCopy); err != nil {
			return fmt.Errorf("error copying from temp table %s.%s: %w", table.Details.Schema, table.Details.Name, err)
		}
	}

	return nil
}

var restoreCmd = &cobra.Command{
	Use:   "restore",
	Short: "Restore a dump of the postgres database",
	Long:  `Takes in a gziped dump file and restores it into the given database.`,
	Run: func(cmd *cobra.Command, args []string) {
		dbParams := *helpers.ParseDbParamsFromCli(cmd)
		programParams := *helpers.ParsRestoreOptions(cmd)
		if err := RunRestoreCmd(dbParams, programParams); err != nil {
			log.Error("error runningdump command", "err", err)
		}
	},
}

func init() {
	rootCmd.AddCommand(restoreCmd)

	addDatabaseFlags(restoreCmd)
	restoreCmd.Flags().Int32P("concurrency", "c", 5, "Number of concurrent copys")
	restoreCmd.Flags().StringP("file", "f", "", "File path to the dump file")
	restoreCmd.MarkFlagFilename("file")
}

func RunRestoreCmd(dbParams helpers.DbParams, programParams helpers.RestoreOptions) error {

	var inputFile string

	if programParams.TarFilePath == "" {
		inputFile = fmt.Sprintf("./%s.tar.gz", dbParams.Db)
	} else {
		inputFile = programParams.TarFilePath
		if _, err := os.Stat(inputFile); errors.Is(err, os.ErrNotExist) {
			return fmt.Errorf("given input file %s does not exist", inputFile)
		}
	}
	root := "./data-dump"
	defer os.RemoveAll(root)
	dp := db.NewPsql(root)
	if err := DecompressDir(inputFile, "."); err != nil {
		return err
	}

	dp.SplitDDLWithFks()

	pg, err := db.NewDb(context.Background(), dbParams, nil)

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

	tables, err := LoadPgTables(root, pg)

	if err != nil {
		return err
	}

	if programParams.AskForConfirmation {
		utils.AskForConfirmation(fmt.Sprintf("Warning! this operation will drop the database %s, do you wish to continue?", dbParams.Db))
	}

	if err := pg.DropAndCreateDb(); err != nil {
		return err
	}

	ddlPath, err := filepath.Abs(filepath.Join(root, "rem.sql"))
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

	concurrencyLimit := make(chan struct{}, programParams.Concurrency)
	var wg sync.WaitGroup

	var ops atomic.Uint64
	total := len(tables)

	for _, table := range tables {
		wg.Add(1)

		concurrencyLimit <- struct{}{}

		go func(tbl db.Table) {
			defer wg.Done()

			isExtention := IsExtTable(extTables, &tbl)
			dirPath := filepath.Join(root, tbl.Details.Display, "data.csv")

			if err := ReadFromFileAndWriteToDb(dirPath, &tbl, pg, isExtention, &ops, total); err != nil {
				log.Error("Error copying for table %s: %s", tbl.Details.Display, err)
			}

			<-concurrencyLimit
		}(table)
	}
	wg.Wait()

	log.Info("Loading database DDL")

	fksPath, err := filepath.Abs(filepath.Join(root, "fk.sql"))
	if err != nil {
		return err
	}

	if err := pgcommand.ExecuteDDLFile(&dbParams, fksPath); err != nil {
		return err
	}

	log.Info("Writing table sequences")

	if err := pg.WriteTableSequences(); err != nil {
		return err
	}

	return nil
}
