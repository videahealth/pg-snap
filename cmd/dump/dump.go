package dump

import (
	"context"
	"strings"

	"github.com/charmbracelet/log"
	"github.com/urfave/cli/v3"
	"github.com/videahealth/pg-snap/internal/db"
	"github.com/videahealth/pg-snap/internal/strategy"
	"github.com/videahealth/pg-snap/internal/utils"
)

func ParseSkipTables(st string) map[string]struct{} {

	if st == "" {
		return make(map[string]struct{})
	}

	parts := strings.Split(st, ",")
	tableSet := make(map[string]struct{})
	for _, part := range parts {
		tableSet[part] = struct{}{}
	}

	return tableSet
}

func Run(ctx context.Context, cmd *cli.Command) error {
	dbParams := *utils.ParseDbParamsFromCli(cmd)
	programParams := *utils.ParseProgramParamsFromCli(cmd)

	if err := RunCmd(dbParams, programParams); err != nil {
		return err
	}

	return nil
}

func RunCmd(dbParams utils.DbParams, programParams utils.ProgramParams) error {

	log.Info("Extracting database DDL")

	dp := db.NewPsql("./data-dump")
	err := dp.Dump(&dbParams)
	if err != nil {
		return err
	}
	pg, err := db.NewDb(context.Background(), dbParams, dp)

	if err != nil {
		return err
	}

	skipTablesStr := programParams.SkipTables
	skipTables := ParseSkipTables(skipTablesStr)
	tables := pg.GetAllTables(skipTables)

	if err = strategy.RunWithStrategy(&programParams, &dbParams, pg, tables); err != nil {
		return err
	}

	return nil
}
