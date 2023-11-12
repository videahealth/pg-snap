<div align="center">
  <h1>PgSnap</h1>

  <p>
  Tool to take postgres database snapshots and restore them
</a>
  </p>

</div>

### Features

- Create a dump of any postgres database
- Restore dump file into any postgres database
- Skip dumping of data from specific schemas/tables

### Install

```bash
curl -sSL https://raw.githubusercontent.com/videahealth/pg-snap/main/install.sh | sh
```

### Usage

- Dump

```bash
Usage: pg-snap dump [OPTIONS] --host <HOST> --username <USERNAME> --password <PASSWORD> --db <DB>

Options:
  -H, --host <HOST>                Set the database host (e.g., localhost, 192.168.0.1)
  -u, --username <USERNAME>        Database username for authentication
  -p, --password <PASSWORD>        Password for the specified database user
  -d, --db <DB>                    Name of the database to perform operations on
  -D, --debug                      Enable debug mode for additional output
  -P, --file-path <FILE_PATH>      File path used for dump or restore operations (optional) [default: ./pg-data-dump]
  -s, --skip-tables <SKIP_TABLES>  Comma-separated list of tables to skip during dump (optional)
  -c, --concurrency <CONCURRENCY>  Set the number of concurrent threads (optional) [default: 5]
  -h, --help                       Print help
```

- Restore

```bash
Usage: pg-snap restore [OPTIONS] --host <HOST> --username <USERNAME> --password <PASSWORD> --db <DB>

Options:
  -H, --host <HOST>                Set the database host (e.g., localhost, 192.168.0.1)
  -u, --username <USERNAME>        Database username for authentication
  -p, --password <PASSWORD>        Password for the specified database user
  -d, --db <DB>                    Name of the database to perform operations on
  -D, --debug                      Enable debug mode for additional output
  -P, --file-path <FILE_PATH>      File path used for dump or restore operations (optional) [default: ./pg-data-dump]
  -c, --concurrency <CONCURRENCY>  Set the number of concurrent threads (optional) [default: 3]
  -h, --help                       Print help
```

- Example:

```bash
pg_snap dump --username "postgres" --db "demodb" --host "localhost" --password "postgres" --skip-tables "test.*,public.Cats,public.Event*"
```

```bash
pg_snap restore --username "postgres" --db "demodb2" --host "localhost" --password "postgres"
```
