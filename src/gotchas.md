## Gotchas & Build Issues

**[Stable Diffusion](https://github.com/huggingface/candle/tree/main/candle-examples/examples/stable-diffusion)**

Requires a GPU with more than 8GB of memory, as a fallback the CPU version can be used with the --cpu flag but is much slower. Alternatively, reducing the height and width with the --height and --width flag is likely to reduce memory usage significantly.

Note: --cpu flag not working