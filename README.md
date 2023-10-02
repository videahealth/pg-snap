# pg-snap

Tool to take database snapshots and restore them

## Getting Started

### Command

```bash
pg-snap dump --username "postgres" --db "demodb" --host "localhost" --password "postgres" --skip-tables "test.*,public.Cats,public.Event*"
```

```bash
pg-snap restore --username "postgres" --db "demodb2" --host "localhost" --password "postgres"
```
