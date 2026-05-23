# Claude Code — project-tracker vault

This vault demonstrates using Claude Code for client and project management. It's structured around the idea that **the vault is the source of truth** — Claude Code reads it to understand the current state of all work, and writes to it to keep it current.

**This is an example vault.** It contains a sample client project (Acme Corp) to experiment with before using Claude on your real vault.

---

## Vault structure

```text
project-tracker/
├── Index.md                       ← master vault overview
├── CLAUDE.md                      ← this file
├── Projects/
│   ├── _master-index.md           ← all projects at a glance
│   └── Acme Corp/
│       ├── _index.md              ← Acme MOC (source of truth)
│       ├── meetings/
│       │   └── 2026-05-01 Kickoff.md
│       └── notes/
│           └── Architecture Overview.md
└── templates/
    ├── Project.md
    ├── Meeting.md
    └── Client.md
```

---

## Critical rules — read these first

### What you may touch

**You may freely read any file in this vault.**

**You may only create or edit files if ONE of these is true:**

1. The file has `claude_generated: true` in its frontmatter
2. The user explicitly says "edit [filename]" or "update [filename]"
3. You are creating a new file (must include provenance frontmatter)

**Special rule for `_index.md` files:** These are Maps of Content and may be user-created. Before editing any `_index.md`, show the user exactly what you plan to change and ask for explicit confirmation.

**You may never:** delete files, rename files, move files (suggest to user instead), or edit user notes without explicit permission.

### Provenance frontmatter — required on every file you create

```yaml
---
claude_generated: true
claude_status: draft
claude_command: /command-used
claude_date: YYYY-MM-DD
---
```

---

## The vault as source of truth

When the user asks about the status of any project, your answer comes from the vault — not from your own knowledge or assumptions. Workflow:

1. Read `Projects/_master-index.md` for the high-level picture
2. Read `Projects/<ProjectName>/_index.md` for project details
3. Read recent meeting notes and working notes for current state
4. Synthesize and respond with citations to specific files

If something isn't in the vault, say so. Offer to help add it.

---

## Commands

### `/new-project <name>`

Creates a complete project workspace.

**Creates:**

- `Projects/<name>/`
  - `_index.md` — project MOC
  - `meetings/` — meeting notes folder
  - `notes/` — working notes folder
- Adds link to `Projects/_master-index.md`
- Adds link to `Index.md` under "Active projects"

**`_index.md` template:**

```markdown
---
claude_generated: true
claude_status: draft
claude_command: /new-project
claude_date: {{date}}
type: project-moc
project: {{name}}
status: active
started: {{date}}
---

# {{name}}

## Overview
<!-- One paragraph: what is this engagement/project? -->

## Key contacts
<!-- [[Person Name]] — title, role -->

## Objectives
- 

## Open threads
- [ ] 

## Notes
<!-- [[Note Title]] — what it covers -->

## Meetings
<!-- [[YYYY-MM-DD Meeting Name]] — key outcome -->

## Decisions made
<!-- Date — Decision — Rationale -->

## Related projects
<!-- [[Project Name]] -->
```

---

### `/new-note <title> [in:<project>] [template:<type>]`

Creates a note in `Projects/<project>/notes/` (or `notes/` if no project specified).

Available templates: `meeting`, `project`, `client`, `default`.

When using the `meeting` template, pre-populate with today's date and ask what project it belongs to if `in:` isn't specified.

---

### `/update-project <name>`

Syncs `Projects/<name>/_index.md` with current file state.

**Workflow:**

1. Read `_index.md`
2. Scan `meetings/` and `notes/` for all current files
3. Identify: notes in MOC that no longer exist, files that exist but aren't in MOC
4. Show the diff clearly
5. Ask before editing
6. If `_index.md` is NOT `claude_generated`, show exact edits and ask again

---

### `/summarize [project:<name> | meeting:<path> | vault]`

- `project:<name>` — reads all notes and meetings, produces a 1-page project brief
- `meeting:<path>` — summarizes a meeting note, extracts action items
- `vault` — reads `_master-index.md` and all project MOCs, produces portfolio overview

Offer to save the summary in `notes/`.

---

### `/find-connections <note>`

Scans the vault for related notes across projects. Useful for finding when the same client contact, technology, or theme appears in multiple projects.

---

### `/ask <question>`

Searches vault for relevant notes, answers with file citations. Examples:

- "What did we decide about the Acme Corp infrastructure?"
- "Which projects mention Kubernetes?"
- "What's Jordan working on across all active projects?"

---

### `/daily-review`

Morning briefing across all projects.

**Produces:**

1. Open tasks from all `_index.md` files and recent meeting notes
2. Files modified or created in the last 7 days
3. Projects with no activity in the last 30 days (flagged)
4. Any cross-project connections noticed

Offer to create today's daily note if a templates/Daily Note.md exists.

---

### `/review-generated`

Lists all files with `claude_status: draft` across the vault, grouped by location.

---

### `/build-moc <project>`

Regenerates `Projects/<project>/_index.md` from current file state. Shows the user a diff of changes before editing the file in place.

---

## On startup

Read `Index.md` and `Projects/_master-index.md`. Then say:

> Ready — project-tracker has [N] active projects. Try `/daily-review` or `/new-project Your Client Name`.

If there are files with `claude_status: draft` anywhere in the vault, mention the count.
