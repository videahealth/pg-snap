package strategy

import (
	"bytes"
	"errors"
	"fmt"
	"io"
	"os"
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

func CompressDir(dir string, outFile string) error {
	var buf bytes.Buffer
	err := utils.Compress(dir, &buf)
	if err != nil {
		return err
	}

	fileToWrite, err := os.OpenFile(outFile, os.O_CREATE|os.O_RDWR, os.FileMode(0600))
	if err != nil {
		return err
	}
	if _, err := io.Copy(fileToWrite, &buf); err != nil {
		return err
	}

	return nil
}

func RunWithStrategy(p *helpers.DumpOptions, d *helpers.DbParams, pg *db.Db, tables []*db.Table) error {

	pgDbVersion := pg.GetVersion()
	pgDumpVersion, err := pgcommand.GetPgCmdVersion("pg_dump")

	if err != nil {
		return err
	}

	log.Info(utils.SprintfNoNewlines("Remote postgres version: %s, local version: %s", pgDbVersion, pgDumpVersion))

	if err := utils.ValidateDbVersion(pgDbVersion, pgDumpVersion); err != nil {
		return errors.New("major postgres version does not match pg_dump")
	}

	root := "./data-dump"
	defer os.RemoveAll(root)

	if p.Config != nil && p.Config.Subset.Table != "" {
		maxRows := p.Config.Subset.MaxRowsPerTable
		fmt.Println(maxRows)
		subset, err := relations.NewSubset(pg, tables, p.Config.Subset.Table, p.Config.Subset.Schema, root, p.Config.Subset.Where, maxRows)
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

				rows := tbl.PerformCopy(root, "")

				utils.DisplayProgress(&ops, rows, total, tbl.Details.Display)

				<-concurrencyLimit
			}(*table)
		}

		wg.Wait()

	}

	if err = CompressDir(root, fmt.Sprintf("./%s.tar.gz", d.Db)); err != nil {
		return err
	}

	return nil
}
