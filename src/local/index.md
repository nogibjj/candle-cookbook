
# Local Builds

## Requirements

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

## Recipes

**Getting Started**

- [Hello, Candle!](./hello-candle.md) ~ start here