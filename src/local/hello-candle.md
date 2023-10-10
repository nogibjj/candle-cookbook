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

See available example models and docs [here](https://github.com/huggingface/candle/tree/main/candle-examples/examples)

```
# Build for CPU
cargo build --example <model_name> --release
eg. cargo build --example falcon --release

# Build for CUDA + cuDNN
cargo build --features cuda,cudnn --example <model_name> --release
eg. cargo build --features cuda,cudnn --example falcon --release

# Run
cd target/release/examples
./<model_name> --prompt <your_prompt>
eg ./falcon --prompt "who invented the lightbulb"
```