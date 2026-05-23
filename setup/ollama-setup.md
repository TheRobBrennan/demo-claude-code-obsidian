# Local setup — Ollama

Run Claude Code with a locally-hosted model. No API key, no data leaving your machine, no per-token costs. Works offline.

## Requirements

- macOS (Apple Silicon recommended), Linux, or Windows
- Enough RAM for your chosen model (see model table below)
- Claude Code installed: `npm install -g @anthropic-ai/claude-code`

## 1. Install Ollama

Download from [ollama.com](https://ollama.com) and install. On macOS, Ollama runs as a menu bar app.

Verify it's running:

```bash
ollama --version
```

## 2. Sign in to Ollama (for cloud-hosted models)

If you want to use models served by Ollama's cloud (no local GPU required):

```bash
ollama signin
```

This opens a browser. Confirm the connection on ollama.com. You'll need an Ollama account (free tier available).

You can skip this step if you're pulling models locally.

## 3. Pull a model

### Running locally (needs RAM, no internet after download)

```bash
# Recommended for most machines with 16GB+ RAM
ollama pull qwen3-coder

# Good alternative — strong tool-calling
ollama pull devstral

# Lightweight — faster, less capable
ollama pull qwen3:8b
```

### Running via Ollama cloud (no GPU required, needs internet)

```bash
# These run on Ollama's servers — no RAM requirement on your machine
ollama pull kimi-k2.6:cloud
ollama pull qwen3-coder:cloud
```

## 4. Launch Claude Code with your model

```bash
ollama launch claude --model qwen3-coder
```

That's it. `ollama launch` sets all the necessary environment variables and starts Claude Code pointed at your local model.

### Manual setup (if `ollama launch` isn't available)

```bash
export ANTHROPIC_BASE_URL=http://localhost:11434
export ANTHROPIC_AUTH_TOKEN=ollama
claude --model qwen3-coder
```

## Model recommendations

Based on community benchmarks for Claude Code specifically (tool-calling, multi-file reasoning, instruction following):

| Model | RAM needed | Speed | Tool calling | Best for |
| :--- | :--- | :--- | :--- | :--- |
| **GLM-4.7-Flash** | ~8GB | Fast | ★★★★★ | Best local tool-calling, fast responses |
| **Qwen3-Coder** | ~14GB | Medium | ★★★★☆ | Best for large vaults, 256K context |
| **Devstral Small** | ~16GB | Medium | ★★★★☆ | Complex multi-file tasks |
| **Qwen3:8b** | ~6GB | Fast | ★★★☆☆ | Lighter machines, simpler tasks |
| **kimi-k2.6:cloud** | 0 (cloud) | Fast | ★★★★☆ | No local GPU, needs internet |

For Obsidian vault work specifically: **GLM-4.7-Flash** for speed, **Qwen3-Coder** if your vault is large (the 256K context window matters when reading many notes at once).

See [Ollama's model library](https://ollama.com/library) for the full list.

## Multiple sessions

You can run multiple Claude Code terminals against the same Ollama model. Ollama queues requests by default (`OLLAMA_NUM_PARALLEL=1`). To allow true parallelism:

```bash
OLLAMA_NUM_PARALLEL=2 ollama serve
```

On a 64GB machine, 2 parallel sessions with Qwen3-Coder is comfortable. Watch your RAM usage.

## Troubleshooting

**"Not logged in" error with cloud models:**
Run `ollama signin` (not `/login` inside Claude Code — that's for Anthropic accounts).

**Model is slow:**
Check that Ollama is using your GPU: `ollama ps` should show the model with a layer count. If layers show 0, it's running on CPU — you may need to reduce model size.

**Context window errors:**
Some models have shorter context windows than Claude. If you're reading large vaults, use Qwen3-Coder (256K) or break your commands into smaller scope (`folder:notes` instead of `vault`).

**"Connection refused":**
Make sure Ollama is running: open the Ollama app, or run `ollama serve` in a terminal.
