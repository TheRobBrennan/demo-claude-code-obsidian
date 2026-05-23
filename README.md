# Claude Code × Obsidian

Use Claude Code as an AI agent inside your Obsidian vault — generating notes, finding connections, building Maps of Content, managing projects, and keeping your graph honest. Works with **Anthropic cloud models** (Claude Sonnet, Opus) or **locally-hosted models via Ollama** (no API key, no data leaving your machine).

---

## What this does

You open your vault directory in a terminal, run `claude`, and talk to your vault in plain English. Claude Code reads and writes markdown files directly — no plugin required, no sync issues, no middleman.

```bash
cd ~/vaults/my-vault
claude
```

Then try things like:

```bash
/new-project Acme Corp
/find-connections "Building a Second Brain"
/daily-review
/ask what themes keep coming up in my meeting notes?
/build-moc Projects/Acme Corp
```

Every note Claude creates is **clearly marked as AI-generated** and lands in a staging folder (`_claude/`) so your vault stays clean. You decide what to keep, move, or delete.

---

## Quick start

### 1. Install Obsidian

Download from [obsidian.md](https://obsidian.md). It's free. You don't need an account.

### 2. Set up Claude Code

**Option A — Anthropic cloud (Claude Sonnet/Opus):**

```bash
npm install -g @anthropic-ai/claude-code
```

You'll need an [Anthropic API key](https://console.anthropic.com). See [setup/cloud-setup.md](setup/cloud-setup.md).

**Option B — Local models via Ollama (free, offline):**

```bash
# Install Ollama from https://ollama.com, then:
ollama -v
# ollama version is 0.24.0

# Pull the appropriate model from Ollama
ollama pull qwen3.5:9b

# Launch Claude with the model
ollama launch claude --model qwen3.5:9b
```

No API key needed. See [setup/ollama-setup.md](setup/ollama-setup.md) for model recommendations.

### 3. Try an example vault

```bash
# Open one of the example vaults in Obsidian first, then:
cd example-vaults/personal-kb
ollama launch claude --model qwen3.5:9b # or claude to use the Anthropic cloud models

# Or the project management vault:
cd example-vaults/project-tracker
ollama launch claude --model qwen3.5:9b # or claude to use the Anthropic cloud models
```

**With telemetry** (captures token throughput, latency, GPU usage via OpenTelemetry):

```bash
npm run telemetry:setup                  # first time only — copies .env.example → .env
npm run telemetry:launch                 # launches personal-kb with qwen3.5:9b
npm run telemetry:launch:project-tracker # or the project-tracker vault
```

Requires the telemetry stack from [how-to-setup-local-ollama-with-claude-code](https://github.com/TheRobBrennan/how-to-setup-local-ollama-with-claude-code) to be running. See [setup/ollama-setup.md](setup/ollama-setup.md) for details.

The example vaults have sample notes and a pre-configured `CLAUDE.md` so Claude knows the vault's structure immediately.

### 4. Add to your own vault

Copy `vault-template/CLAUDE.md` into the root of any existing Obsidian vault:

```bash
cp vault-template/CLAUDE.md ~/vaults/my-vault/CLAUDE.md
cp -r vault-template/templates ~/vaults/my-vault/templates
cp -r vault-template/_claude ~/vaults/my-vault/_claude
```

Then `cd ~/vaults/my-vault && claude`.

---

## Example vaults

| Vault | Best for |
| :--- | :--- |
| [`personal-kb/`](example-vaults/personal-kb/) | Note-taking, reading notes, idea capture — demos summarize, tag, link |
| [`project-tracker/`](example-vaults/project-tracker/) | Client/project management — demos project creation, MOC generation, daily review |

---

## All available commands

See [docs/commands-reference.md](docs/commands-reference.md) for the full list with examples.

| Command | What it does |
| :--- | :--- |
| `/new-project <name>` | Creates a complete project folder with MOC, meeting log, notes area |
| `/new-note <title>` | Creates a note from a template, staged in `_claude/` for your review |
| `/summarize` | Summarizes a note, folder, or the whole vault |
| `/find-connections <note>` | Suggests `[[wikilinks]]` for a note based on vault content |
| `/generate-tags` | Suggests or writes tags for untagged notes |
| `/build-moc <folder>` | Generates a Map of Content for a folder |
| `/ask <question>` | Answers a question using your vault as context |
| `/daily-review` | Morning briefing from your recent notes and open tasks |
| `/review-generated` | Lists all pending AI-generated notes for your review |
| `/update-project <name>` | Syncs a project's MOC with the current state of its files |

---

## How AI-generated notes are tracked

Claude never silently edits your notes. See [docs/provenance-system.md](docs/provenance-system.md) for the full system, but the short version:

- AI-created notes land in `_claude/` subfolders, never in your main note tree
- Every AI note has frontmatter: `claude_generated: true`, `claude_status: draft`, `claude_command: /command-used`
- To keep a note: move it out of `_claude/`. That's it.
- Claude will never edit a file unless it has `claude_generated: true` in its frontmatter, or you explicitly say "edit [filename]"

---

## Repo structure

```text
demo-claude-code-obsidian/
├── README.md
├── CLAUDE.md                    ← repo-level instructions for working on this repo itself
├── setup/
│   ├── cloud-setup.md           ← Anthropic API key setup
│   └── ollama-setup.md          ← Ollama local model setup + recommendations
├── example-vaults/
│   ├── personal-kb/             ← personal knowledge base demo vault
│   └── project-tracker/         ← project/client management demo vault
├── vault-template/              ← drop this into any existing vault
│   ├── CLAUDE.md
│   ├── _claude/
│   └── templates/
└── docs/
    ├── commands-reference.md
    ├── provenance-system.md
    └── your-own-vault.md
```

---

## Related projects

This builds on [how-to-setup-local-ollama-with-claude-code](https://github.com/yourusername/how-to-setup-local-ollama-with-claude-code) — if you haven't set up local models yet, start there.
