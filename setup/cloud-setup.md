# Cloud setup — Anthropic API

Use this if you want to run Claude Code with Sonnet or Opus. You'll need an Anthropic account and an API key.

## 1. Get an API key

1. Go to [console.anthropic.com](https://console.anthropic.com)
2. Create an account or sign in
3. Navigate to **API Keys** and create a new key
4. Copy the key — you won't be able to see it again

## 2. Install Claude Code

```bash
npm install -g @anthropic-ai/claude-code
```

Requires Node.js 18+. Check with `node --version`.

## 3. Set your API key

```bash
export ANTHROPIC_API_KEY=sk-ant-...
```

Add this to your shell profile (`~/.zshrc`, `~/.bashrc`) to avoid setting it every session:

```bash
echo 'export ANTHROPIC_API_KEY=sk-ant-...' >> ~/.zshrc
source ~/.zshrc
```

## 4. Try it

```bash
cd example-vaults/personal-kb
claude
```

## Costs

Claude Code uses the Anthropic API. Costs depend on usage:

| Model | Approximate cost |
| :--- | :--- |
| Claude Sonnet 4.5 | ~$3 / million input tokens |
| Claude Opus 4.6 | ~$15 / million input tokens |

For vault work (reading notes, writing summaries), typical sessions run a few thousand tokens. The personal-kb example vault is roughly 5,000 words total — reading the whole thing costs less than $0.02 on Sonnet.

Check [anthropic.com/pricing](https://anthropic.com/pricing) for current rates.

## Choosing a model

For most vault work, **Sonnet** is the right choice — it's fast, capable, and significantly cheaper than Opus. Use Opus for complex synthesis tasks or when answer quality really matters.

To specify a model:

```bash
claude --model claude-sonnet-4-5
```

Or set a default in your Claude Code config.
