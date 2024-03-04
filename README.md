<div align="center">
  <h1>PgSnap</h1>

  <p>
  Tool to take postgres database snapshots and restore them
</a>
  </p>

</div>

### Install

```bash
curl -sSL https://raw.githubusercontent.com/videahealth/pg-snap/main/install.sh | sh
```

### Usage

```bash
pg_snap dump --username "postgres" --db "demodb" --host "localhost" --password "postgres" --skip-tables "test.*,public.Cats,public.Event*"
```

```bash
pg_snap restore --username "postgres" --db "demodb2" --host "localhost" --password "postgres"
```