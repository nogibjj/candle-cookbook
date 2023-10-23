# Automate Binary Builds with Jenkins + CodePipeline

## Prerequisites

* Complete the [Hello, Candle! on AWS](./hello-aws.md) tutorial to setup your EC2 Instance, S3 Bucket and Candle-EC2 IAM User.
* A [Github Account](https://github.com/join)
* An [AWS Account](https://portal.aws.amazon.com/billing/signup)

## Add Permissions to Candle-EC2 IAM Role

1. From AWS IAM Console >> Users >> Candle-EC2 >> Add permissions >> Attach existing policies directly
2. Add `AWSCodePipelineCustomActionAccess` policy >> Save changes

## Integrate Jenkins with CodePipeline

**Add Security Group to EC2**

1. From EC2 landing page >> Network & Security >> Security Groups 
2. Create Security Group >> Name: "WebConnectEC2" >> Description: "Allow SSH and HTTP traffic to EC2"
3. Add the following inbound rules. NB: Source = "Anywhere" is not recommended for production environments.

![image](../assets/aws/jenkins-pipeline/aws-ec2-security-group.png)  

4. Click EC2 instance >> Actions >> Networking >> Change Security Groups >> Select "WebConnectEC2" >> Save

**Install Jenkins on EC2**

```
# Get Jenkins files
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt-get update \
  &&
sudo apt-get install jenkins

# Check install
jenkins --version

# Allow Jenkins service to start at boot
sudo systemctl enable jenkins

# Launch Jenkins
sudo systemctl start jenkins
```

**Create Jenkins Admin/Login to Jenkins**

1. Click EC2 instance >> Details >> Copy EC2 Public IPv4 DNS
2. From browser navigate to http://<EC2_public_ipv4_address>:8080/
3. From EC2 SSH terminal >> `sudo cat /var/lib/jenkins/secrets/initialAdminPassword` >> Copy password
4. Paste password into Jenkins >> Continue >> Install suggested plugins
5. Create admin user (suggested username: admin) >> Save and Continue
6. Instance Configuration >> Not Now


*Gotchas*

To clean install Jenkins
```
sudo apt-get remove --purge jenkins
rm -rf /var/lib/jenkins
```

**Create Jenkins Build Project**
1. From Jenkins dashboard >> New Item >> Enter item name: "CandlePipeline" >> Select "Freestyle project" >> OK
2. General >> Check "Execute concurrent builds if necessary"
3. Source Code Management >> Check AWS CodePipeline
4. From AWS IAM >> Users >> Candle-EC2 >> create second access key "Jenkins" >> Add to Jenkins Build AWS Config
5. Category >> Build
6. Provider: Jenkins
7. Build Triggers >> Check "Poll SCM" >> Schedule: * * * * *
8. Build Steps >> Add build step >> Execute shell >> Add command:
  ```
  ls
  export PATH=/usr/local/cuda-11.8/bin:$PATH
  export PATH=/home/ubuntu/.cargo/bin:$PATH
  . "/home/ubuntu/.cargo/env"
  rustc --version
  cargo --version
  nvcc --version
  whereis cudnn.h
  nvidia-smi
  cargo build --example quantized --features cuda,cudnn --release
  cargo build --example falcon --features cuda,cudnn --release
  ```
9. Post-build Actions >> Add post-build action >> AWS CodePipeline Publisher
10. Output location >> Add >> Artifact Location: /target/release/examples >> Artifact Name: BuildArtifact

**Create CodePipeline Project**
1. AWS CodePipeline Console >> Create pipeline >> Pipeline name: "CandlePipeline" >> Check "New service role"
2. Advanced Settings >> Custom location >> Bucket: "my-candle-binaries" >> Default AWS Managed Key >> Next
3. Source provider >> Github (Version 2) >> Follow instructions to create Github Connection
4. Uncheck "Start the pipeline on source code change"
5. Repository name: huggingface/candle >> Branch Name: main >> Output artifact format:CodePipeline Default >> Next
6. Build Provider >> Add Jenkins
7. Provider Name: Jenkins **NB: Must match Jenkins Build Project!**
8. Server URL: http://<EC2_public_ipv4_address>:8080/
9. Project Name: CandlePipeline **NB: Must match Jenkins Build Project!** >> Next
10. Skip deploy stage >> Skip
11. Review >> Create pipeline
12. The first build will run automatically. Subsequent builds can be triggered using "Release change" button.

## Download Binaries

1. AWS S3 Console >> my-candle-binaries >> CandlePipeline/ >> BuildArtif/
2. Order by "Last modified" >> Download latest zip

**⚠️ IMPORTANT: Terminate any AWS resources to prevent unexpected charges.** 

## References
* [Install Jenkins to EC2](https://www.jenkins.io/doc/book/installing/linux/#debianubuntu)
* [Jenkins on EC2](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/#installing-and-configuring-jenkins)
* [Jenkins + AWS Codepipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials-four-stage-pipeline.html#tutorials-four-stage-pipeline-prerequisites-jenkins-iam-role/)