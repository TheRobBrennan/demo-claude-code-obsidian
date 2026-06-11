# Commands reference

All commands available when working inside an Obsidian vault with Claude Code. These are registered as real slash commands via `.claude/commands/` — type them directly in Claude Code just like any built-in command.

---

## Project management

### `/new-project <name>`

Creates a complete project workspace.

```
/new-project Acme Corp
/new-project Q3 Product Launch
```

**Creates:**

- `Projects/<name>/_index.md` — project MOC (Map of Content)
- `Projects/<name>/meetings/` — for meeting notes
- `Projects/<name>/notes/` — for working notes
- Entry in `Projects/_master-index.md`
- Entry in vault `Index.md`

### `/update-project <name>`

Syncs a project's MOC with its current files — adds entries for new notes, flags stale entries for notes that no longer exist.

```
/update-project Acme Corp
/update-project folder:Projects
```

Single-project form updates one `_index.md`. Folder form recursively finds all `_index.md` files under the given path, shows all diffs together, and asks once before applying.

Always asks before editing. Shows you exactly what will change.

---

## Notes

### `/new-note <title> [in:<project>] [template:<type>]`

Creates a note from a template, placed directly in your vault.

```
/new-note "Week 3 Check-in" in:Acme Corp template:meeting
/new-note "Redis Architecture" in:Acme Corp
/new-note "2026-05-22" template:daily
```

**Templates:** `meeting`, `project`, `client`, `daily`, `book`, `default`

### `/review-generated`

Lists all pending AI-generated notes (`claude_status: draft`) grouped by location.

```
/review-generated
```

---

## Summarization

### `/summarize`

Summarize at different scopes:

```
/summarize                              # asks which note you mean
/summarize note:notes/Deep Work         # specific note
/summarize folder:Projects/Acme Corp    # all notes in a folder
/summarize project:Acme Corp            # project brief
/summarize vault                        # high-level vault overview
```

Output: 3–5 sentence summary, key themes, open questions. Offers to save as a new note.

---

## Connections & tags

### `/find-connections <note>`

Reads a note and scans the vault for related notes it should link to.

```
/find-connections "Zettelkasten Method"
/find-connections notes/Architecture Overview
```

Returns suggested `[[wikilinks]]` with one-sentence rationale. Asks before adding them.

### `/generate-tags`

Suggests tags using conventions already in your vault.

```
/generate-tags                          # current note (if mentioned)
/generate-tags note:notes/Deep Work
/generate-tags folder:notes             # all notes in folder missing tags
```

Asks before writing anything to frontmatter.

### `/build-moc <folder>`

Generates a Map of Content for a folder, grouping notes by theme.

```
/build-moc notes
/build-moc Projects/Acme Corp
```

Saves draft directly in the folder. You move or rename it to `Index.md` or `_index.md` when satisfied.

---

## Search & Q&A

### `/ask <question>`

Searches your vault for relevant notes and answers the question with citations.

```
/ask what did we decide about the Acme Corp infrastructure?
/ask which notes discuss spaced repetition?
/ask what are the open tasks across all projects?
/ask what themes keep coming up in my reading notes?
```

Cites specific notes with `[[wikilinks]]`. Notes when relevant information doesn't exist in the vault.

---

## Daily workflows

### `/start-day`

Morning ritual — reads yesterday's carried items, prompts for today's calendar and task list, then creates or updates today's daily note pre-populated with everything. Automatically chains into `/prioritize-day` when done.

```
/start-day
```

**What it does:**
1. Reads yesterday's close-out and carried items
2. Prompts you for calendar events and tasks (or accepts them if already provided)
3. Creates/updates `Daily notes/<Weekday>, <Month> <Day>th <Year>.md` with Calendar, Game plan, and OBSERVE sections
4. Rolls straight into `/prioritize-day` to tier the game plan

---

### `/prioritize-day`

Tiers today's game plan into 🟢/🔵/🟡/🔴 buckets so you know exactly what to tackle.

```
/prioritize-day
/prioritize-day the client deliverable is the priority
```

**Tiers:**
- 🟢 **Must Do Today** — hard deadlines, commitments that affect others
- 🔵 **Planned For Today** — intended and expected to happen
- 🟡 **Slipping** — only used during re-prioritization when 🔵 items are at risk
- 🔴 **Captured — Not Today** — parked, not forgotten

Household tasks and personal commitments are always elevated to 🔵 minimum. Offers to write the tiered plan back to the daily note in-place.

---

### `/close-day`

End-of-day ritual — reviews completions, analyzes time use, writes a `# 🌙 Day in review` section into the daily note, and ensures all meaningful folders have `_index.md` files for the Graph view.

```
/close-day
```

**What it does:**
1. Identifies the active day (most recently modified daily note)
2. Reviews completed vs. unfinished game-plan items
3. Analyzes the OBSERVE timeline: time blocks, categories, focus vs. fragmentation, plan vs. reality
4. Appends the analysis to the daily note (asks before writing)
5. Walks all non-excluded folders and creates missing `_index.md` MOC files

---

### `/daily-review`

Morning briefing from your vault.

```
/daily-review
```

**Produces:**

- Open tasks from all projects (grouped by project)
- Notes created or modified in the last 7 days
- Projects with no activity in the last 30 days
- Any cross-project connections noticed

Offers to create today's daily note from `templates/Daily Note.md`.

---

## Tips

**Scope your commands.** `folder:Projects/Acme Corp` is faster and cheaper than `vault` for project-specific work.

**Be explicit about editing.** Claude won't touch your notes unless you say "edit [filename]" or the file is already `claude_generated: true`. If you want Claude to update a note, say so clearly: "edit Architecture Overview and add the Redis decision."

**Review generated notes regularly.** Run `/review-generated` once a week to decide what to keep and what to discard. Draft notes work best when they're not allowed to accumulate indefinitely.

**Commands are flexible.** The `/command` format is a convention, not a syntax requirement. You can also just speak naturally: "Create a new project for my work with Widget Inc." or "Find all the notes that should link to the Zettelkasten piece." Claude will do the right thing.
