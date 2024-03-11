use std::{fs, io::ErrorKind, path::PathBuf, process::Command};

use crate::cli::DbParams;
use anyhow::{Context, Result};

pub enum PgCommandStr {
    PgDump,
    Psql,
}

impl PgCommandStr {
    fn as_str(&self) -> &'static str {
        match self {
            PgCommandStr::PgDump => "pg_dump",
            PgCommandStr::Psql => "psql",
        }
    }
}

pub struct PgCommand<'a> {
    pub params: &'a DbParams,
}

impl<'a> PgCommand<'a> {
    pub fn new(params: &'a DbParams) -> Self {
        Self { params }
    }

    pub fn dump(&self, path: &PathBuf) -> Result<()> {
        let mut dump_flags = self.get_dump_command_flags();
        let pw = self.params.password.clone();
        dump_flags.push("--schema-only".to_owned());

        let mut cmd = Command::new(PgCommandStr::PgDump.as_str());
        let output = cmd.args(&dump_flags).env("PGPASSWORD", pw);

        let result = execute_command(PgCommandStr::PgDump, output)?;

        fs::write(path, result).expect("Unable to write file");

        Ok(())
    }

    pub fn restore(&self, path: &str) -> Result<()> {
        let restore_flags = self.get_psql_command_flags(path);
        let pw = self.params.password.clone();

        let mut cmd = Command::new(PgCommandStr::Psql.as_str());
        let output = cmd.args(&restore_flags).env("PGPASSWORD", pw);

        let _ = execute_command(PgCommandStr::Psql, output)?;

        Ok(())
    }

    fn get_dump_command_flags(&self) -> Vec<String> {
        let mut options = Vec::new();
        options.push(format!("--dbname={}", self.params.db));
        options.push(format!("--host={}", self.params.host));
        options.push(format!("--port={}", self.params.port));
        options.push(format!("--username={}", self.params.username));
        options
    }

    fn get_psql_command_flags(&self, full_path: &str) -> Vec<String> {
        let mut options = Vec::new();
        options.push("-U".to_owned());
        options.push(self.params.username.clone());

        options.push("-h".to_owned());
        options.push(self.params.host.clone());

        options.push("-d".to_owned());
        options.push(self.params.db.clone());

        options.push("-f".to_owned());
        options.push(full_path.to_owned());
        options.push("-p".to_owned());
        options.push(self.params.port.to_string());

        options
    }
}

pub fn execute_command(command_name: PgCommandStr, command: &mut Command) -> Result<String> {
    let output = match command.output() {
        Ok(output) => output,
        Err(e) => {
            if e.kind() == ErrorKind::NotFound {
                return Err(anyhow::anyhow!(
                    "{} command not found in system PATH",
                    command_name.as_str()
                ));
            } else {
                return Err(anyhow::anyhow!(
                    "Failed to execute {} command",
                    command_name.as_str()
                ));
            }
        }
    };

    if !output.status.success() {
        return Err(anyhow::anyhow!(
            "Error executing {}: {}",
            command_name.as_str(),
            String::from_utf8_lossy(&output.stderr)
        ));
    }

    String::from_utf8(output.stdout).context(format!(
        "Error reading stdout from {} command",
        command_name.as_str()
    ))
}
