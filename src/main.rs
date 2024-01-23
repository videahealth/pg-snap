use anyhow::anyhow;
use cli::Mode;
use simple_log::LogConfigBuilder;

use crate::{dump::dump_db, restore::restore_db};
use clap::Parser;
mod cli;
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

async fn try_main() -> anyhow::Result<()> {
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
                args.common.concurrency,
            )
            .await
            {
                Ok(_) => Ok(()),
                Err(error) => Err(anyhow!("Error running dump command:\n \t{}", error)),
            }
        }
        Mode::Restore(args) => {
            init_logger(args.common.debug);
            match restore_db(
                args.common.host,
                args.common.username,
                args.common.db,
                args.common.password,
                args.common.concurrency,
            )
            .await
            {
                Ok(_) => Ok(()),
                Err(error) => Err(anyhow!("Error running restore command:\n \t{}", error)),
            }
        }
    }
}

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    if let Err(err) = try_main().await {
        eprintln!("ERROR: {}", err);
        err.chain()
            .skip(1)
            .for_each(|cause| eprintln!("because: {}", cause));
        std::process::exit(1);
    }

    Ok(())
}
