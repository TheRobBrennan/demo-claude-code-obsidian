# Claude Code — personal-kb vault

This is a demo Obsidian vault for experimenting with the Claude Code × Obsidian integration. It contains sample notes on productivity, technology, and note-taking methods.

**This is an example vault.** Use it to try commands before pointing Claude at your real vault.

---

## Vault overview

```text
personal-kb/
├── Index.md                 ← master Map of Content
├── CLAUDE.md                ← this file
├── notes/                   ← all notes live here
│   ├── (productivity)
│   ├── (technology)
│   └── (note-taking methods)
└── templates/
    ├── Daily Note.md
    ├── Book Notes.md
    └── Meeting Notes.md
```

**Things to try in this vault:**

```bash
/find-connections "Zettelkasten Method"
/generate-tags folder:notes
/summarize folder:notes
/ask what are the common themes across these notes?
/build-moc notes
/new-note "My Experiment" template:default
```

---

<!-- The rest of this file is the standard vault agent instructions -->

## Critical rules — read these first

### What you may touch

**You may freely read any file in this vault.**

**You may only create or edit files if ONE of these is true:**

1. The file has `claude_generated: true` in its frontmatter
2. The user explicitly says "edit [filename]" or "update [filename]" in their message
3. You are creating a new file (which must always include the provenance frontmatter)

**You may never:**

- Edit, rewrite, or append to a user's notes without explicit permission
- Delete any file
- Rename or move files (suggest this to the user instead)

### Provenance frontmatter — required on every file you create

```yaml
---
claude_generated: true
claude_status: draft
claude_command: /command-that-was-used
claude_date: YYYY-MM-DD
---
```

---

## Commands

### `/find-connections <note-title>`

Reads the note and scans the vault for related notes. Suggests `[[wikilinks]]` with rationale. Asks before editing.

### `/generate-tags [this | note:<path> | folder:<path>]`

Suggests tags using conventions already present in the vault. Asks before writing.

### `/summarize [this | note:<path> | folder:<path> | vault]`

Summarizes content. At `vault` scope, reads Index.md and samples notes.

### `/build-moc <folder>`

Generates a Map of Content and saves draft directly in the folder.

### `/ask <question>`

Searches vault for relevant notes, answers with citations.

### `/new-note <title> [template:<type>]`

Creates a note from `templates/<type>.md` directly in `notes/`.

### `/daily-review`

Reads last 3–5 daily notes (if any), scans for open tasks, suggests today's note.

### `/review-generated`

Lists all `claude_status: draft` files in the vault.

---

## On startup

Read `Index.md`, then say:

> Ready — personal-kb has [N] notes. Try `/find-connections "Zettelkasten Method"` or `/ask what themes keep coming up?`

If there are files with `claude_status: draft` in the vault, mention them.
