use clap::Parser;
use cli::{dump::DumpCmd, Command, Mode};

use crate::cli::restore::RestoreCmd;
mod cli;
mod config;
mod db;
mod db_walk;
mod local;
mod pg_command;
mod utils;
use anyhow::Context;

fn init_logger(debug: bool) {
    if debug {
        std::env::set_var("RUST_LOG", "debug");
    } else {
        std::env::set_var("RUST_LOG", "info");
    }
    env_logger::init();
}

async fn try_main() -> anyhow::Result<()> {
    let mode = Mode::parse();

    match mode {
        Mode::Dump(args) => {
            init_logger(args.common.debug);
            let dump = DumpCmd::new(args);
            dump.run().await.context("Error running dump command")?
        }
        Mode::Restore(args) => {
            init_logger(args.common.debug);
            let restore = RestoreCmd::new(args);
            restore
                .run()
                .await
                .context("Error running restore command")?
        }
    }

    Ok(())
}

#[tokio::main]
async fn main() {
    if let Err(err) = try_main().await {
        eprintln!("ERROR: {}", err);
        err.chain()
            .skip(1)
            .for_each(|cause| eprintln!("because: {}", cause));
        std::process::exit(1);
    }
}
