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
#[clap(author = "Your Name", version = "1.0", about = "Database utility")]
pub enum Mode {
    Dump(Dump),
    Restore(Restore),
}
