# The provenance system

How Claude Code tracks what it created so your vault stays clean.

## The problem it solves

If an AI agent writes notes directly into your vault without marking them, you end up with notes you didn't write, can't easily identify, and aren't sure whether to trust. Over time this makes the vault feel unreliable.

The provenance system solves this with two mechanisms: **frontmatter tagging** and **staging folders**.

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

### 2. AI notes land in `_claude/` staging folders

New files go into `_claude/` subfolders, not directly into your note tree:

```text
vault/
├── notes/          ← your notes
├── Projects/
│   └── Acme Corp/
│       ├── notes/  ← your project notes
│       └── _claude/ ← AI drafts for Acme Corp, awaiting review
└── _claude/        ← vault-level AI drafts
```

Notes in `_claude/` folders still appear in Obsidian's graph and search — they're just clearly partitioned.

### 3. Claude won't touch your notes

The `CLAUDE.md` instructs Claude Code that it may only edit a file if:

- The file has `claude_generated: true` in its frontmatter, **or**
- You explicitly say "edit [filename]" in your message

This means your notes are safe by default. Claude reads everything, writes only what it created.

---

## What to do with staged notes

When Claude creates a note, it tells you where it landed. From there, three options:

**Keep it — move it:**
Drag it out of `_claude/` into wherever it belongs. The provenance frontmatter stays, so you still know it was AI-generated.

**Keep it — leave it:**
Change `claude_status: draft` to `claude_status: reviewed` in the frontmatter. Claude will treat it as acknowledged and won't mention it in `/review-generated` anymore.

**Discard it:**
Delete the file. Nothing in your main vault will be affected.

---

## Filtering `_claude/` from the graph

Obsidian's graph can get noisy if staging folders accumulate many draft notes. To filter them:

1. Open the Graph view
2. Click the filter icon
3. Under **Files**, add: `-path:_claude`

This hides all `_claude/` contents from the graph without deleting them.

---

## Status values

| `claude_status` | Meaning |
| --- | --- |
| `draft` | Created by Claude, not yet reviewed by you |
| `reviewed` | You've seen it; chose to leave it in staging |
| `approved` | Approved and ready to use, but not moved yet |

You set these manually. Claude reads them but doesn't change `claude_status` on existing files.

---

## `/review-generated`

Run this command at any time to get a full inventory of pending AI notes across your vault:

```bash
/review-generated
```

Output format:

```text
_claude/ (vault level)
  - summary-notes-2026-05-22.md (created by /summarize on 2026-05-22)
  - moc-notes-2026-05-22.md (created by /build-moc on 2026-05-22)

Projects/Acme Corp/_claude/
  - project-brief-acme-2026-05-22.md (created by /summarize project:Acme Corp on 2026-05-22)
```

---

## Bringing your own vault

When you add `vault-template/CLAUDE.md` to an existing vault, Claude Code will follow the same rules from the start. Your existing notes are never touched. New `_claude/` folders are created only when Claude generates something for the first time.

See [docs/your-own-vault.md](your-own-vault.md) for the full migration guide.
