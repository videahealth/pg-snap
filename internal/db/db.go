package db

import (
	"context"
	"fmt"
	"io"
	"log"
	"strings"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/videahealth/pg-snap/internal/utils"
)

const pgExtentionsQuery = `
SELECT
cl.relname AS name,
ns.nspname AS schema,
ext.extname AS extension_name
FROM pg_class cl
JOIN pg_namespace ns ON cl.relnamespace = ns.oid
JOIN pg_depend dep ON dep.objid = cl.oid
JOIN pg_extension ext ON dep.refobjid = ext.oid
WHERE cl.relkind = 'r'
AND ns.nspname NOT IN ('pg_catalog', 'information_schema')
`

const writeTableSequencesQuery = `
with sequences as (select *
    from (select table_schema,
                table_name,
                column_name,
                pg_get_serial_sequence(format('%I.%I', table_schema, table_name),
                                        column_name) as col_sequence
        from information_schema.columns
        where table_schema not in ('pg_catalog', 'information_schema')) t
    where col_sequence is not null),
maxvals as (select table_schema,
        table_name,
        column_name,
        col_sequence,
        (xpath('/row/max/text()',
                query_to_xml(format('select max(%I) from %I.%I', column_name, table_schema, table_name),
                            true, true, ''))
            )[1]::text::bigint as max_val
from sequences)
select table_schema,
table_name,
column_name,
col_sequence,
coalesce(max_val, 0) as max_val,
setval(col_sequence, coalesce(max_val, 1)) --<< this will change the sequence
from maxvals;
`

