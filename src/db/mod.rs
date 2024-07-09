use self::table::Col;
use self::table::ForeignKeyInfo;
use self::table::Table;
use crate::cli::DbParams;
use crate::utils::csv::read_first_line;
use crate::utils::rnd_string;
use crate::utils::should_skip;
use bytes::Bytes;
use sqlx::postgres::PgConnectOptions;
use sqlx::ConnectOptions;
use sqlx::PgConnection;
use sqlx::Pool;
use sqlx::Postgres;
use std::collections::HashSet;
use std::fs;
use std::path::Path;
use std::path::PathBuf;
use tokio::fs::File;
use tokio::io::AsyncWriteExt;
use tokio::io::BufWriter;
pub mod consts;
pub mod table;
use anyhow::{anyhow, Result};
use futures_util::stream::StreamExt;
use std::str::from_utf8;

const PG_EXTENSION_TABLES_QUERY: &str = "
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
";

const WRITE_TABLE_SEQUENCES_QUERY: &str = "
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
";

#[derive(sqlx::FromRow)]
pub struct PgVersion {
    pub regexp_matches: String,
}

#[derive(Clone)]
pub struct Db {
    params: DbParams,
    pool: Pool<Postgres>,
}

#[derive(sqlx::FromRow)]
pub struct DbExtensionTable {
    pub schema: String,
    pub name: String,
    pub extension_name: String,
}

impl Db {
    pub async fn new(params: DbParams, pool: Pool<Postgres>) -> Result<Self> {
        Ok(Self { params, pool })
    }

    pub async fn connect(params: DbParams) -> anyhow::Result<Pool<Postgres>> {
        let connection_string = format!(
            "postgres://{}:{}@{}:{}/{}",
            params.username, params.password, params.host, params.port, params.db
        );
        let pool = Pool::<Postgres>::connect(&connection_string).await?;
        Ok(pool)
    }

    pub async fn connect_admin(&self) -> anyhow::Result<PgConnection> {
        let client = PgConnectOptions::new()
            .username(&self.params.username)
            .password(&self.params.password)
            .host(&self.params.host)
            .database("postgres")
            .connect()
            .await?;
        Ok(client)
    }

    /// Drops and recrates the database restoring to, does this by opening a new connection as the postgres user.
    /// Then disconnecting all other clients then dropping and recreating the database.
    /// Reconnects to the original connection after dropping, to make sure its able to perform consecutive operations
    pub async fn recreate_database(&mut self) -> anyhow::Result<()> {
        let mut client = self.connect_admin().await?;

        let terminate_sql = format!(
            "SELECT pg_terminate_backend(pg_stat_activity.pid) \
            FROM pg_stat_activity \
            WHERE pg_stat_activity.datname = '{}' \
            AND pid <> pg_backend_pid();",
            self.params.db
        );
        sqlx::query(&terminate_sql).execute(&mut client).await?;

        sqlx::query(&format!("DROP DATABASE IF EXISTS \"{}\"", self.params.db))
            .execute(&mut client)
            .await?;

        sqlx::query(&format!("CREATE DATABASE \"{}\"", self.params.db))
            .execute(&mut client)
            .await?;

        let conn = Self::connect(self.params.clone()).await?;

        self.pool = conn;

        Ok(())
    }

    pub async fn get_extension_tables(&self) -> anyhow::Result<Vec<DbExtensionTable>> {
        let client = &self.pool;

        let res = sqlx::query_as::<_, DbExtensionTable>(PG_EXTENSION_TABLES_QUERY)
            .fetch_all(client)
            .await?;

        Ok(res)
    }

    pub async fn create_temp_table(&self, name: String, schema: String) -> anyhow::Result<String> {
        let tmp_table_name = format!("{}_{}", name, rnd_string());
        let client = &self.pool;

        let stmnt = format!(
            "
        CREATE TABLE \"{}\"
        AS
        SELECT * 
        FROM \"{}\".\"{}\"
        WITH NO DATA;
        ",
            tmp_table_name, schema, name
        );
        sqlx::query(&stmnt).execute(client).await?;

        Ok(tmp_table_name)
    }

