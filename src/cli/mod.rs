use anyhow::Result;
use clap::Parser;
use std::path::PathBuf;
pub mod dump;
pub mod restore;

/// Restores a database from a dump specified by the --dump_path argument,
/// which can be a zip archive or a folder.
#[derive(Parser, Debug)]
pub struct Restore {
    #[clap(flatten)]
    pub common: CommonArgs,
    #[clap(flatten)]
    pub db: DbArgs,

    #[clap(
        short = 'f',
        help = "Path to a zip archive or folder containing the database dump."
    )]
    pub dump_path: String,

    #[clap(long, short, action)]
    pub yes: bool,
}

/// Connects to a database and captures its current state as a snapshot.
/// It allows customization through the --config option for specific data inclusion or exclusion.
#[derive(Parser, Debug)]
pub struct Dump {
    #[clap(flatten)]
    pub common: CommonArgs,
    #[clap(flatten)]
    pub db: DbArgs,

    #[clap(
        short = 'C',
        long,
        help = "Configuration for dumping data. Currently contains tables to skip and any subset configuration."
    )]
    pub config: Option<PathBuf>,

    #[clap(long, help = "Compress output folder")]
    pub compress: bool,

    #[clap(
        short,
        long,
        help = "Name for output folder / zip archive. Defaults to the database name."
    )]
    pub name: Option<String>,
}

#[derive(Parser, Debug)]

pub struct DbArgs {
    #[clap(
        short = 'H',
        long,
        help = "The hostname or IP address of the database server."
    )]
    pub host: String,

    #[clap(short, long, help = "The username for database authentication.")]
    pub username: String,

    #[clap(short, long, help = "The password for database authentication.")]
    pub password: String,

    #[clap(short, long, help = "The name of the database to connect to.")]
    pub db: String,

    #[clap(
        short = 'P',
        long,
        default_value_t = 5432,
        help = "The port number on which the database server is listening."
    )]
    pub port: i32,
}

#[derive(Parser, Debug)]
pub struct CommonArgs {
    #[clap(
        short = 'D',
        long,
        help = "Enable detailed debug logging for troubleshooting or insight into application operations."
    )]
    pub debug: bool,

    #[clap(
        short,
        long,
        help = "Set the number of concurrent operations for copying data. Affects performance and resource usage. Omit for default concurrency."
    )]
    pub concurrency: Option<usize>,
}

#[derive(Parser, Debug)]
#[clap(
    author = "VideaHealth",
    version = env!("CARGO_PKG_VERSION"),
    about = "Tool to dump and restore database snapshots"
)]
pub enum Mode {
    Dump(Dump),
    Restore(Restore),
}

#[derive(Clone)]
pub struct DbParams {
    pub host: String,
    pub username: String,
    pub password: String,
    pub db: String,
    pub port: i32,
}

pub trait Command {
    async fn run(&self) -> Result<()>;
}
