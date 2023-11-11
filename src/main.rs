use cli::Mode;
use simple_log::LogConfigBuilder;

use crate::{dump::dump_db, restore::restore_db};
use clap::Parser;
mod cli;
mod consts;
mod db;
mod dump;
mod restore;
mod structs;
mod table;
mod utils;
#[macro_use]
extern crate simple_log;

// float8, uuid, json

fn init_logger(debug: bool) {
    let cfg = match debug {
        true => LogConfigBuilder::builder()
            .level("debug")
            .output_console()
            .build(),
        false => LogConfigBuilder::builder()
            .level("info")
            .output_console()
            .build(),
    };
    simple_log::new(cfg).expect("Unable to initialize logger");
}

#[tokio::main] // By default, tokio_postgres uses the tokio crate as its runtime.
async fn main() -> anyhow::Result<()> {
    let mode = Mode::parse();

    match mode {
        Mode::Dump(args) => {
            init_logger(args.common.debug);
            match dump_db(
                args.common.host,
                args.common.username,
                args.common.db,
                args.common.password,
                args.skip_tables,
                args.concurrency,
                args.common.file_path,
            )
            .await
            {
                Ok(_) => println!("Success!"),
                Err(error) => panic!("Error: {}", error),
            };
        }
        Mode::Restore(args) => {
            init_logger(args.common.debug);
            restore_db(
                args.common.host,
                args.common.username,
                args.common.db,
                args.common.password,
                args.concurrency,
                args.common.file_path,
            )
            .await;
        }
    }

    Ok(())
}