    pub async fn copy_from_tmp_table(
        &self,
        main_table: &str,
        tmp_table: &str,
    ) -> anyhow::Result<()> {
        let client = &self.pool;

        let stmnt = format!(
            "
            INSERT INTO {}
            SELECT *
            FROM {}
            ON CONFLICT DO NOTHING
        ",
            main_table, tmp_table
        );

        sqlx::query(&stmnt).execute(client).await?;
        sqlx::query(format!("DROP TABLE {}", tmp_table).as_str())
            .execute(client)
            .await?;

        Ok(())
    }

    /// Issue a COPY TO STDOUT statement and transition the connection to streaming data from Postgres.
    pub async fn copy_out(
        &self,
        in_file: &PathBuf,
        table: &str,
        query: Option<&str>,
    ) -> anyhow::Result<u64> {
        let client = &self.pool;
        let mut pg_connection = client.acquire().await.unwrap();

        let file = File::create(in_file)
            .await
            .expect("Error creating file for copying");
        let mut writer = BufWriter::new(file);

        let copy_cmd = match query {
            Some(q) => format!("COPY ({}) TO STDOUT WITH CSV HEADER DELIMITER ','", q),
            None => format!("COPY {} TO STDOUT WITH CSV HEADER DELIMITER ','", table),
        };

        let mut copy_out = pg_connection.copy_out_raw(copy_cmd.as_str()).await?;

        let mut row_count = 0u64;

        while let Some(chunk) = copy_out.next().await {
            let bytes: Bytes = chunk?;
            writer
                .write_all(&bytes)
                .await
                .expect("Error writing data after copy");
            row_count += bytecount::count(&bytes, b'\n') as u64;
        }

        row_count = row_count.saturating_sub(1);

        writer.flush().await?;

        Ok(row_count)
    }

    /// Issue a COPY FROM STDIN statement and transition the connection to streaming data to Postgres.
    pub async fn copy_in(
        &self,
        out_file: &PathBuf,
        name: &str,
        schema: Option<&str>,
    ) -> anyhow::Result<u64> {
        let client = &self.pool;
        let mut pg_connection = client.acquire().await.unwrap();

        let file = tokio::fs::File::open(out_file).await?;
        let first_line = read_first_line(out_file)?;

        let copy_cmd = match schema {
            Some(schema) => format!(
                "COPY \"{}\".\"{}\"({}) FROM STDIN WITH CSV HEADER DELIMITER ','",
                schema, name, first_line,
            ),
            None => format!(
                "COPY \"{}\"({}) FROM STDIN WITH CSV HEADER DELIMITER ','",
                name, first_line,
            ),
        };

        let mut copy_in = pg_connection.copy_in_raw(copy_cmd.as_str()).await?;
        copy_in.read_from(file).await?;
        let rows_inserted = copy_in.finish().await?;
        Ok(rows_inserted)
    }

    pub async fn write_table_sequences(&self) -> anyhow::Result<()> {
        let client = &self.pool;

        sqlx::query(WRITE_TABLE_SEQUENCES_QUERY)
            .execute(client)
            .await?;

        Ok(())
    }
}

pub struct DumpParser<'a> {
    pub tables: Vec<Table>,
    pub relations: Vec<ForeignKeyInfo>,
    path: &'a PathBuf,
}

impl<'a> DumpParser<'a> {
    pub fn parse_from(
        path: &PathBuf,
        skip_tables: HashSet<String>,
        skip_schemas: HashSet<String>,
    ) -> Result<DumpParser> {
        let dump_content = parse_dump_file(path)?;
        let (tables, relations) =
            get_tables_and_foreign_keys(dump_content.as_str(), &skip_tables, &skip_schemas)?;

        Ok(DumpParser {
            relations,
            tables,
            path,
        })
    }

