use crate::cli::restore::RestoreCmd;
use clap::Parser;
use cli::{dump::DumpCmd, Command, Mode};
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

#[cfg(test)]
mod tests {
    use crate::cli::restore::RestoreCmd;
    use crate::cli::{dump::DumpCmd, CommonArgs, DbArgs, Dump};
    use crate::cli::{Command, Restore};
    use std::path::PathBuf;
    use std::process::Command as PCommand;
    use testcontainers_modules::testcontainers::RunnableImage;
    use testcontainers_modules::{postgres::Postgres, testcontainers::clients::Cli};

    fn run_command(command: &mut PCommand) {
        let output = command.output().expect("Command execution failed");
        if !output.status.success() {
            eprintln!("Command failed with output: {:?}", output);
        }
    }

    fn restore(host: &str, user: &str, port: &str, db: &str, file: &str) {
        let mut command = PCommand::new("psql");
        command
            .args(&["-p", port, "-h", host, "-U", user, "-d", db, "-f", file])
            .env("PGPASSWORD", "postgres");
        run_command(&mut command);
    }

    fn backup(host: &str, user: &str, port: &str, db: &str, file: &str) {
        let mut command = PCommand::new("pg_dump");
        command
            .args(&["-h", host, "-U", user, "-p", port, "-d", db, "-f", file])
            .env("PGPASSWORD", "postgres");
        run_command(&mut command);
    }

    #[tokio::test]
    async fn integration() {
        let tempdir = std::env::temp_dir();

        let host = "127.0.0.1";
        let username = "postgres";
        let password = "postgres";
        let db = "pagilla";

        let docker = Cli::default();
        let image = Postgres::default().with_db_name(db);
        let node = docker.run(RunnableImage::from(image).with_tag("15-alpine"));

        let port = node.get_host_port_ipv4(5432).to_string();

        restore(host, username, &port, db, "testdata/dump.sql");
        restore(host, username, &port, db, "testdata/dumpdata.sql");

        let dump_args = Dump {
            common: CommonArgs {
                concurrency: None,
                debug: false,
            },
            compress: false,
            config: Some(PathBuf::from("testdata/config.json")),
            db: DbArgs {
                db: db.to_owned(),
                host: host.to_owned(),
                password: password.to_owned(),
                username: username.to_owned(),
                port: port.parse().unwrap(),
            },
            name: None,
        };
        let dump_cmd = DumpCmd::new(dump_args);
        dump_cmd.run().await.expect("Error running dump command");

        let restore_args = Restore {
            yes: true,
            common: CommonArgs {
                concurrency: Some(4),
                debug: false,
            },
            db: DbArgs {
                db: db.to_owned(),
                host: host.to_owned(),
                password: password.to_owned(),
                username: username.to_owned(),
                port: port.parse().unwrap(),
            },
            dump_path: db.to_owned(),
        };
        let restore_cmd = RestoreCmd::new(restore_args);
        restore_cmd
            .run()
            .await
            .expect("Error running restore command");

        let backup_path = format!("{}/final.sql", tempdir.to_str().unwrap());

        backup(host, username, &port, db, &backup_path);

        let bytes = std::fs::read(&backup_path).unwrap();
        let hash = sha256::digest(bytes);
        assert_eq!(
            hash,
            "ec592d2ec02bea7521b6631111e51f17502263b2cf8c79aa9a1c1232f502cae7"
        );
    }
}
