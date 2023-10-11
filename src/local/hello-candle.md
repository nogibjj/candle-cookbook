# Hello, Candle!

## Install Rust via [rustup](https://rustup.rs/)

```
# see https://rustup.rs/
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Set path
source "$HOME/.cargo/env"
```

## Configure [Candle](https://github.com/huggingface/candle)

```
git clone https://github.com/huggingface/candle.git
cd candle
```

## Build & Run Binaries

See all Candle example models [here](https://github.com/huggingface/candle/tree/main/candle-examples/examples)

*Example:*
```
# CPU build
cargo build --example falcon --release

# CUDA + cuDNN build
cargo build --example falcon --features cuda,cudnn --release

# Run binary
cd target/release/examples
./falcon --prompt "who invented the lightbulb"
```