use tokio_postgres::{Client, Error};
use tokio_postgres::{NoTls, Row};

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

pub struct Db {
    pub host: String,
    pub user: String,
    pub db: String,
    pub pw: String,
    pub client: Client,
}

impl Db {
    pub async fn connect(
        host: String,
        user: String,
        db: String,
        pw: String,
    ) -> Result<Db, tokio_postgres::Error> {
        // Connect to the database.
        let (client, connection) = tokio_postgres::connect(
            format!("host={host} user={user} dbname={db} password={pw}").as_str(),
            NoTls,
        )
        .await?;

        // The connection object performs the actual communication with the database,
        // so spawn it off to run on its own.
        tokio::spawn(async move {
            if let Err(e) = connection.await {
                eprintln!("connection error: {}", e);
            }
        });

        let new_db = Db {
            client,
            db,
            host,
            pw,
            user,
        };

        Ok(new_db)
    }

    pub async fn get_table_details(&self, table_name: &str) -> Result<Vec<Row>, Error> {
        let columns = self
            .client
            .query(
                "
                WITH types AS (
                    SELECT oid, typname
                    FROM pg_type
                )
                SELECT 
                    attname AS column_name,
                    CASE WHEN attndims = 0 THEN t.typname ELSE t.typname || '[]' END AS data_type,
                    CASE WHEN attnotnull THEN 'NO' ELSE 'YES' END AS is_nullable
                FROM 
                    pg_attribute 
                    JOIN types t ON pg_attribute.atttypid = t.oid
                WHERE 
                    attrelid = (
                        SELECT oid
                        FROM pg_class
                        WHERE relname = $1
                    ) AND 
                    attnum > 0 AND 
                    NOT attisdropped",
                &[&table_name],
            )
            .await?;

        return Ok(columns);
    }
}

pub async fn recreate_database(
    host: String,
    user: String,
    dbname: String,
    password: String,
) -> Result<(), Error> {
    let db = Db::connect(host, user, "postgres".to_string(), password).await?;

    let terminate_sql = format!(
        "SELECT pg_terminate_backend(pg_stat_activity.pid) \
        FROM pg_stat_activity \
        WHERE pg_stat_activity.datname = '{}' \
        AND pid <> pg_backend_pid();",
        dbname
    );
    db.client.execute(&terminate_sql, &[]).await?;

    db.client
        .execute(&format!("DROP DATABASE IF EXISTS \"{}\"", dbname), &[])
        .await?;

    db.client
        .execute(&format!("CREATE DATABASE \"{}\"", dbname), &[])
        .await?;

    Ok(())
}
