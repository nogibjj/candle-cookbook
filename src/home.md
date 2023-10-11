# Candle Cookbook

## 🚀 The Mission:

Democratize access to state of the art AI models.


## 🌏 The Principles: 

🫱🏾‍🫲🏼 **Trust** ~ ethically sourced data and end-to-end transparency.

🔒 **Privacy** ~ secure, on-device inference without data sharing.

🌱 **Sustainability** ~ optimize efficiency to minimize our carbon footprint.


## 🍳 The Recipes:

* [Local Builds](#local-builds)
* [AWS Builds](#aws-builds)
* [Azure Builds](#azure-builds)

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

***Disclaimer***: 

*AWS/Azure builds may incur charges. It is your responsibility to understand the associated resource costs and useage rates. We are not liable for any charges incurred from the utilization of these services.* 


## 🕯️Official Candle Docs

* [Huggingface Candle repo](https://github.com/huggingface/candle)
* [Candle User Guide](https://huggingface.github.io/candle/guide/installation.html)