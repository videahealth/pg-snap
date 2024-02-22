package pgcommand

import (
	"fmt"
	"os"
	"os/exec"
	"strings"

	"github.com/videahealth/pg-snap/internal/db"
)

var (
	// PGRestoreCmd is the path to the `pg_restore` executable
	PGRestoreCmd      = "pg_restore"
	pgDRestoreStdOpts = []string{"--no-owner", "--no-acl", "--clean", "--exit-on-error"}
)

type Restore struct {
	db *db.Db
	// Verbose mode
	Verbose bool
	// Role: do SET ROLE before restore
	Role string
	// Path: setup path for source restore
	Path string
	// Extra pg_dump options
	// e.g []string{"--inserts"}
	Options []string
	// Schemas: list of database schema
	Schemas []string
}

func NewRestore(db *db.Db) (*Restore, error) {
	if !CommandExist(PGRestoreCmd) {
		return nil, &ErrCommandNotFound{Command: PGRestoreCmd}
	}

	return &Restore{Options: pgDRestoreStdOpts, db: db, Schemas: []string{"public"}}, nil
}

// Exec `pg_restore` of the specified database, and restore from a gzip compressed tarball archive.
func (x *Restore) Exec(filename string, opts ExecOptions) Result {
	result := Result{}
	options := append(x.restoreOptions(), fmt.Sprintf("%s%s", x.Path, filename))
	result.FullCommand = strings.Join(options, " ")
	cmd := exec.Command(PGRestoreCmd, options...)
	cmd.Env = append(os.Environ(), x.db.EnvPassword)
	stderrIn, _ := cmd.StderrPipe()
	go streamOutput(stderrIn, opts, &result)
	err := cmd.Start()
	if err != nil {
		result.Error = &ResultError{Err: err, CmdOutput: result.Output}
	}
	err = cmd.Wait()
	if exitError, ok := err.(*exec.ExitError); ok {
		result.Error = &ResultError{Err: err, ExitCode: exitError.ExitCode(), CmdOutput: result.Output}
	}

	return result
}

func (x *Restore) ResetOptions() {
	x.Options = []string{}
}

func (x *Restore) EnableVerbose() {
	x.Verbose = true
}

func (x *Restore) SetPath(path string) {
	x.Path = path
}

func (x *Restore) SetSchemas(schemas []string) {
	x.Schemas = schemas
}

func (x *Restore) restoreOptions() []string {
	options := x.Options
	options = append(options, x.db.Parse()...)

	if x.Role != "" {
		options = append(options, fmt.Sprintf(`--role=%v`, x.Role))
	} else if x.db.DbName != "" {
		x.Role = x.db.DbName
		options = append(options, fmt.Sprintf(`--role=%v`, x.db.DbName))
	}

	if x.Verbose {
		options = append(options, "-v")
	}
	for _, schema := range x.Schemas {
		options = append(options, "--schema="+schema)
	}

	return options
}
