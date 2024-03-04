use std::io;

use rand::{distributions::Alphanumeric, thread_rng, Rng};

pub mod csv;
use std::io::Write;

pub fn ask_for_confirmation(prompt: &str) {
    print!("{} (y/n): ", prompt);
    io::stdout().flush().unwrap();

    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();
    let confirmation = input.trim().to_lowercase();

    match confirmation.as_str() {
        "y" | "yes" => {}
        "n" | "no" => {
            std::process::exit(1);
        }
        _ => {
            println!("Invalid input. Please enter 'y' for yes or 'n' for no.");
            ask_for_confirmation(prompt);
        }
    }
}

pub fn rnd_string() -> String {
    thread_rng()
        .sample_iter(&Alphanumeric)
        .take(10)
        .map(|x| x as char)
        .collect()
}
