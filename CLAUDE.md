# Claude Code — demo-claude-code-obsidian repo

Instructions for working on the *repo itself* (not for working inside an Obsidian vault — for that, see `vault-template/CLAUDE.md`).

## Repo overview

```text
demo-claude-code-obsidian/
├── README.md
├── CLAUDE.md                    ← this file (repo-level)
├── setup/
│   ├── cloud-setup.md
│   └── ollama-setup.md
├── example-vaults/
│   ├── personal-kb/             ← personal knowledge base demo
│   └── project-tracker/         ← project management demo
├── vault-template/              ← the drop-in template for any vault
│   ├── CLAUDE.md                ← THE main vault agent instructions
│   ├── .claude/
│   │   ├── commands/            ← slash commands (/new-note, /ask, etc.)
│   │   ├── skills/              ← daily workflow skills (/start-day, /prioritize-day, /close-day)
│   │   └── settings.json        ← pre-approved read/write permissions
│   └── templates/
└── docs/
    ├── commands-reference.md
    ├── provenance-system.md
    └── your-own-vault.md
```

## Key files

The most important file in this repo is **`vault-template/CLAUDE.md`** — it's the agent instructions that power everything. All vault-specific `CLAUDE.md` files are derived from or extend this one.

## When making changes

If you modify `vault-template/CLAUDE.md`, check whether the same change should be reflected in:

- `example-vaults/personal-kb/CLAUDE.md`
- `example-vaults/project-tracker/CLAUDE.md`

These are intentionally simplified versions of the template — don't add complexity to them, but do keep them consistent with the template's rules (especially the provenance system).

## Adding a new example vault

1. Create `example-vaults/<vault-name>/`
2. Add `.obsidian/app.json` (minimal config)
3. Write a `CLAUDE.md` that explains the vault's purpose and structure, then includes the standard commands section
4. Add sample notes that demonstrate the use case clearly
5. Add the vault to `README.md`'s example vault table

## Adding a new command

1. Document it in `docs/commands-reference.md`
2. Add the full workflow to `vault-template/CLAUDE.md` under the Commands section
3. Add a simplified version to both example vault `CLAUDE.md` files
4. Create `vault-template/.claude/commands/<command-name>.md` and copy it to both example vaults

## Adding a new skill

Skills are multi-step routines (like `/start-day`) that live in `.claude/skills/<skill-name>/SKILL.md`. Unlike slash commands, they contain the full workflow logic directly in the SKILL.md file rather than delegating to CLAUDE.md.

1. Document it in `docs/commands-reference.md`
2. Create `vault-template/.claude/skills/<skill-name>/SKILL.md` with a YAML frontmatter block (`name`, `description`) followed by the full workflow
3. If the skill interacts with daily notes, update `vault-template/templates/Daily Note.md` to include any required sections the skill depends on
4. The `prioritize-day` skill's "Close personal commitments" section is intentionally generic — note in the docs that users should customize it for their own vault
