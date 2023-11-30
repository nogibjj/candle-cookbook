# Developer Workflows using the Candle CLI for AWS

The Candle CLI tool offers a simple interface to support Candle Cookbook development workflows seamlessly across AWS resources.

## Prerequisites

* Complete the [Hello, Candle! on AWS](./hello-aws.md) tutorial to setup your EC2 Instance, S3 Bucket and Candle-EC2 IAM User.
* Optional: Complete the [Jenkins + CodePipeline](./jenkins-pipeline.md) tutorial to setup automated EC2 and S3 builds
* A [Github Account](https://github.com/join)
* An [AWS Account](https://portal.aws.amazon.com/billing/signup)

## CLI Setup

1. Download [Candle CLI for AWS](https://github.com/athletedecoded/aws-candle/tree/main) by clicking the "Download Latest" README badge or the [latest release](https://github.com/athletedecoded/aws-candle/releases) source code.

2. Per the [AWS Candle CLI Setup Instructions](https://github.com/athletedecoded/aws-candle/tree/main#setup)
    * Create an AWS IAM User Policy "Candle-Cli" with `AmazonS3FullAccess` and `AmazonEC2FullAccess` permissions
    * Create an access key for your "Candle-Cli" user

3. Add a `.env` file and configure with AWS credentials and EC2 Key Pair

    ```
    # $touch .env
    AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY>
    AWS_SECRET_ACCESS_KEY=<YOUR_ACCESS_SECRET>
    AWS_DEFAULT_REGION=<YOUR_AWS_REGION>
    EC2_KEY=PATH/TO/EC2_KEY_PAIR.pem
    ```

## Using the Candle CLI to connect to your EC2 Instance

```
# List your EC2 instances
$ cargo run list --ec2

# Connect to EC2
$ cargo run instance --id <INSTANCE_ID> --action start
$ cargo run connect --id <INSTANCE_ID>

# Check AWS CLI is installed on your EC2
ubuntu@ip$ aws --version

# If not: install AWS CLI
ubuntu@ip$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
ubuntu@ip$ unzip awscliv2.zip
ubuntu@ip$ sudo ./aws/install
ubuntu@ip$ rm -r awscliv2.zip

# Confirm install
ubuntu@ip$ aws --version
```

## Sample Workflows

* [Run Prebuilt Binaries on EC2](#run-prebuilt-binaries-on-ec2)
* [Build Binaries on EC2 + S3 Storage](#build-binaries-on-ec2--s3-storage)
* [Move Jenkins + Codepipeline binaries to EC2](#move-jenkins--codepipeline-binaries-to-ec2)

### Run Prebuilt Binaries on EC2

See available prebuilt binaries [here](https://github.com/athletedecoded/cookbook-binaries/tree/main/binaries)

⚠️ IMPORTANT: Ensure you choose binaries compatible with your EC2 instance architecture

```
# Connect to EC2
$ cargo run instance --id <INSTANCE_ID> --action start
$ cargo run connect --id <INSTANCE_ID>

# Download binary
ubuntu@ip$ wget -O mistral-cudnn https://github.com/athletedecoded/cookbook-binaries/raw/main/binaries/cudnn/mistral?download=

# Set EC2 execution permissions
ubuntu@ip$ chmod +x mistral-cudnn

# Run binary
ubuntu@ip$ ./mistral-cudnn --prompt "who invented the lightbulb"

# Close SSH tunnel
ubuntu@ip$ exit

# Stop your EC2 instance to avoid charges
$ cargo run instance --id <INSTANCE_ID> --action stop
```

### Build Binaries on EC2 + S3 Storage

See available Candle models [here](https://github.com/huggingface/candle/tree/main/candle-examples/examples)

```
# List your EC2 instances
$ cargo run list --ec2

# Connect to EC2
$ cargo run instance --id <INSTANCE_ID> --action start
$ cargo run connect --id <INSTANCE_ID>

# If Candle repo is not on your EC2
ubuntu@ip$ git clone https://github.com/huggingface/candle.git

# Fetch latest candle repo
ubuntu@ip$ cd candle
ubuntu@ip$ git fetch upstream main

# For CPU build (ex. quantized model)
ubuntu@ip$ cargo build --example quantized --release

# For CUDA + cuDNN build (ex. falcon model)
ubuntu@ip$ cargo build --example falcon --features cuda,cudnn --release

# Run models on EC2
ubuntu@ip$ cd target/release/examples
ubuntu@ip$ ./falcon --prompt "who invented the lightbulb"

# Store models in existing S3 bucket "my-candle-binaries"
ubuntu@ip$ aws s3 cp quantized s3://my-candle-binaries

# Exit the SSH
ubuntu@ip$ exit

# Download binaries to run locally (assumes compatible local architecture)
$ cargo run bucket --name my-candle-binaries --action list
$ cargo run object --bucket my-candle-binaries --key falcon --action get
$ ./falcon --prompt "who invented the lightbulb"

# Stop your instance
$ cargo run instance --id <INSTANCE_ID> --action stop
```

### Move Jenkins + Codepipeline binaries to EC2

Complete the [Jenkins + CodePipeline](./jenkins-pipeline.md) tutorial to setup automated EC2 and S3 builds

```
# List your S3 buckets, EC2 instances
$ cargo run list --s3 --ec2

# List S3 build artifacts
$ cargo run bucket --name candle-cpu --action list
# Will look something like candle-cpu/BuildArtif/7pKxpR0

# Connect to EC2
$ cargo run instance --id <INSTANCE_ID> --action start
$ cargo run connect --id <INSTANCE_ID>

# Copy S3 artifact bucket to EC2
# Note: it is recommended to only have the latest build artifact in the bucket
ubuntu@ip$ aws s3 sync s3://candle-cpu .

# Unzip 
ubuntu@ip$ mkdir my-binaries
ubuntu@ip$ unzip candle-cpu/BuildArtif/7pKxpR0 ./my-binaries

# Remove S3 tarball
ubuntu@ip$ rm -r candle-cpu

# Run models
ubuntu@ip$ cd my-binaries
ubuntu@ip$ ./falcon --prompt "who invented the lightbulb"

# Exit the SSH
ubuntu@ip$ exit

# Stop your instance
$ cargo run instance --id <INSTANCE_ID> --action stop
```