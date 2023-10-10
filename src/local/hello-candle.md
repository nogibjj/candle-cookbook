# Hello, Candle!

## Install Rust

See [rustup](https://rustup.rs/)

```
# Install
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
./falcon --prompt "who invented the lightbulb"
```

## Gotchas

**[Stable Diffusion](https://github.com/huggingface/candle/tree/main/candle-examples/examples/stable-diffusion)**

Requires a GPU with more than 8GB of memory, as a fallback the CPU version can be used with the --cpu flag but is much slower. Alternatively, reducing the height and width with the --height and --width flag is likely to reduce memory usage significantly.

```
# Build for CPU **NOT RECOMMENDED**
cargo build --cpu --example stable-diffusion --release
```
