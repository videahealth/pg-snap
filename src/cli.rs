use clap::Parser;

#[derive(Parser, Debug)]
pub struct CommonArgs {
    #[clap(short = 'H', long)]
    pub host: String,

    #[clap(short, long)]
    pub username: String,

    #[clap(short, long)]
    pub password: String,

    #[clap(short, long)]
    pub db: String,

    #[clap(short = 'D', long)]
    pub debug: bool,

    #[clap(short, long)]
    pub concurrency: Option<usize>,
}

#[derive(Parser, Debug)]
pub struct Dump {
    #[clap(flatten)]
    pub common: CommonArgs,

    #[clap(short, long)]
    pub skip_tables: Option<String>,
}

#[derive(Parser, Debug)]
pub struct Restore {
    #[clap(flatten)]
    pub common: CommonArgs,
}

#[derive(Parser, Debug)]
#[clap(
    author = "VideaHealth",
    version = "0.2.0",
    about = "Tool to dump and restore database snapshots"
)]
pub enum Mode {
    Dump(Dump),
    Restore(Restore),
}
