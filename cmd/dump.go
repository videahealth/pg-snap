package cmd

import (
	"context"
	"fmt"

	"github.com/charmbracelet/log"
	"github.com/spf13/cobra"
	"github.com/videahealth/pg-snap/cmd/helpers"
	"github.com/videahealth/pg-snap/internal/db"
	"github.com/videahealth/pg-snap/internal/strategy"
)

var dumpCmd = &cobra.Command{
	Use:   "dump",
	Short: "Create a dump of a postgres database",
	Long: `Supports a full dump of all tables or subsetting of tables. Currently only supports
subsetting of a single table, and passthrough tables.`,
	Run: func(cmd *cobra.Command, args []string) {
		dbParams := *helpers.ParseDbParamsFromCli(cmd)
		programParams := *helpers.ParsDumpOptions(cmd)
		if err := RunDumpCmd(dbParams, programParams); err != nil {
			log.Error("error runningdump command", "err", err)
		}
	},
}

func init() {
	rootCmd.AddCommand(dumpCmd)
	addDatabaseFlags(dumpCmd)

	dumpCmd.Flags().StringP("config", "C", "", "config path")
	dumpCmd.Flags().Int32P("concurrency", "c", 5, "Number of concurrent copys")
	dumpCmd.MarkFlagFilename("config")
}

func RunDumpCmd(dbParams helpers.DbParams, programParams helpers.DumpOptions) error {

	log.Info("Extracting database DDL")

	dp := db.NewPsql("./data-dump")
	err := dp.Dump(&dbParams)
	if err != nil {
		return fmt.Errorf("error generating dump: %w", err)
	}
	pg, err := db.NewDb(context.Background(), dbParams, dp)

	if err != nil {
		return err
	}
	var skipTablesStr []string
	if programParams.Config != nil {
		skipTablesStr = programParams.Config.SkipTables
	}
	skipTables := helpers.ParseSkipTables(skipTablesStr)
	tables := pg.GetAllTables(skipTables)

	if err = strategy.RunWithStrategy(&programParams, &dbParams, pg, tables); err != nil {
		return err
	}

	return nil
}
