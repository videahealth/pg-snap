package db

import (
	"context"
	"fmt"
	"io"
	"log"
	"strings"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

func shouldSkip(tableSchema, tableName string, skipTables map[string]struct{}) bool {
	fullName := tableSchema + "." + tableName
	schemaWildcard := tableSchema + ".*"
	tablePrefix := tableSchema + "."

	// Check if the full table name or schema wildcard is in the skip list
	_, fullMatch := skipTables[fullName]
	_, wildcardMatch := skipTables[schemaWildcard]

	if fullMatch || wildcardMatch {
		return true
	}

	// Check for prefix matches with table name substrings
	for skipTable := range skipTables {
		if strings.HasPrefix(skipTable, tablePrefix) {
			trimmed := skipTable[len(tablePrefix):] // Remove the prefix
			if strings.HasPrefix(tableName, trimmed) {
				return true
			}
		}
	}

	return false
}

type Db struct {
	Conn        *pgxpool.Pool
	Username    string
	Password    string
	Host        string
	Port        int32
	DbName      string
	EnvPassword string
	Url         string
}

func NewDb(ctx context.Context, username, password, host string, port int32, dbName string) (*Db, error) {
	url := fmt.Sprintf("postgres://%s:%s@%s:%d/%s", username, password, host, port, dbName)
	cfg, err := pgxpool.ParseConfig(url)

	if err != nil {
		return nil, err
	}
	conn, err := pgxpool.NewWithConfig(context.Background(), cfg)
	if err != nil {
		return nil, err
	}
	return &Db{Conn: conn, Username: username, Password: password, Host: host, Port: port, DbName: dbName, EnvPassword: fmt.Sprintf(`PGPASSWORD=%v`, password), Url: url}, nil
}

func (db *Db) PgxConn() (*pgx.Conn, error) {
	conn, err := pgx.Connect(context.Background(), db.Url)
	if err != nil {
		return nil, err
	}
	return conn, nil
}

func (db *Db) GetAllTables(st map[string]struct{}) ([]Table, error) {
	rows, err := db.Conn.Query(context.Background(), `
		SELECT schemaname as schema, 
			   tablename as name 
		FROM pg_catalog.pg_tables 
		WHERE schemaname NOT LIKE 'pg_%' 
		AND schemaname != 'information_schema'
	;`)
	if err != nil {
		return nil, err
	}
	var tables []Table
	for rows.Next() {
		var name string
		var schema string
		err := rows.Scan(&schema, &name)
		if err != nil {
			log.Fatal(err)
		}
		if !shouldSkip(schema, name, st) {
			tables = append(tables, NewTable(name, schema, db))
		}
	}

	return tables, nil
}

func (db *Db) CopyFrom(ctx context.Context, r io.Writer, sql string) error {

	conn, err := db.PgxConn()

	if err != nil {
		return err
	}
	defer conn.Close(context.Background())

	_, err = conn.PgConn().CopyTo(ctx, r, sql)

	if err != nil {
		return err
	}

	return nil
}

func (db *Db) GetVersion() string {
	row := db.Conn.QueryRow(context.Background(), `
		SELECT (regexp_matches(version(), '^\w+SQL (\d+\.\d+)'))[1] as version
	;`)

	var version string

	row.Scan(&version)

	return version
}

func (db *Db) Close() {
	db.Conn.Close()
}

func (x *Db) Parse() []string {
	var options []string

	if x.DbName != "" {
		options = append(options, fmt.Sprintf(`--dbname=%v`, x.DbName))
	}

	if x.Host != "" {
		options = append(options, fmt.Sprintf(`--host=%v`, x.Host))
	}

	if x.Port != 0 {
		options = append(options, fmt.Sprintf(`--port=%v`, x.Port))
	}

	if x.Username != "" {
		options = append(options, fmt.Sprintf(`--username=%v`, x.Username))
	}

	if x.Password != "" {
		x.EnvPassword = fmt.Sprintf(`PGPASSWORD=%v`, x.Password)
	}

	return options
}
