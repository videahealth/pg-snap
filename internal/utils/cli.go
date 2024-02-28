package utils

import (
	"strconv"

	"github.com/urfave/cli/v3"
)

const DEFAULT_CONCURRENCY int32 = 4

type DbParams struct {
	Username string
	Password string
	Host     string
	Db       string
	Port     int32
}

type ProgramParams struct {
	Concurrency        int32
	TarFilePath        string
	SkipTables         string
	AskForConfirmation bool
}

func ParseDbParamsFromCli(cmd *cli.Command) *DbParams {
	port, err := strconv.ParseInt(cmd.String("port"), 10, 32)
	if err != nil {
		panic(err)
	}

	return &DbParams{
		Username: cmd.String("username"),
		Password: cmd.String("password"),
		Host:     cmd.String("host"),
		Db:       cmd.String("db"),
		Port:     int32(port),
	}
}

func ParseProgramParamsFromCli(cmd *cli.Command) *ProgramParams {
	c, err := strconv.ParseInt(cmd.String("concurrency"), 10, 32)
	if err != nil {
		panic(err)
	}

	con := int32(c)

	if con == 0 {
		con = DEFAULT_CONCURRENCY
	}

	return &ProgramParams{
		Concurrency:        con,
		TarFilePath:        cmd.String("file"),
		SkipTables:         cmd.String("skip-tables"),
		AskForConfirmation: true,
	}
}
