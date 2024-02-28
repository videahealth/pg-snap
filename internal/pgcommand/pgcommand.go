package pgcommand

import (
	"errors"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"

	"github.com/videahealth/pg-snap/internal/utils"
)

func GetPgCommandFlags(params *utils.DbParams) []string {
	var options []string

	if params.Db != "" {
		options = append(options, fmt.Sprintf(`--dbname=%v`, params.Db))
	}

	if params.Host != "" {
		options = append(options, fmt.Sprintf(`--host=%v`, params.Host))
	}

	if params.Port != 0 {
		options = append(options, fmt.Sprintf(`--port=%v`, params.Port))
	}

	if params.Username != "" {
		options = append(options, fmt.Sprintf(`--username=%v`, params.Username))
	}

	return options
}

func DumpDb(params *utils.DbParams) (string, error) {
	flags := GetPgCommandFlags(params)

	options := []string{"--schema-only"}
	options = append(options, flags...)

	cmd := exec.Command("pg_dump", options...)
	cmd.Env = append(os.Environ(), fmt.Sprintf(`PGPASSWORD=%v`, params.Password))

	output, err := cmd.CombinedOutput()

	if err != nil {
		return "", err
	}

	return string(output), nil
}

func ExecuteDDLFile(params *utils.DbParams, path string) error {
	fullPath, err := filepath.Abs(path)
	if err != nil {
		return fmt.Errorf("failed to get absolute path: %w", err)
	}

	cmd := exec.Command("psql",
		"-U", params.Username,
		"-h", params.Host,
		"-d", params.Db,
		"-f", fullPath,
		"-p", strconv.FormatInt(int64(params.Port), 10),
	)
	cmd.Env = append(os.Environ(), "PATH=/usr/local/bin:"+os.Getenv("PATH"))
	cmd.Env = append(cmd.Env, fmt.Sprintf("PGPASSWORD=%s", params.Password))

	output, err := cmd.CombinedOutput()
	if err != nil {
		return fmt.Errorf("psql command failed: %w; output: %s", err, string(output))
	}

	return nil
}

func GetPgCmdVersion(cmdStr string) (string, error) {

	cmd := exec.Command(cmdStr, "--version")

	output, err := cmd.Output()

	if err != nil {
		if errors.Is(err, exec.ErrNotFound) {
			return "", errors.New("command pg_dump does not exist, please first install it")
		}
		return "", err
	}

	return string(output), nil
}
