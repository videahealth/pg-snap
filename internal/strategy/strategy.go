package strategy

import (
	"errors"
	"fmt"
	"sync"
	"sync/atomic"

	"github.com/charmbracelet/log"
	"github.com/videahealth/pg-snap/cmd/helpers"
	"github.com/videahealth/pg-snap/internal/db"
	"github.com/videahealth/pg-snap/internal/pgcommand"
	"github.com/videahealth/pg-snap/internal/relations"
	"github.com/videahealth/pg-snap/internal/utils"
)

type ParsedString struct {
	Schema string
	Table  string
	Query  string
}

func RunWithStrategy(p *helpers.DumpOptions, d *helpers.DbParams, pg *db.Db, tables []*db.Table, workingDir string) error {

	pgDbVersion := pg.GetVersion()
	pgDumpVersion, err := pgcommand.GetPgCmdVersion("pg_dump")

	if err != nil {
		return err
	}

	log.Info(utils.SprintfNoNewlines("Remote postgres version: %s, local version: %s", pgDbVersion, pgDumpVersion))

	if err := utils.ValidateDbVersion(pgDbVersion, pgDumpVersion); err != nil {
		return errors.New("major postgres version does not match pg_dump")
	}

	if p.Config != nil && p.Config.Subset.Table != "" {
		maxRows := p.Config.Subset.MaxRowsPerTable
		fmt.Println(maxRows)
		subset, err := relations.NewSubset(pg, tables, p.Config.Subset.Table, p.Config.Subset.Schema, workingDir, p.Config.Subset.Where, maxRows)
		if err != nil {
			return err
		}
		if err = subset.TraverseAndCopyData(); err != nil {
			return fmt.Errorf("error subsetting data: %w", err)
		}

	} else {

		log.Info("Running with", "concurrency", p.Concurrency)

		concurrencyLimit := make(chan struct{}, p.Concurrency)

		var wg sync.WaitGroup
		var ops atomic.Uint64
		total := len(tables)

		for _, table := range tables {
			wg.Add(1)

			concurrencyLimit <- struct{}{}

			go func(tbl db.Table) {
				defer wg.Done()

				log.Debug(utils.SprintfNoNewlines("COPYING data from table %s", tbl.Details.Display))

				rows := tbl.PerformCopy(workingDir, "")

				utils.DisplayProgress(&ops, rows, total, tbl.Details.Display)

				<-concurrencyLimit
			}(*table)
		}

		wg.Wait()

	}

	return nil
}
