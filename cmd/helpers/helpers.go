package helpers

import (
	"github.com/spf13/cobra"
	"github.com/videahealth/pg-snap/config"
)

func ParseSkipTables(st []string) map[string]struct{} {
	tableSet := make(map[string]struct{})

	for _, part := range st {
		tableSet[part] = struct{}{}
	}

	return tableSet
}

type DbParams struct {
	Username string
	Password string
	Host     string
	Db       string
	Port     int32
}

type DumpOptions struct {
	Config      *config.Config
	Concurrency int32
}

type RestoreOptions struct {
	Concurrency        int32
	TarFilePath        string
	AskForConfirmation bool
}

func ParseDbParamsFromCli(cmd *cobra.Command) *DbParams {
	port, err := cmd.Flags().GetInt32("port")
	if err != nil {
		panic(err)
	}
	username, err := cmd.Flags().GetString("username")
	if err != nil {
		panic(err)
	}
	password, err := cmd.Flags().GetString("password")
	if err != nil {
		panic(err)
	}
	host, err := cmd.Flags().GetString("host")
	if err != nil {
		panic(err)
	}
	db, err := cmd.Flags().GetString("db")
	if err != nil {
		panic(err)
	}

	return &DbParams{
		Username: username,
		Password: password,
		Host:     host,
		Db:       db,
		Port:     port,
	}
}

func ParsDumpOptions(cmd *cobra.Command) *DumpOptions {
	subsetPath, err := cmd.Flags().GetString("config")
	if err != nil {
		panic(err)
	}

	var cfg *config.Config

	if subsetPath != "" {
		cfg, err = config.LoadConfig(subsetPath)
		if err != nil {
			panic(err)
		}
	}

	c, err := cmd.Flags().GetInt32("concurrency")
	if err != nil {
		panic(err)
	}
	return &DumpOptions{
		Config:      cfg,
		Concurrency: c,
	}
}

func ParsRestoreOptions(cmd *cobra.Command) *RestoreOptions {
	c, err := cmd.Flags().GetInt32("concurrency")
	if err != nil {
		panic(err)
	}
	file, err := cmd.Flags().GetString("file")
	if err != nil {
		panic(err)
	}

	return &RestoreOptions{
		Concurrency:        c,
		TarFilePath:        file,
		AskForConfirmation: true,
	}
}