    pub fn split_fk_constraints(&self, root_dir: &PathBuf) -> Result<()> {
        let dump_content = parse_dump_file(self.path)?;

        let (fk_constraints, remaining_content) =
            extract_and_remove_fk_constraints(dump_content.to_string())?;

        let fk_content_path = Path::new(root_dir).join("foreign_keys.sql");
        let ddl_content_path = Path::new(root_dir).join("ddl.sql");

        fs::write(fk_content_path, fk_constraints)?;
        fs::write(ddl_content_path, remaining_content)?;
        fs::remove_file(self.path)?;

        Ok(())
    }
}

fn parse_dump_file(path: &PathBuf) -> Result<String> {
    let data = fs::read(path)?;
    let dump_content =
        from_utf8(&data).map_err(|e| anyhow!("error parsing contents of dump file: {}", e))?;
    Ok(dump_content.to_owned())
}

pub fn extract_and_remove_fk_constraints(input: String) -> std::io::Result<(String, String)> {
    let lines = input.split('\n');

    let mut remaining_content = String::new();
    let mut extracted_content = String::new();
    let mut capture = false;

    for line in lines {
        if line.starts_with("-- Name:") {
            if line.contains("Type: FK CONSTRAINT") {
                // Start capturing this block for extraction
                capture = true;
            } else {
                // Continue appending to the remaining content
                capture = false;
                remaining_content += line;
                remaining_content += "\n";
            }
        }

        if capture {
            extracted_content += line;
            extracted_content += "\n";
        } else if !line.starts_with("-- Name:") {
            remaining_content += line;
            remaining_content += "\n";
        }
    }

    Ok((extracted_content, remaining_content))
}

