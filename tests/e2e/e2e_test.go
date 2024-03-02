package e2e

import (
	"context"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"io"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"testing"
	"time"

	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/modules/postgres"
	"github.com/testcontainers/testcontainers-go/wait"

	"github.com/videahealth/pg-snap/cmd"
	"github.com/videahealth/pg-snap/cmd/helpers"
	"github.com/videahealth/pg-snap/config"
)

const restoreDbSqlPath string = "restore-dump.sql"
const dumpTarFile string = "usada.tar.gz"

func InitDb(ctx context.Context, db string, user string, pass string) (*postgres.PostgresContainer, helpers.DbParams) {

	postgresContainer, err := postgres.RunContainer(ctx,
		testcontainers.WithImage("docker.io/postgres:15.2-alpine"),
		postgres.WithDatabase("postgres"),
		postgres.WithInitScripts("../../testdata/init.sql"),
		postgres.WithUsername(user),
		postgres.WithPassword(pass),
		testcontainers.WithWaitStrategy(
			wait.ForLog("database system is ready to accept connections").
				WithOccurrence(2).
				WithStartupTimeout(5*time.Second)),
	)
	if err != nil {
		log.Fatalf("failed to start container: %s", err)
	}

	host, err := postgresContainer.Host(ctx)
	if err != nil {
		log.Fatalf("Error getting pg host")
	}
	containerBindings, err := postgresContainer.Ports(ctx)
	if err != nil {
		log.Fatalf("Error getting pg containerBindings: %s", err)
	}

	var port string

	if bindings, exists := containerBindings["5432/tcp"]; exists && len(bindings) > 0 {
		port = bindings[0].HostPort
	} else {
		log.Fatalf("No bindings found for 5432/tcp")
	}

	num, err := strconv.ParseInt(port, 10, 32)
	if err != nil {
		log.Fatalf("Error converting string to int32: %s", err)
	}

	int32Port := int32(num)

	params := helpers.DbParams{
		Username: user,
		Password: pass,
		Host:     host,
		Port:     int32Port,
		Db:       db,
	}

	return postgresContainer, params
}

func ExecutePSQLCommand(db string, user string, pass string, host string, port string) {
	cmd := exec.Command("psql", "-d", db, "-h", host, "-U", user, "-p", port, "-a", "-f", "../../testdata/usda.sql")
	cmd.Env = append(os.Environ(), fmt.Sprintf(`PGPASSWORD=%v`, pass))

	output, err := cmd.CombinedOutput()

	if err != nil {
		log.Fatalf("Error executing psql command: %s\nCommand output:\n%s", err, string(output))
	}

}

func ExecutePGDumpCommand(db string, user string, pass string, host string, port string, outputFile string) {
	cmd := exec.Command("pg_dump", "-d", db, "-h", host, "-U", user, "-p", port, "-f", outputFile)

	cmd.Env = append(os.Environ(), fmt.Sprintf("PGPASSWORD=%s", pass))

	output, err := cmd.CombinedOutput()

	if err != nil {
		log.Fatalf("Error executing pg_dump command: %s\nCommand output:\n%s", err, string(output))
	}

	log.Printf("Database %s successfully backed up to %s\n", db, outputFile)
}

func CalculateFileSHA256(filepath string) (string, error) {
	file, err := os.Open(filepath)
	if err != nil {
		return "", err
	}
	defer file.Close()

	hasher := sha256.New()

	if _, err := io.Copy(hasher, file); err != nil {
		return "", err
	}

	hash := hasher.Sum(nil)
	return hex.EncodeToString(hash), nil
}

func DumpDb(t *testing.T, cfg *config.Config) {
	ctx := context.Background()

	db := "usada"
	user := "user"
	pass := "password"

	pg, dbParams := InitDb(ctx, db, user, pass)
	defer func() {
		if err := pg.Terminate(ctx); err != nil {
			t.Fatalf("failed to terminate container: %s", err)
		}
	}()

	ExecutePSQLCommand(db, user, pass, dbParams.Host, strconv.FormatInt(int64(dbParams.Port), 10))

	programParams := helpers.DumpOptions{
		Concurrency: 4,
		Config:      cfg,
	}

	if err := cmd.RunDumpCmd(dbParams, programParams); err != nil {
		t.Fatalf("Failed running dump cmd: %s", err)
		return
	}
}

func RestoreDb(t *testing.T) string {
	ctx := context.Background()

	tarfile, err := filepath.Abs(dumpTarFile)
	if err != nil {
		t.Fatalf("Error getting abs path for tarfile: %s", err)
		return ""
	}

	programParams := helpers.RestoreOptions{
		Concurrency:        4,
		AskForConfirmation: false,
		TarFilePath:        tarfile,
	}

	db := "usada"
	user := "user"
	pass := "password"

	pg, dbParams := InitDb(ctx, db, user, pass)
	defer func() {
		if err := pg.Terminate(ctx); err != nil {
			t.Fatalf("failed to terminate container: %s", err)
		}
	}()

	if err := cmd.RunRestoreCmd(dbParams, programParams); err != nil {
		t.Fatalf("Failed running restore cmd: %s", err)
		return ""
	}

	ExecutePGDumpCommand(dbParams.Db, user, pass, dbParams.Host, strconv.FormatInt(int64(dbParams.Port), 10), restoreDbSqlPath)

	hash, err := CalculateFileSHA256(restoreDbSqlPath)

	if err != nil {
		t.Fatalf("error calculating hash: %s", err)
	}

	return hash
}

func TestE2E(t *testing.T) {
	if os.Getenv("TEST") != "e2e" {
		t.Skip("Skipping testing in CI environment")
	}

	DumpDb(t, &config.Config{
		SkipTables: []string{},
	})
	if hash := RestoreDb(t); hash != "204b58b5dba7c579c4ff6d24b6f678c31e84fcf1f8b5665689706d218ffd6ce8" {
		t.Fatalf("restore hash does not match expected: %s", hash)
	}

	var config config.Config

	config.Subset.Table = "nut_data"
	config.Subset.Schema = "public"
	config.Subset.Where = "ndb_no = '02014'"
	config.Subset.MaxRowsPerTable = 10
	config.SkipTables = []string{}

	DumpDb(t, &config)
	if hash := RestoreDb(t); hash != "c44022fe22f1e0841d7a8d18f913a04917ac3d8f28601024e08503e3e42740dc" {
		t.Fatalf("restore hash does not match expected: %s", hash)
	}

	t.Cleanup(func() {
		if err := os.Remove(restoreDbSqlPath); err != nil {
			fmt.Println("Error cleaning up file", dumpTarFile)
		}
		if err := os.Remove(dumpTarFile); err != nil {
			fmt.Println("Error cleaning up file", dumpTarFile)
		}
	})
}
