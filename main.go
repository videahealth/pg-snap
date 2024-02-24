package main

import (
	"context"
	"log"
	"os"

	"github.com/urfave/cli/v3"
	"github.com/videahealth/pg-snap/cmd"
)

func main() {
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
	}
	dumpFlags := append(dbFlags, &cli.StringFlag{
		Name:  "skip-tables",
		Usage: "public.*,myschema.Table",
	})
	cmd := &cli.Command{
		Commands: []*cli.Command{
			{
				Name:   "dump",
				Usage:  "add a task to the list",
				Action: cmd.Dump,
				Flags:  dumpFlags,
			},
			{
				Name:   "restore",
				Usage:  "restore db",
				Action: cmd.Restore,
				Flags:  dbFlags,
			},
		},
	}

	if err := cmd.Run(context.Background(), os.Args); err != nil {
		log.Fatal(err)
	}

}
