# Hello, Candle on EC2!

## Launch GPU Enabled AWS EC2 Compute Instance

1. Open the AWS EC2 Console
2. Configure a Ubuntu 20.04 Deep Learning Base GPU AMI image + G5.##xlarge instance type (see [here](https://aws.amazon.com/ec2/instance-types/g5/) for charges and instance capcity) 
3. Create new key pair and save .pem file
4. Allow SSH traffic
5. Launch Instance
6. From EC2 landing page >> Start Instance >> Connect >> SSH client

*Gotchas*
* You may need to request capacity increase from AWS to handle larger G5.##xlarge instances
* Move .pem file from downloads to ~/.ssh using `mv ~/Downloads/candle-key.pem ~/.ssh`

## Connect to EC2 via SSH

1. Install [Remote - SSH](https://code.visualstudio.com/docs/remote/ssh) from VSCode Extensions
2. Add new SSH Connection
3. Copy AWS command i.e. `ssh -i "candle-key.pem" ubuntu@ec2-##-###-###-##.us-east-2.compute.amazonaws.com`
4. Update .config file and validate format as follows

```
Host ec2-##-###-###-##.us-east-2.compute.amazonaws.com
  HostName ec2-##-###-###-##.us-east-2.compute.amazonaws.com
  IdentityFile ~/.ssh/candle-key.pem
  User ubuntu
```

## Verify EC2 CUDA/cuDNN

```
nvidia-smi --query-gpu=compute_cap --format=csv
nvcc --version

whereis cudnn.h
```

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
eg. ./falcon --prompt "who invented the lightbulb"
```