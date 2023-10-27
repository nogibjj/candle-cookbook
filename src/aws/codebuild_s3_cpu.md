
# Automate cpu Binary Builds with AWS Codebuild
# 1. Setup AWS CodeBuild:
## Create a build project:
Navigate to the AWS CodeBuild dashboard.
Click on **"Create build project"**.

Fill in the project configuration details including the project name, source repository, and build environment.

Set up the source repository as candle repo from Github: https://github.com/huggingface/candle

## Configure build environment:

choose a Ubuntu environment.

Specify the buildspec file or insert build commands. 
Assumming you already have binary build and upload into s3. if not check this [steps](https://github.com/nogibjj/candle-cookbook/blob/600d52df5bd9d84bcf8d4cfb6f8b0f94173630de/src/aws/hello-aws.md#L79)

Buildspec: 

```
version: 0.2
phases:
  install:
    runtime-versions:
      rust: latest

  pre_build:
    commands:
    # install rust
      - curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
      - . "$HOME/.cargo/env"
      - rustc --version
      - cargo --version
      
  build:
    commands:
      # build the binary that you want, here we use Whisper as an example
      - cargo build --example whisper --release
      - cd target/release/examples
      - ls
      - chmod +x ./whisper
      # run the binary
      - ./whisper

      # upload your binary into your s3 bucket
      - aws s3 cp your-binary-name s3://your-s3-bucket-path --acl public-read
```
> Note that you need to replace your-binary-name to the binary you created, and your-s3-bucket-path as the place you will store your binary in the S3. 

## 2. Script Creation:
Create a script (e.g., install.sh) that performs the following actions:
* Downloads the binary from your S3 bucket.
```
# Define the URL to your binary
url="https://your-s3-bucket.s3.amazonaws.com/path-to-your-binary"

# Download the binary
curl -O $url
```

* Makes the binary executable.
```
chmod +x ./path-to-your-binary
```
> Feel free to modify the install.sh that you need to.


## 3. Host Script on S3:
Upload this script to your S3 bucket so it can be easily downloaded and run by your users.
```
aws s3 cp install.sh s3://your-bucket-path --acl public-read
```

## 4. One-Line Install Command:
```
curl -sSL https://your-s3-bucket.s3.amazonaws.com/install.sh | bash
```
> Note that you need to make your binary and your script as public readable in order to run the binary. 

After you download the binary, you can now run it in the local by the following code. (here use whisper as the example):
```
./whisper 

or if you want to try your own wave file

./whisper --input ./sample.wav
```
