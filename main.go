package main

import (
	"context"
	"log"
	"os"

	"github.com/urfave/cli/v3"
	"github.com/videahealth/pg-snap/cmd/dump"
	"github.com/videahealth/pg-snap/cmd/restore"
	"github.com/videahealth/pg-snap/internal/utils"
)

func main() {
	utils.InitColor()

	app := &cli.Command{
		Commands: []*cli.Command{
			initDumpCommand(),
			initRestoreCommand(),
		},
	}

	if err := app.Run(context.Background(), os.Args); err != nil {
		log.Fatalf("Application failed: %v", err)
	}
}

func dbFlags() []cli.Flag {
	return []cli.Flag{
		&cli.StringFlag{
			Name:     "username",
			Required: true,
			Usage:    "Database username",
		},
		&cli.StringFlag{
			Name:  "port",
			Usage: "Database port",
			Value: "5432",
		},
		&cli.StringFlag{
			Name:     "db",
			Required: true,
			Usage:    "Database name",
		},
		&cli.StringFlag{
			Name:     "host",
			Required: true,
			Usage:    "Database host",
		},
		&cli.StringFlag{
			Name:     "password",
			Required: true,
			Usage:    "Database password",
		},
		&cli.StringFlag{
			Name:    "concurrency",
			Aliases: []string{"c"},
			Value:   "5",
			Usage:   "Number of concurrent operations",
		},
	}
}

func initDumpCommand() *cli.Command {
	return &cli.Command{
		Name:   "dump",
		Usage:  "Dumps the database into a file",
		Action: dump.Run,
		Flags:  append(dbFlags(), &cli.StringFlag{Name: "skip-tables", Usage: "Comma-separated list of tables to skip"}),
	}
}

func initRestoreCommand() *cli.Command {
	return &cli.Command{
		Name:   "restore",
		Usage:  "Restores the database from a file",
		Action: restore.Run,
		Flags: append(dbFlags(), &cli.StringFlag{
			Name:    "file",
			Aliases: []string{"f"},
			Usage:   "Path to the file to restore from",
			Value:   "",
		}),
	}
}
