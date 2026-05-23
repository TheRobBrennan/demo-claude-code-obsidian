# Machine Learning Notes

Running notes on ML fundamentals and current landscape. Not a comprehensive reference — just things I want to remember.

## The three types of learning

**Supervised learning** — you provide labeled examples (input → correct output), the model learns to predict the label. Classification and regression. Most of what "machine learning" meant until ~2017.

**Unsupervised learning** — no labels. The model finds structure in the data itself. Clustering, dimensionality reduction, generative models.

**Reinforcement learning** — an agent takes actions in an environment and receives rewards. It learns to maximize cumulative reward. This is how game-playing AIs (chess, Go, Atari) and current LLM alignment techniques (RLHF) work.

## What a neural network actually is

A function with a lot of parameters (weights). Training adjusts the weights so the function's outputs get closer to the desired outputs. "Deep" just means many layers of composed functions.

The key operations: matrix multiplication (combining inputs linearly) and activation functions (adding nonlinearity). Without nonlinearity, many layers collapse into one — you just get a linear model.

## Transformers

The architecture behind essentially all current large language models. Key innovation: **attention**, a mechanism that lets the model weigh how relevant each part of the input is to each other part, rather than processing inputs sequentially.

This is why transformers handle long contexts better than earlier RNN architectures — they don't need to compress all prior context into a fixed-size state.

## Why scale matters so much

The empirical finding that turned ML on its head in the early 2020s: model capability on many tasks scales predictably with model size, dataset size, and compute. Bigger models trained on more data just keep getting better, often at tasks they weren't explicitly trained for.

This doesn't mean scale is everything — but it means that a lot of capability that seemed to require clever architectural tricks turned out to just require more data and compute.

## Fine-tuning vs. prompting

A pre-trained model has general knowledge. To specialize it:

- **Fine-tuning** — continue training on domain-specific examples (requires data and compute, but changes the model's weights)
- **Prompting** — give the model instructions and examples at inference time (no training required, but the model's underlying capabilities don't change)
- **RAG (retrieval-augmented generation)** — give the model access to a knowledge base it can query at inference time. Useful when you have more knowledge than fits in the context window, or when knowledge changes frequently.

## Local models

Models like Llama 3, Qwen, Mistral, and Gemma can run on consumer hardware. Quality gap vs. frontier models (GPT-4o, Claude 3.x) is significant for complex reasoning but small for many everyday tasks.

Key variables: model size (number of parameters), quantization (how precisely weights are represented), and context length. Running locally means data stays on your machine.