pub fn get_tables_and_foreign_keys(
    dump_content: &str,
    skip_tables: &HashSet<String>,
    skip_schemas: &HashSet<String>,
) -> Result<(Vec<Table>, Vec<ForeignKeyInfo>)> {
    let result = pg_query::parse(dump_content)?;

    let statements = result.protobuf.stmts;

    let mut tables: Vec<Table> = Vec::new();
    let mut fks: Vec<ForeignKeyInfo> = Vec::new();

    for statement in statements {
        let create_statement = statement.stmt.clone();
        if let Some(pg_query::NodeEnum::CreateStmt(v)) = &create_statement.and_then(|s| s.node) {
            if let Some(relation) = &v.relation {
                let schema = &relation.schemaname;
                let table_name = &relation.relname;

                if should_skip(schema, table_name, skip_tables, skip_schemas) {
                    continue;
                }

                let cols = &v.table_elts;

                let table_cols: Vec<Col> = cols
                    .iter()
                    .filter_map(|col| {
                        col.node.as_ref().and_then(|node_val| {
                            if let pg_query::NodeEnum::ColumnDef(cd) = node_val {
                                let col_name = cd.colname.clone();

                                let type_name =
                                    cd.type_name.as_ref()?.names.iter().find_map(|n| {
                                        n.node.as_ref().and_then(|nd| {
                                            if let pg_query::NodeEnum::String(v) = nd {
                                                let tpe = v.sval.clone();
                                                if tpe != "pg_catalog" {
                                                    Some(v.sval.clone())
                                                } else {
                                                    None
                                                }
                                            } else {
                                                None
                                            }
                                        })
                                    })?;

                                Some(Col {
                                    name: col_name,
                                    col_type: type_name,
                                })
                            } else {
                                None
                            }
                        })
                    })
                    .collect();

                tables.push(Table::new(
                    table_name.to_owned(),
                    schema.to_owned(),
                    table_cols,
                ));
            }
        }

        let alter_statement = statement.stmt.clone();
        if let Some(pg_query::NodeEnum::AlterTableStmt(v)) = &alter_statement.and_then(|s| s.node) {
            let pk_table = v.relation.clone().unwrap().relname;
            let pk_schema = v.relation.as_ref().unwrap().schemaname.clone();

            if should_skip(&pk_schema, &pk_table, skip_tables, skip_schemas) {
                continue;
            }

            for al in &v.cmds {
                let nd = al.node.as_ref().ok_or(anyhow!("Missing node in command"))?;
                if let pg_query::NodeEnum::AlterTableCmd(alter) = nd.clone() {
                    if let Some(nn_val) = alter.def {
                        let node_val = nn_val.node.unwrap();
                        if let pg_query::NodeEnum::Constraint(cons) = node_val {
                            if let pg_query::protobuf::ConstrType::ConstrForeign = cons.contype() {
                                let fk_attrs = &cons.pk_attrs;
                                let pk_attrs = &cons.fk_attrs;

                                let fk_table_val = &cons.pktable.as_ref().unwrap();
                                let fk_table = &fk_table_val.relname;
                                let fk_schema = &fk_table_val.schemaname;

                                if should_skip(&fk_schema, &fk_table, skip_tables, skip_schemas) {
                                    continue;
                                }

                                for (fk_attr, pk_attr) in fk_attrs.iter().zip(pk_attrs.iter()) {
                                    let fk_attr_node = fk_attr.node.as_ref().unwrap();
                                    let pk_attr_node = pk_attr.node.as_ref().unwrap();

                                    match (fk_attr_node, pk_attr_node) {
                                        (
                                            pg_query::NodeEnum::String(fk_col_name),
                                            pg_query::NodeEnum::String(col_name),
                                        ) => {
                                            let fk_schema_table =
                                                format!("{}.{}", fk_schema, fk_table); // Assuming fkSchema and fkTable are defined earlier
                                            let pk_schema_table =
                                                format!("{}.{}", pk_schema, pk_table); // Assuming pkSchema and pkTable are defined earlier

                                            let foreign_col_type = get_table_type(
                                                &fk_schema_table,
                                                &tables,
                                                &fk_col_name.sval,
                                            )
                                            .expect(&format!(
                                                "Error getting col type for foreign table: {}",
                                                fk_schema_table
                                            ));
                                            let col_type = get_table_type(
                                                &pk_schema_table,
                                                &tables,
                                                &col_name.sval,
                                            )
                                            .expect(&format!(
                                                "Error getting col type for table: {}",
                                                pk_schema_table
                                            ));

                                            let new_fk_rel = ForeignKeyInfo::new(
                                                pk_schema.to_string(),
                                                pk_table.to_string(),
                                                col_name.sval.to_string(),
                                                fk_schema.to_string(),
                                                fk_table.to_string(),
                                                fk_col_name.sval.to_string(),
                                                foreign_col_type,
                                                col_type,
                                            );

                                            fks.push(new_fk_rel);
                                        }
                                        _ => {}
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Ok((tables, fks))
}

fn get_table_type(id: &str, tables: &[Table], lookup_col: &str) -> Option<String> {
    for tbl in tables {
        if tbl.details.display == id {
            for col in &tbl.cols {
                if col.name == lookup_col {
                    return Some(col.col_type.clone());
                }
            }
        }
    }
    None
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_extracts_fk_constraints() {
        let input = "\
-- Name: fk_example; Type: FK CONSTRAINT; Schema: public; Owner: owner
ALTER TABLE public.example ADD CONSTRAINT fk_example FOREIGN KEY (column) REFERENCES other_table(column);
-- Name: not_fk_example; Type: INDEX; Schema: public; Owner: owner
CREATE INDEX not_fk_example ON public.example USING btree (column);";

        let (extracted, remaining) = extract_and_remove_fk_constraints(input.to_string()).unwrap();

        assert_eq!(extracted.trim(), "-- Name: fk_example; Type: FK CONSTRAINT; Schema: public; Owner: owner\nALTER TABLE public.example ADD CONSTRAINT fk_example FOREIGN KEY (column) REFERENCES other_table(column);");
        assert_eq!(remaining.trim(), "-- Name: not_fk_example; Type: INDEX; Schema: public; Owner: owner\nCREATE INDEX not_fk_example ON public.example USING btree (column);");
    }

    #[test]
    fn it_handles_empty_input() {
        let input = "";

        let (extracted, remaining) = extract_and_remove_fk_constraints(input.to_string()).unwrap();

        assert_eq!(extracted, "");
        assert_eq!(remaining, "\n");
    }

    #[test]
    fn it_handles_input_without_fk_constraints() {
        let input = "\
-- Name: not_fk_example; Type: INDEX; Schema: public; Owner: owner
CREATE INDEX not_fk_example ON public.example USING btree (column);";

        let (extracted, remaining) = extract_and_remove_fk_constraints(input.to_string()).unwrap();

        assert_eq!(extracted, "");
        assert_eq!(remaining.trim(), input);
    }

    #[test]
    fn it_processes_multiple_fk_constraints() {
        let input = "\
-- Name: fk_example_one; Type: FK CONSTRAINT; Schema: public; Owner: owner
ALTER TABLE public.example_one ADD CONSTRAINT fk_example_one FOREIGN KEY (column_one) REFERENCES other_table(column_one);
-- Name: not_fk_example; Type: INDEX; Schema: public; Owner: owner
CREATE INDEX not_fk_example ON public.example USING btree (column);
-- Name: fk_example_two; Type: FK CONSTRAINT; Schema: public; Owner: owner
ALTER TABLE public.example_two ADD CONSTRAINT fk_example_two FOREIGN KEY (column_two) REFERENCES other_table(column_two);";

        let (extracted, remaining) = extract_and_remove_fk_constraints(input.to_string()).unwrap();

        let expected_extracted = "\
-- Name: fk_example_one; Type: FK CONSTRAINT; Schema: public; Owner: owner
ALTER TABLE public.example_one ADD CONSTRAINT fk_example_one FOREIGN KEY (column_one) REFERENCES other_table(column_one);
-- Name: fk_example_two; Type: FK CONSTRAINT; Schema: public; Owner: owner
ALTER TABLE public.example_two ADD CONSTRAINT fk_example_two FOREIGN KEY (column_two) REFERENCES other_table(column_two);";

        let expected_remaining = "\
-- Name: not_fk_example; Type: INDEX; Schema: public; Owner: owner
CREATE INDEX not_fk_example ON public.example USING btree (column);";

        assert_eq!(extracted.trim(), expected_extracted.trim());
        assert_eq!(remaining.trim(), expected_remaining.trim());
    }

    #[test]
    fn it_should_extract_tables_and_foreign_keys() -> Result<()> {
        let st: HashSet<String> = HashSet::new();
        let ss: HashSet<String> = HashSet::new();
        let (tables, fks) = get_tables_and_foreign_keys(
            r"
        CREATE TABLE public.data_src (
            datasrc_id character(6) NOT NULL,
            authors text,
            title text NOT NULL,
            year integer,
            journal text,
            vol_city text,
            issue_state text,
            start_page text,
            end_page text
        );
        CREATE TABLE public.datsrcln (
            ndb_no character(5) NOT NULL,
            nutr_no character(3) NOT NULL,
            datasrc_id character(6) NOT NULL
        );
        ALTER TABLE ONLY public.datsrcln
        ADD CONSTRAINT datsrcln_datasrc_id_fkey FOREIGN KEY (datasrc_id) REFERENCES public.data_src(datasrc_id);                      
        ",
            &st,
            &ss,
        )?;
        assert_eq!(tables.len(), 2);
        assert_eq!(fks.len(), 1);
        let table = tables.get(0).unwrap();
        assert_eq!(table.cols.len(), 9);
        assert_eq!(table.details.name, "data_src");
        Ok(())
    }
}