// Determines if the given table name and schema should be skipped based on the given set of skipTables.
// Ex skip tables: public.* (skip entire public schema), public.mytable (skip only mytable), public.myt* (skip all tables prefixed with myt).
func ShouldSkip(tableSchema, tableName string, skipTables map[string]struct{}) bool {
	fullName := strings.ToLower(tableSchema + "." + tableName)
	schemaWildcard := strings.ToLower(tableSchema + ".*")

	lowerSkipTables := make(map[string]struct{})
	for k := range skipTables {
		lowerSkipTables[strings.ToLower(k)] = struct{}{}
	}

	_, fullMatch := lowerSkipTables[fullName]
	_, wildcardMatch := lowerSkipTables[schemaWildcard]

	if fullMatch || wildcardMatch {
		return true
	}

	for skipTable := range lowerSkipTables {
		if strings.HasPrefix(skipTable, strings.ToLower(tableSchema)+".") {
			trimmed := skipTable[len(strings.ToLower(tableSchema)+"."):]
			pattern := strings.Replace(trimmed, "*", "", -1)

			if strings.HasPrefix(strings.ToLower(tableName), pattern) {
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

type ExtTable struct {
	Name          string
	Schema        string
	ExtensionName string
}

// Creates a new db instance by creating a connection pool
func NewDb(ctx context.Context, params utils.DbParams) (*Db, error) {
	url := fmt.Sprintf("postgres://%s:%s@%s:%d/%s", params.Username, params.Password, params.Host, params.Port, params.Db)
	cfg, err := pgxpool.ParseConfig(url)

	if err != nil {
		return nil, err
	}
	conn, err := pgxpool.NewWithConfig(context.Background(), cfg)
	if err != nil {
		return nil, err
	}
	return &Db{Conn: conn, Username: params.Username, Password: params.Password, Host: params.Host, Port: params.Port, DbName: params.Db, EnvPassword: fmt.Sprintf(`PGPASSWORD=%v`, params.Password), Url: url}, nil
}

// Resets database connection
func (db *Db) ResetConn() error {
	url := fmt.Sprintf("postgres://%s:%s@%s:%d/%s", db.Username, db.Password, db.Host, db.Port, db.DbName)
	cfg, err := pgxpool.ParseConfig(url)

	if err != nil {
		return err
	}
	conn, err := pgxpool.NewWithConfig(context.Background(), cfg)
	if err != nil {
		return err
	}
	db.Conn = conn
	return nil
}

// Drops and recrates the database restoring to, does this by opening a new connection as the postgres user.
// Then disconnecting all other clients then dropping and recreating the database.
// Reconnects to the original connection after dropping, to make sure its able to perform consecutive operations
func (db *Db) DropAndCreateDb() error {
	url := fmt.Sprintf("postgres://%s:%s@%s:%d/%s", db.Username, db.Password, db.Host, db.Port, "postgres")
	cfg, err := pgxpool.ParseConfig(url)
	if err != nil {
		return err
	}
	conn, err := pgxpool.NewWithConfig(context.Background(), cfg)
	if err != nil {
		return err
	}
	defer conn.Close()
	_, err = conn.Exec(context.Background(), `
		SELECT pg_terminate_backend(pg_stat_activity.pid)
		FROM pg_stat_activity
		WHERE pg_stat_activity.datname = $1
		AND pid <> pg_backend_pid()`, db.DbName)
	if err != nil {
		return fmt.Errorf("error running pg_terminate_backend: %w", err)
	}

	_, err = conn.Exec(context.Background(), fmt.Sprintf("DROP DATABASE IF EXISTS \"%s\"", db.DbName))
	if err != nil {
		return fmt.Errorf("error dropping db: %w", err)
	}
	_, err = conn.Exec(context.Background(), fmt.Sprintf("CREATE DATABASE \"%s\"", db.DbName))
	if err != nil {
		return fmt.Errorf("error creating db: %w", err)
	}

	if err = db.ResetConn(); err != nil {
		return fmt.Errorf("error resetting db conn: %w", err)
	}

	return nil
}

func (db *Db) CreateTempTable(name string, schema string) (string, error) {

	tmpTableName := fmt.Sprintf(`%s_%s`, name, utils.RandomString(10))

	query := fmt.Sprintf(`
		CREATE TABLE "%s"
		AS
		SELECT * 
		FROM "%s"."%s"
		WITH NO DATA`,
		tmpTableName, schema, name)

	_, err := db.Conn.Exec(context.Background(), query)

	if err != nil {
		return "", err
	}

	return tmpTableName, nil
}

func (db *Db) CopyFromTempTable(mainTable string, tempTable string) (int64, error) {

	r, err := db.Conn.Exec(context.Background(), fmt.Sprintf(`
		INSERT INTO %s
		SELECT *
		FROM "%s"
		ON CONFLICT DO NOTHING
	`, mainTable, tempTable))

	if err != nil {
		return 0, err
	}

	query := fmt.Sprintf(`
		DROP TABLE "%s"
	`, tempTable)

	_, err = db.Conn.Exec(context.Background(), query)

	if err != nil {
		return 0, err
	}

	return r.RowsAffected(), nil
}

func (db *Db) WriteTableSequences() error {

	_, err := db.Conn.Exec(context.Background(), writeTableSequencesQuery)

	if err != nil {
		return err
	}

	return nil
}

func (db *Db) PgxConn() (*pgx.Conn, error) {
	conn, err := pgx.Connect(context.Background(), db.Url)
	if err != nil {
		return nil, err
	}
	return conn, nil
}

func (db *Db) GetExtensions() ([]ExtTable, error) {
	rows, err := db.Conn.Query(context.Background(), pgExtentionsQuery)
	if err != nil {
		return nil, fmt.Errorf("error getting table extentions: %w", err)
	}
	var tables []ExtTable
	for rows.Next() {
		var name string
		var schema string
		var extension_name string
		err := rows.Scan(&name, &schema, &extension_name)
		if err != nil {
			log.Fatal(err)
		}
		tables = append(tables, ExtTable{
			Name:          name,
			Schema:        schema,
			ExtensionName: extension_name,
		})
	}

	return tables, nil
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
		if !ShouldSkip(schema, name, st) {
			tables = append(tables, NewTable(name, schema, db))
		}
	}

	return tables, nil
}

func (db *Db) CopyFrom(ctx context.Context, r io.Writer, sql string) (int64, error) {

	conn, err := db.PgxConn()

	if err != nil {
		return 0, err
	}
	defer conn.Close(context.Background())

	res, err := conn.PgConn().CopyTo(ctx, r, sql)

	if err != nil {
		return 0, err
	}

	return res.RowsAffected(), nil
}

func (db *Db) CopyTo(ctx context.Context, r io.Reader, sql string) (int64, error) {

	conn, err := db.PgxConn()

	if err != nil {
		return 0, err
	}
	defer conn.Close(context.Background())

	res, err := conn.PgConn().CopyFrom(ctx, r, sql)

	if err != nil {
		return 0, err
	}

	return res.RowsAffected(), nil
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
