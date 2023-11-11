use clap::Parser;

use crate::consts::{
    DEFAULT_DUMP_DIR, DEFAULT_DUMP_NUMBER_OF_WORKERS, DEFAULT_RESTORE_NUMBER_OF_WORKERS,
};

#[derive(Parser, Debug)]
pub struct CommonArgs {
    #[clap(
        short = 'H',
        long,
        help = "Set the database host (e.g., localhost, 192.168.0.1)"
    )]
    pub host: String,

    #[clap(short, long, help = "Database username for authentication")]
    pub username: String,

    #[clap(short, long, help = "Password for the specified database user")]
    pub password: String,

    #[clap(short, long, help = "Name of the database to perform operations on")]
    pub db: String,

    #[clap(short = 'D', long, help = "Enable debug mode for additional output")]
    pub debug: bool,

    #[clap(
        short = 'P',
        long,
        help = "File path used for dump or restore operations (optional)",
        default_value = DEFAULT_DUMP_DIR
    )]
    pub file_path: String,
}

#[derive(Parser, Debug)]
pub struct Dump {
    #[clap(flatten)]
    pub common: CommonArgs,

    #[clap(
        short,
        long,
        help = "Comma-separated list of tables to skip during dump (optional)"
    )]
    pub skip_tables: Option<String>,

    #[clap(short, long, help = "Set the number of concurrent threads (optional)", default_value = DEFAULT_DUMP_NUMBER_OF_WORKERS)]
    pub concurrency: usize,
}

#[derive(Parser, Debug)]
pub struct Restore {
    #[clap(flatten)]
    pub common: CommonArgs,

    #[clap(short, long, help = "Set the number of concurrent threads (optional)", default_value = DEFAULT_RESTORE_NUMBER_OF_WORKERS)]
    pub concurrency: usize,
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
