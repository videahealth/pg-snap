package pgcommand

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
	"time"

	"github.com/videahealth/pg-snap/internal/db"
)

var (
	// PGDumpCmd is the path to the `pg_dump` executable
	PGDumpCmd     = "pg_dump"
	pgDumpStdOpts = []string{"--schema-only"}
)

type Dump struct {
	db *db.Db

	// Verbose mode
	Verbose bool
	// Path: setup path dump out
	Path string
	// Format: output file format (custom, directory, tar, plain text (default))
	Format *string
	// Extra pg_dump x.FullOptions
	// e.g []string{"--inserts"}
	Options []string

	IgnoreTableData []string

	// fileName: output file name
	fileName string
}

func NewDump(db *db.Db) (*Dump, error) {
	if !CommandExist(PGDumpCmd) {
		return nil, &ErrCommandNotFound{Command: PGDumpCmd}
	}

	return &Dump{Options: pgDumpStdOpts, db: db}, nil
}

func (x *Dump) DumpDb(file string) Result {
	result := Result{Mine: "application/x-tar"}
	result.File = file
	options := append(x.dumpOptions(), fmt.Sprintf("-f%s", file))

	result.FullCommand = strings.Join(options, " ")
	cmd := exec.Command(PGDumpCmd, options...)
	cmd.Env = append(os.Environ(), x.db.EnvPassword)

	// Use CombinedOutput to capture both stdout and stderr
	output, err := cmd.CombinedOutput()
	fmt.Println(string(output), err) // Ensure to convert output to string for printing

	if err != nil {
		if exitError, ok := err.(*exec.ExitError); ok {
			// Note: Now CmdOutput should correctly include stderr content if any
			result.Error = &ResultError{Err: err, ExitCode: exitError.ExitCode(), CmdOutput: string(output)}
		} else {
			result.Error = &ResultError{Err: err, CmdOutput: string(output)}
		}
	}

	result.Output = string(output)

	return result
}

func (x *Dump) GetVersion(opts ExecOptions) string {
	result := Result{Mine: "application/x-tar"}

	cmd := exec.Command(PGDumpCmd, "--version")

	output, err := cmd.Output()

	result.Output = string(output)

	if err != nil {
		result.Error = &ResultError{Err: err, CmdOutput: string(output)}
	}

	if exitError, ok := err.(*exec.ExitError); ok {
		result.Error = &ResultError{Err: err, ExitCode: exitError.ExitCode(), CmdOutput: result.Output}
	}

	version := result.Output

	return version
}

func (x *Dump) ResetOptions() {
	x.Options = []string{}
}

func (x *Dump) EnableVerbose() {
	x.Verbose = true
}

func (x *Dump) SetFileName(filename string) {
	x.fileName = filename
}

func (x *Dump) GetFileName() string {
	if x.fileName == "" {
		// Use default file name
		x.fileName = x.newFileName()
	}

	return x.fileName
}

func (x *Dump) SetupFormat(f string) {
	x.Format = &f
}

func (x *Dump) SetPath(path string) {
	x.Path = path
}

func (x *Dump) newFileName() string {
	return fmt.Sprintf(`%v_%v.sql.tar.gz`, x.db.DbName, time.Now().Unix())
}

func (x *Dump) dumpOptions() []string {
	options := x.Options
	options = append(options, x.db.Parse()...)

	// if x.Format != nil {
	// 	options = append(options, fmt.Sprintf(`-F%v`, *x.Format))
	// } else {
	// 	options = append(options, fmt.Sprintf(`-F%v`, pgDumpDefaultFormat))
	// }
	if x.Verbose {
		options = append(options, "-v")
	}
	if len(x.IgnoreTableData) > 0 {
		options = append(options, x.IgnoreTableDataToString()...)
	}

	return options
}
func (x *Dump) IgnoreTableDataToString() []string {
	t := []string{}
	for _, tables := range x.IgnoreTableData {
		t = append(t, "--exclude-table-data="+tables)
	}

	return t
}
