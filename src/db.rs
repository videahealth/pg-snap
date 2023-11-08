use sqlx::postgres::PgConnectOptions;
use sqlx::ConnectOptions;
use sqlx::PgConnection;

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

#[derive(sqlx::FromRow)]
pub struct DbTable {
    pub schemaname: String,
    pub tablename: String,
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

    pub async fn recreate_database(&self) -> anyhow::Result<()> {
        let mut client = self.connect().await?;

        let terminate_sql = format!(
            "SELECT pg_terminate_backend(pg_stat_activity.pid) \
            FROM pg_stat_activity \
            WHERE pg_stat_activity.datname = '{}' \
            AND pid <> pg_backend_pid();",
            self.db
        );

        sqlx::query(&terminate_sql).execute(&mut client);
        sqlx::query(&format!("DROP DATABASE IF EXISTS \"{}\"", self.db)).execute(&mut client);
        sqlx::query(&format!("CREATE DATABASE \"{}\"", self.db)).execute(&mut client);

        Ok(())
    }

    pub async fn get_tables(&self) -> anyhow::Result<Vec<DbTable>> {
        let mut client = self.connect().await?;

        let  res =
            sqlx::query_as::<_, DbTable>("SELECT schemaname, tablename FROM pg_catalog.pg_tables WHERE schemaname NOT LIKE 'pg_%' AND schemaname != 'information_schema'")
                .fetch_all(&mut client).await?;

        Ok(res)
    }
}
