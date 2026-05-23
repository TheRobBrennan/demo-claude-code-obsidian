# The provenance system

How Claude Code tracks what it created so your vault stays clean.

## The problem it solves

If an AI agent writes notes directly into your vault without marking them, you end up with notes you didn't write, can't easily identify, and aren't sure whether to trust. Over time this makes the vault feel unreliable.

The provenance system solves this with **frontmatter tagging**: every file Claude creates is marked so you always know what's AI-generated and what isn't.

---

## How it works

### 1. Every AI-generated note is tagged

Claude Code adds this frontmatter to every file it creates:

```yaml
---
claude_generated: true
claude_status: draft
claude_command: /new-project
claude_date: 2026-05-22
claude_model: claude-sonnet-4-5
---
```

You can search for `claude_generated: true` in Obsidian to find every AI-created file at any time.

### 2. AI notes go directly into your note tree

Notes are created in the natural location for their content — e.g. `notes/` for a `/new-note` command, or `Projects/Acme Corp/` for a `/new-project` command. The provenance frontmatter is what marks them as AI-generated, not a separate folder.

### 3. Claude won't touch your notes

The `CLAUDE.md` instructs Claude Code that it may only edit a file if:

- The file has `claude_generated: true` in its frontmatter, **or**
- You explicitly say "edit [filename]" in your message

This means your notes are safe by default. Claude reads everything, writes only what it created.

---

## What to do with AI-generated notes

When Claude creates a note, it tells you where it landed. From there, three options:

**Keep it as-is:**
Leave it where it is. The provenance frontmatter marks it permanently as AI-generated.

**Acknowledge it:**
Change `claude_status: draft` to `claude_status: reviewed` in the frontmatter. Claude will treat it as acknowledged and won't mention it in `/review-generated` anymore.

**Discard it:**
Delete the file. Nothing else in your vault will be affected.

---

## Status values

| `claude_status` | Meaning |
| --- | --- |
| `draft` | Created by Claude, not yet reviewed by you |
| `reviewed` | You've seen it and chosen to keep it |
| `approved` | Approved and ready to use |

You set these manually. Claude reads them but doesn't change `claude_status` on existing files.

---

## `/review-generated`

Run this command at any time to get a full inventory of pending AI notes across your vault:

```
/review-generated
```

Output format:

```text
notes/
  - My first Claude Code note.md (created by /new-note on 2026-05-23)
  - My second Claude Code note.md (created by /new-note on 2026-05-23)
```

---

## Bringing your own vault

When you add `vault-template/CLAUDE.md` to an existing vault, Claude Code will follow the same rules from the start. Your existing notes are never touched — Claude only edits files it created.

See [docs/your-own-vault.md](your-own-vault.md) for the full migration guide.
