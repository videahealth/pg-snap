package main

import (
	"context"
	"log"
	"os"

	"github.com/urfave/cli/v3"
	"github.com/videahealth/pg-snap/cmd"
)

func main() {

	cmd := &cli.Command{
		Commands: []*cli.Command{
			{
				Name:   "dump",
				Usage:  "add a task to the list",
				Action: cmd.Dump,
				Flags: []cli.Flag{
					&cli.StringFlag{
						Name:  "skip-tables",
						Usage: "public.*,myschema.Table",
					},
				},
			},
		},
	}

	if err := cmd.Run(context.Background(), os.Args); err != nil {
		log.Fatal(err)
	}

}
