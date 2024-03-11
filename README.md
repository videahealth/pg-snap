<div align="center">
  <h1>PgSnap</h1>

  <p>
  Tool to take postgres database snapshots and restore them
</a>
  </p>

</div>

## Install

```bash
curl -sSL https://raw.githubusercontent.com/videahealth/pg-snap/main/install.sh | sh
```

## Usage

### Dump

```bash
pg_snap dump --username "postgres" \
             --db "demodb" \
             --host "localhost" \
             --password "postgres" \
             --config pg-snap.json \
             --compress
```

* Take a full database dump skipping some tables
```json
// pg-snap.json
{
    "skip_tables": [
        "test.*",
        "public.Cats",
        "public.Event*"
    ]
}
```

* Take a dump of a subset of data
```json
// pg-snap.json
{
    "skip_tables": [
        "test.*",
        "public.Cats",
        "public.Event*"
    ],
    "subset": {
        "table": "PetOwners",
        "schema": "public",
        "where_clause": "owner_id = 332",
        "passthrough": [
            // Include all data in public.migrations in the dump
            "public.migrations"
        ]
    }
}
```
NOTE: If a required table is part of the subset but also in `skip_tables`, it will copy that data also.

### Restore

Restore data into target db. The flag `-f` points to file generated through `dump` command.

```bash
pg_snap restore --username "postgres" \
                --db "demodb2" \
                --host "localhost" \
                --password "postgres" \
                -f pets.zip
```