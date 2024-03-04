cargo build --target x86_64-apple-darwin
cargo build --target aarch64-apple-darwin
mkdir -p ./target/out
cp ./target/aarch64-apple-darwin/debug/pg-snap ./target/out/pg-snap-aarch64-apple-darwin
cp ./target/x86_64-apple-darwin/debug/pg-snap ./target/out/pg-snap-x86_64-apple-darwin