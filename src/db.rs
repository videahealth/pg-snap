use crate::utils::rnd_string;
use sqlx::postgres::PgConnectOptions;
use sqlx::ConnectOptions;
use sqlx::PgConnection;

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

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Index {
    pub schema_name: String,
    pub table_name: String,
    pub index_name: String,
    pub indexdef: String,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct ForeignKey {
    pub schema_name: String,
    pub table_name: String,
    pub column_name: String,
    pub ref_schema_name: String,
    pub ref_table_name: String,
    pub ref_column_name: String,
    pub constraint_name: String,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Constraint {
    pub schema_name: String,
    pub table_name: String,
    pub constraint_name: String,
    pub constraint_type: String,
    pub check_clause: Option<String>,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct UserDefinedEnum {
    pub schema_name: String,
    type_name: String,
    enum_values: Vec<String>,
}

#[derive(sqlx::FromRow, Debug)]
pub struct DbTable {
    pub schema: String,
    pub name: String,
}

#[derive(sqlx::FromRow)]
pub struct DbExtensionTable {
    pub schema: String,
    pub name: String,
    pub extension_name: String,
}

#[derive(sqlx::FromRow)]
pub struct PgVersion {
    pub regexp_matches: String,
}

#[derive(Clone)]
pub struct Db {
    pub host: String,
    pub user: String,
    pub db: String,
    pub pw: String,
}

impl Db {
    pub fn new(host: String, user: String, db: String, pw: String) -> Self {
        Db { host, user, db, pw }
    }

    pub async fn get_version(&self) -> anyhow::Result<String> {
        let mut client = self.connect().await?;

        let res = sqlx::query_as::<_, PgVersion>(
            r"SELECT (regexp_matches(version(), '^\w+SQL (\d+\.\d+)'))[1]",
        )
        .fetch_all(&mut client)
        .await?;

        let pg_version = &res[0];
        let version = &pg_version.regexp_matches;

        let remote_version = version.to_string();

        Ok(remote_version.to_string())
    }

    pub async fn connect(&self) -> anyhow::Result<PgConnection> {
        let client = PgConnectOptions::new()
            .username(&self.user)
            .password(&self.pw)
            .host(&self.host)
            .database(&self.db)
            .connect()
            .await?;
        Ok(client)
    }
    pub async fn connect_admin(&self) -> anyhow::Result<PgConnection> {
        let client = PgConnectOptions::new()
            .username(&self.user)
            .password(&self.pw)
            .host(&self.host)
            .database("postgres")
            .connect()
            .await?;
        Ok(client)
    }
    pub async fn recreate_database(&self) -> anyhow::Result<()> {
        let mut client = self.connect_admin().await?;

        let terminate_sql = format!(
            "SELECT pg_terminate_backend(pg_stat_activity.pid) \
            FROM pg_stat_activity \
            WHERE pg_stat_activity.datname = '{}' \
            AND pid <> pg_backend_pid();",
            self.db
        );

        sqlx::query(&terminate_sql).execute(&mut client).await?;
        sqlx::query(&format!("DROP DATABASE IF EXISTS \"{}\"", self.db))
            .execute(&mut client)
            .await?;
        sqlx::query(&format!("CREATE DATABASE \"{}\"", self.db))
            .execute(&mut client)
            .await?;

        Ok(())
    }

    pub async fn get_tables(&self) -> anyhow::Result<Vec<DbTable>> {
        let mut client = self.connect().await?;

        let  res =
            sqlx::query_as::<_, DbTable>("SELECT schemaname as schema, tablename as name FROM pg_catalog.pg_tables WHERE schemaname NOT LIKE 'pg_%' AND schemaname != 'information_schema'")
                .fetch_all(&mut client).await?;

        Ok(res)
    }

    pub async fn get_extension_tables(&self) -> anyhow::Result<Vec<DbExtensionTable>> {
        let mut client = self.connect().await?;

        let res = sqlx::query_as::<_, DbExtensionTable>(PG_EXTENSION_TABLES_QUERY)
            .fetch_all(&mut client)
            .await?;

        Ok(res)
    }

    pub async fn create_temp_table(&self, name: String, schema: String) -> anyhow::Result<String> {
        let tmp_table_name = format!("{}_{}", name, rnd_string());
        let mut client = self.connect().await?;

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
        sqlx::query(&stmnt).execute(&mut client).await?;

        Ok(tmp_table_name)
    }

    pub async fn copy_from_tmp_table(
        &self,
        main_table: &str,
        tmp_table: &str,
    ) -> anyhow::Result<()> {
        let mut client = self.connect().await?;

        let stmnt = format!(
            "
            INSERT INTO {}
            SELECT *
            FROM {}
            ON CONFLICT DO NOTHING
        ",
            main_table, tmp_table
        );

        sqlx::query(&stmnt).execute(&mut client).await?;
        sqlx::query(format!("DROP TABLE {}", tmp_table).as_str())
            .execute(&mut client)
            .await?;

        Ok(())
    }

    pub async fn write_table_sequences(&self) -> anyhow::Result<()> {
        let mut client = self.connect().await?;

        sqlx::query(WRITE_TABLE_SEQUENCES_QUERY)
            .execute(&mut client)
            .await?;

        Ok(())
    }
}
