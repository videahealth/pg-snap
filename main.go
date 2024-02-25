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
	dbFlags := []cli.Flag{
		&cli.StringFlag{
			Name:     "username",
			Required: true,
			Usage:    "NA",
		},
		&cli.StringFlag{
			Name:  "port",
			Usage: "NA",
			Value: "5432",
		},
		&cli.StringFlag{
			Name:     "db",
			Required: true,
			Usage:    "NA",
		},
		&cli.StringFlag{
			Name:     "host",
			Required: true,
			Usage:    "NA",
		},
		&cli.StringFlag{
			Name:     "password",
			Required: true,
			Usage:    "NA",
		},
		&cli.StringFlag{
			Name:    "concurrency",
			Aliases: []string{"c"},
			Value:   "5",
		},
	}
	dumpFlags := append(dbFlags, &cli.StringFlag{
		Name:  "skip-tables",
		Usage: "public.*,myschema.Table",
	})
	restoreFlags := append(dbFlags, &cli.StringFlag{
		Name:    "file",
		Aliases: []string{"f"},
		Usage:   "file",
		Value:   "",
	})
	cmd := &cli.Command{
		Commands: []*cli.Command{
			{
				Name:   "dump",
				Usage:  "add a task to the list",
				Action: dump.Run,
				Flags:  dumpFlags,
			},
			{
				Name:   "restore",
				Usage:  "restore db",
				Action: restore.Run,
				Flags:  restoreFlags,
			},
		},
	}

	if err := cmd.Run(context.Background(), os.Args); err != nil {
		log.Fatal(err)
	}

}
