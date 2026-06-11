---
name: start-day
description: Start a new day in the Obsidian vault. Reads yesterday's carried-forward items and close-out, prompts the user for calendar screenshots and task list, then creates or updates today's daily note with the full context pre-populated. Invoke as /start-day, or when the user says they're starting their day, beginning their day, or opening up for the day.
---

# /start-day

Morning ritual for this vault. Starting a day sometimes happens **before the previous day's note was closed** — that's fine; pull the carried items from the most recently closed note.

## Determining "today" and "yesterday"

1. List `Daily notes/*.md` and sort by filename date. Today is the note whose frontmatter `date:` matches the current calendar date. Yesterday is the one immediately before it.
2. If today's note already exists, you will **update** it rather than recreate it (see Step 4).
3. Confirm in one line: _"Starting Thursday, May 28th 2026."_

---

## Step 1 — Read yesterday's close-out

Open yesterday's daily note. Extract:

- **Carried items** — everything under `# 🌃 For tomorrow...` (all sub-sections: Calendar, Household, Job Hunt, any project sections).
- **Unchecked game-plan items** (`- [ ]`) that were never carried forward explicitly — flag these as "also unfinished."
- **Day in review** (if present) — pull the `## ➡️ Carried to tomorrow` list for cross-reference.

Do **not** re-read or modify yesterday's note again after this step.

---

## Step 2 — Gather today's calendar and tasks

Check whether the user has already supplied calendar or task information in their message (e.g. pasted text, a task list, or screenshot descriptions). If **not** supplied, ask:

> I don't see today's calendar or task list yet. Please share either:
> - A **screenshot of your calendar** for today, or paste the events as text
> - Your **planned tasks** (Asana export, a text list, or whatever you have)
>
> You can share one, both, or neither — just let me know what you have.

Wait for the user's response before proceeding. If the user says they have nothing to add, proceed with only the carried items.

Parse what the user provides:
- **Calendar events** → extract time, title, and any note-worthy context
- **Task list** → extract tasks, noting any priority signals (starred, flagged, ordered) but treat them as intentions, not guarantees

---

## Step 3 — Build today's note content

Assemble the full note using the daily note template structure (`templates/Daily Note.md`). Fill in:

### `# 📆 Calendar`
List today's events in chronological order, each prefixed with a fitting emoji. Format: `- 🏒 Event title @ H:MMam/pm`. Leave blank lines between morning, afternoon, and evening clusters if there are many events.

### `# 🗺️ Game plan`
Group tasks under `##` section headers that match the project or domain (mirror the style from recent daily notes — e.g. `## 💁‍♀️ Resumé review`, `## 🔮 Claude Code x Obsidian`, `## 🏠 Household`, `## 🧑‍💼 The Great Job Hunt`).

- Tasks from the user's provided list → `- [ ] task`
- Carried items from yesterday → `- [ ] task` with a subtle carry marker, e.g. `_(carried)_`
- If a task came from both sources (user listed it AND it was carried), deduplicate and list once without the carry marker.

Do **not** pre-check anything. The user starts the day with everything open.

Note: `/prioritize-day` will later replace this section's content in-place with a 🟢/🟡/🔴 tiered view. Populate it here in project-grouped format — that's the right starting state.

### `# 👀 OBSERVE: What's your day look like?`
Run `date "+%-I:%M%p" | tr '[:upper:]' '[:lower:]'` to get the actual current local time, then add a single timestamped entry:

```
H:MMam/pm 🌅 Started the day with /start-day
```

Leave the rest of the section blank for the user to fill in as the day unfolds.

### `# 🌃 For tomorrow...` and `# 📿 Loose ends`
Leave blank. Do **not** pre-populate with carried items here — those belong in the Game plan. These sections are filled at close-of-day.

---

## Step 4 — Write or update the daily note

**If no note exists for today:**
Create `Daily notes/<Weekday>, <Month> <Day>th/st/nd/rd <Year>.md` (match the exact filename format of existing notes, e.g. `Thursday, May 28th 2026.md`). Include the standard frontmatter:

```yaml
---
tags: [daily-note]
date: YYYY-MM-DD
---
```

This is a **new file**, so creation is permitted freely. Still show the user a preview of what will be written before creating.

**If a note already exists for today:**
The note is user-created, so per vault rules you must get permission before editing. Show the user exactly what sections will change (or be added to) and confirm before writing. Specifically:

- Merge calendar entries — add any new events not already listed; don't duplicate
- Merge game plan — add missing tasks under the appropriate section headers; don't duplicate
- Append the `/start-day` log entry to `# 👀 OBSERVE` (always append, never replace — the timeline is append-only)
- Leave any sections the user has already filled in untouched

---

## Step 5 — Wrap up and hand off to /prioritize-day

Give a one-line summary of what was written (note created/updated, how many tasks, how many calendar events), then immediately invoke `/prioritize-day` to tier the game plan. Do not ask — just roll straight into it. The two skills are a single ritual: start-day populates, prioritize-day focuses.

## Tone

Crisp and energizing. This is the start of the day, not an audit. Surface the key focus clearly so the user can hit the ground running.
