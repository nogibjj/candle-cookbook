# Hello, Candle on AWS!

## Launch GPU Enabled AWS EC2 Compute Instance

1. Open the AWS EC2 Console
2. Configure a Ubuntu 20.04 Deep Learning Base GPU AMI image + G5.##xlarge instance type (see [here](https://aws.amazon.com/ec2/instance-types/g5/) for charges and instance capcity) 
3. Create new key pair and save .pem file
4. Allow SSH traffic
5. Launch Instance
6. From EC2 landing page >> Start Instance

*Gotchas*
* You may need to request capacity increase from AWS to handle larger G5.##xlarge instances
* Move .pem file from downloads to ~/.ssh using `mv ~/Downloads/candle-key.pem ~/.ssh`

## Connect to EC2 via SSH

1. Install [Remote - SSH](https://code.visualstudio.com/docs/remote/ssh) from VSCode Extensions
2. Add new SSH Connection
3. From EC2 landing page >> Connect >> SSH client >> Copy command to VSCode
  ```
  ssh -i "candle-key.pem" ubuntu@ec2-##-##.us-east-21.compute.amazonaws.com
  ```
4. Update .config file and validate format as follows

  ```
  Host ec2-##-###.us-east-1.compute.amazonaws.com
    HostName ec2-##-###.us-east-1.compute.amazonaws.com
    IdentityFile ~/.ssh/candle-key.pem
    User ubuntu
  ```
5. Confirm instance type (Linux) and fingerprint (Yes) 
6. Launch terminal on remote host

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

## Install AWS CLI

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Check install
aws --version
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

## Store Binaries in S3

1. Create IAM User "Candle-EC2" with `S3FullAccess` policy >> Create access key
2. From SSH terminal `aws configure` >> Add Candle-EC2 keys
3. Create S3 Bucket i.e `my-candle-binaries`
4. Copy model binary to S3 

```
cd target/release/examples
aws s3 cp quantized s3://my-candle-binaries
```
