/*
Copyright © 2024 NAME HERE <EMAIL ADDRESS>
*/
package main

import "github.com/videahealth/pg-snap/cmd"

func main() {
	cmd.Execute()
}

// /*
// Copyright © 2024 NAME HERE <EMAIL ADDRESS>
// */
// package main

// import (
// 	"context"
// 	"os"
// 	"time"

// 	"github.com/charmbracelet/log"
// 	"github.com/urfave/cli"
// 	"github.com/videahealth/pg-snap/cmd/dump"
// 	"github.com/videahealth/pg-snap/cmd/restore"
// 	"github.com/videahealth/pg-snap/internal/utils"
// )

// func main() {
// 	utils.InitColor()

// 	app := &cli.Command{
// 		Commands: []*cli.Command{
// 			initDumpCommand(),
// 			initRestoreCommand(),
// 		},
// 	}

// 	start := time.Now()
// 	if err := app.Run(context.Background(), os.Args); err != nil {
// 		log.Fatalf("Application failed: %v", err)
// 	}
// 	duration := time.Since(start)
// 	log.Info("Command completed in", "duration", duration.Round(time.Millisecond).String())
// }

// func dbFlags() []cli.Flag {
// 	return []cli.Flag{
// 		&cli.StringFlag{
// 			Name:     "username",
// 			Required: true,
// 			Usage:    "Database username",
// 		},
// 		&cli.StringFlag{
// 			Name:  "port",
// 			Usage: "Database port",
// 			Value: "5432",
// 		},
// 		&cli.StringFlag{
// 			Name:     "db",
// 			Required: true,
// 			Usage:    "Database name",
// 		},
// 		&cli.StringFlag{
// 			Name:     "host",
// 			Required: true,
// 			Usage:    "Database host",
// 		},
// 		&cli.StringFlag{
// 			Name:     "password",
// 			Required: true,
// 			Usage:    "Database password",
// 		},
// 		&cli.StringFlag{
// 			Name:    "concurrency",
// 			Aliases: []string{"c"},
// 			Value:   "5",
// 			Usage:   "Number of concurrent operations",
// 		},
// 	}
// }

// func initDumpCommand() *cli.Command {
// 	return &cli.Command{
// 		Name:   "dump",
// 		Usage:  "Dumps the database into a file",
// 		Action: dump.Run,
// 		Flags: append(dbFlags(),
// 			&cli.StringFlag{Name: "skip-tables", Usage: "Comma-separated list of tables to skip"},
// 			&cli.StringFlag{Name: "subset", Usage: `Starting database to subset from. Ex: public.Cars[\"modelName\" = 'Honda' ORDER BY \"createdAt\" DESC LIMIT 10]`}),
// 	}
// }

// func initRestoreCommand() *cli.Command {
// 	return &cli.Command{
// 		Name:   "restore",
// 		Usage:  "Restores the database from a file",
// 		Action: restore.Run,
// 		Flags: append(dbFlags(), &cli.StringFlag{
// 			Name:    "file",
// 			Aliases: []string{"f"},
// 			Usage:   "Path to the file to restore from",
// 			Value:   "",
// 		}),
// 	}
// }
