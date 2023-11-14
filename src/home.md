# Candle Cookbook

## 🚀 The Mission:

Democratize access to state of the art AI models.

## 🌏 The Principles: 

🫱🏾‍🫲🏼 **Trust** ~ ethically sourced data and end-to-end transparency.

🔒 **Privacy** ~ secure, on-device inference without data sharing.

🌱 **Sustainability** ~ optimize efficiency to minimize our carbon footprint.

## 🕯️ Start Here

Welcome! Get familiar with Candle Cookbook by going through some of our favourite introductory tutorials

* [Hello, Candle!](./local/hello-candle.md)
* [Hello, Candle on AWS!](./aws/hello-aws.md)
* [Hello, Candle on Azure!](./azure/hello-azure.md)

We also recommend getting familiar with the Official Candle framework and User Guide

* [Huggingface Candle repo](https://github.com/huggingface/candle)
* [Candle User Guide](https://huggingface.github.io/candle/index.html)

## 🌱 Contributing

We welcome contributions from anyone who aligns with Our Mission and Our Principles.

To get started as a contributor:

* Read our [Code of Conduct](../CODE_OF_CONDUCT.md)
* Read the [Contributor Guidelines](../CONTRIBUTING.md)
* Install Candle Cookbook according to the [Developer Setup](../docs/DEV_ENV.md) guide

## 🍳 The Recipes:

* [Local Builds](./local/index.md)
* [AWS Builds](./aws/index.md)
* [Azure Builds](./azure/index.md)

**Minimum requirements for GPU targetted binaries**

For CUDA enabled builds using `--features cuda`:
* NVIDIA GPU with [CUDA compute capabilitity](https://developer.nvidia.com/cuda-gpus) > X.X
* [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads) >= X.X

For cuDNN optimized builds using `--features cuda, cudnn`:
* NVIDIA GPU with [CUDA compute capabilitity](https://developer.nvidia.com/cuda-gpus) > X.X
* [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads) >= X.X
* [cuDNN](https://developer.nvidia.com/cudnn) >= X.X

Verify CUDA/cuDNN:
```
# Verify CUDA
nvidia-smi --query-gpu=compute_cap --format=csv
nvcc --version

# Verify cuDNN
whereis cudnn.h
```

**⚠️ IMPORTANT:** 

AWS/Azure builds may incur charges. It is your responsibility to understand the associated resource costs. Please review the useage rates accordingly, as we are not liable for any charges incurred from the utilization of these platforms/services. 

## 🛣️Roadmap

Our goal is to document each stage of a fully transparent LLM development cycle

- [ ] Publish MVP Candle Cookbook
- [ ] Ethically source and construct an openly available LLM dataset
- [ ] Build a Candle-based LLM from scratch
- [ ] Customize LLM with finetuning
- [ ] CI/CD deployment of LLM

## 🧑‍🍳 Our Team: 

Get to know our [Community Leaders](https://github.com/nogibjj/candle-cookbook/blob/main/TEAM.md)

