# pg-snap

Tool to take database snapshots and restore them

## Getting Started

Install:

Available binaries:

- `pg-snap-aarch64-apple-darwin` (Mac M1)
- `pg-snap-x86_64-apple-darwin` (Mac Intel)

```bash
sudo curl -L -o /usr/local/bin/pg_snap https://github.com/videahealth/pg-snap/releases/download/v0.1.0/<binary>
sudo chmod +x /usr/local/bin/pg_snap

# In a new shell session
pg_snap -h
```

### Command

```bash
pg_snap dump --username "postgres" --db "demodb" --host "localhost" --password "postgres" --skip-tables "test.*,public.Cats,public.Event*"
```

```bash
pg_snap restore --username "postgres" --db "demodb2" --host "localhost" --password "postgres"
```
