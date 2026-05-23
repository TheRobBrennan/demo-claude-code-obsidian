# Using Claude Code with your own vault

If you already have an Obsidian vault, adding Claude Code is a one-step process: drop in a `CLAUDE.md` and you're ready.

## The short version

```bash
# Copy the template into your vault root
cp vault-template/CLAUDE.md ~/path/to/your-vault/CLAUDE.md

# Optional but recommended: copy the staging folder and templates
cp -r vault-template/_claude ~/path/to/your-vault/_claude
cp -r vault-template/templates ~/path/to/your-vault/templates

# Start Claude Code
cd ~/path/to/your-vault
claude
```

That's it. Claude will read your existing notes and respect the provenance rules from the first session.

---

## What happens to your existing notes

**Nothing.** Claude Code reads your files but won't modify anything without your explicit permission. Your existing notes have no `claude_generated: true` frontmatter, so Claude treats them as read-only by default.

---

## Customizing CLAUDE.md for your vault

The `vault-template/CLAUDE.md` file is a starting point. After copying it, you might want to customize a few things:

### Tell Claude about your folder structure

If your vault has a non-standard layout, add a section describing it:

```markdown
## My vault structure

```text
my-vault/
├── Inbox/          ← unprocessed notes
├── Notes/          ← permanent notes
├── Projects/       ← active project folders
├── Archive/        ← completed/inactive notes
└── Journal/        ← daily notes (YYYY-MM-DD.md)
```

### Describe your tagging conventions

If you have established tag patterns, tell Claude:

```markdown
## Tagging conventions

- Tags use lowercase kebab-case: `#book-notes`, `#work-project`
- Source tags: `#book`, `#article`, `#podcast`, `#talk`
- Status tags: `#draft`, `#in-progress`, `#evergreen`
- Project tags mirror project names: `#acme-corp`, `#q3-launch`
```

### Add project context

If you have active projects, give Claude a head start:

```markdown
## Active projects (as of May 2026)

- **Acme Corp** — infrastructure migration, in `Projects/Acme Corp/`
- **Side project: Obsidian plugin** — in `Projects/Obsidian Plugin/`
```

---

## Notes about large vaults

If your vault has thousands of notes, a few things to keep in mind:

**Use scoped commands.** `vault`-scope commands read many files and may hit context limits with smaller local models. Prefer `folder:` or `note:` scope for everyday use. Use `vault` scope occasionally for big-picture summaries.

**Index.md helps a lot.** If you have an `Index.md` or `Home.md` at your vault root, Claude reads it first and uses it to orient. This dramatically improves the quality of `/ask` and `/daily-review` on large vaults. If you don't have one, `/build-moc vault` can create a starting point.

**Model context windows matter.** Qwen3-Coder (256K context) handles large vaults better than smaller-context models. If you're on Ollama with a local model, check your model's context window in `ollama show <model>`.

---

## Keeping CLAUDE.md updated

As your vault evolves, update the "Vault structure" section in `CLAUDE.md` to reflect how things actually look. The more accurately Claude understands your vault's layout, the better its suggestions will be.

A useful habit: when you create a new major folder or change your organizational system, add a brief note to `CLAUDE.md` explaining the change.

---

## If something goes wrong

**Claude edited a note I didn't want it to edit:**
Check the file's frontmatter — if it has `claude_generated: true`, Claude was following the rules. If it doesn't, that's a bug — please [open an issue](https://github.com/yourusername/demo-claude-code-obsidian/issues).

**Claude created notes I didn't ask for:**
This shouldn't happen. Claude should only create files when you explicitly run a command. If it's happening, check whether there's something in your existing `CLAUDE.md` that might be triggering autonomous behavior.

**The staging folder is getting cluttered:**
Run `/review-generated` and do a sweep. Set a recurring reminder to do this weekly.
