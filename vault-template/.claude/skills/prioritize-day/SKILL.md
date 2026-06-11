---
name: prioritize-day
description: Prioritize today's game plan in the Obsidian daily note. Always elevates Household tasks and any tasks involving people you've marked as personal priorities. Asks the user for priority guidance on remaining items, then outputs a clear 🟢/🔵/🟡/🔴 tiered plan and offers to write it back to the daily note. Invoke as /prioritize-day, or when the user says things like "what should I focus on today", "help me prioritize", "what's most important today", "organize my day", "what do I need to get done today", or "what can I push off".
---

# /prioritize-day

Help the user cut through the noise and figure out what actually needs to happen today vs. what can wait. The output is a clear, tiered game plan — not a reshuffle of everything, just honest triage.

---

## Step 1 — Read today's game plan

1. Determine today's date and locate today's daily note: `Daily notes/<Weekday>, <Month> <Day>th/st/nd/rd <Year>.md`
2. Read the note. Extract every unchecked task (`- [ ]`) from the `# 🗺️ Game plan` section, preserving which `##` project/section header each task belongs to.
3. If there are no unchecked tasks, tell the user and stop.

---

## Step 2 — Auto-elevate fixed priorities

Two categories are always elevated — but elevated means **🔵 at minimum**, not automatically 🟢. Only push them to 🟢 if there's a genuine urgency signal (explicit deadline, blocking someone else, or the user flags it as must-do):

- **Household** — any task under a `## 🏠 Household` section header, or any task whose text mentions household chores, home, dishes, laundry, cleaning, cooking, groceries, or similar domestic items.
- **Close personal commitments** — any task involving a person you've designated as a priority (e.g. a partner, family member). Customize this section in your own vault's `SKILL.md` by replacing this bullet with the specific names and relationships that matter to you (e.g. "any task that mentions [Partner's name] or their family").

Set these aside as confirmed 🔵 items (or 🟢 if urgency is clear). Do not ask the user about them.

---

## Step 3 — Check for user guidance

Look at what the user said when invoking this skill. Did they give any signals about what's important today? For example:
- "I really need to get the report done"
- "The client deliverable is the priority"
- "Ignore the brainstorming stuff for now"

If they gave guidance, use it to pre-sort the remaining tasks before asking.

If they gave **no guidance**, ask — but keep it tight. Show them the remaining tasks (grouped by project) and ask:

> Here are the tasks I need your input on. For each group, let me know:
> - **Must do today** 🟢 — deadline, commitment, or momentum depends on it
> - **Planned for today** 🔵 — intended for today, day should accommodate it
> - **Not today** 🔴 — captured but not expected to happen today
>
> Or just tell me in plain words what matters and I'll sort the rest.

**Do not offer 🟡 as an initial option.** 🟡 is a dynamic tier — items slip into it during re-prioritization as the day closes, not at the start.

Wait for their response before proceeding to Step 4.

---

## Step 4 — Build the prioritized plan

Assemble the output into four tiers:

### 🟢 Must Do Today
**Keep this list short and honest.** A task belongs here only if skipping it today causes real harm — a missed deadline, a broken commitment, or something that blocks others. When in doubt, put it in 🔵. A lean 🟢 is a signal the day is under control; a bloated 🟢 is just anxiety in list form.

Include:
- Tasks with a hard deadline today (e.g. "due by midnight", "submitting tonight")
- Commitments that directly affect another person if missed
- Any tasks the user explicitly flags as must-do

Do **not** include supporting or follow-up tasks for a 🟢 item — those belong in 🔵.

### 🔵 Planned For Today
The user intended to do these today and the day should realistically accommodate them — they're on the plan, not just the backlog. Not locked in by a hard deadline, but genuinely expected to happen. Use 🔵 for tasks that feel committed-to without being urgent: household items, personal commitments, and work the user has been meaning to get to and put on today's list with intent.

### 🟡 Slipping — May Not Happen
**This tier is only populated during re-prioritization, never at the start of the day.** Items land here when something that was 🔵 is now looking unlikely given how the day is actually going — capacity closed, time ran out, other things took over. These aren't forgotten; they're realistic acknowledgments that the day shifted. If capacity opens up, they can move back up. If not, they may roll to tomorrow.

### 🔴 Captured — Not Today
Items worth keeping on the radar but with no expectation of happening today. Good ideas, brainstorming, videos, low-stakes tasks, longer-horizon work. These are parked, not deferred — the distinction matters. **During re-prioritization, do not surface 🔴 items by default.** They stay captured unless the user explicitly asks about them.

Format each tier as a task list grouped by project. Use a bold project name as a heading before each group, and drop the trailing `_(Project)_` annotation since the heading carries that context. Preserve priority order within each tier — don't alphabetize by project, keep the order that reflects importance:

```
### 🟢 Must Do Today

**Project A**
- [ ] ✏️ Submit the client deliverable

### 🔵 Planned For Today

**Household**
- [ ] 🍀 Dishes
- [ ] 🧺 Laundry

**Project B**
- [ ] ✏️ Draft the architecture doc

### 🟡 Slipping — May Not Happen

_(omit this section entirely if empty)_

### 🔴 Captured — Not Today

**Ideas**
- [ ] 💡 BRAINSTORM: New feature concepts
```

---

## Step 5 — Present and offer to update

Show the prioritized plan. Then ask:

> Want me to update today's game plan with this prioritized view? I'll replace the `# 🗺️ Game plan` contents in-place — no duplicate section, just one clean plan.

If the user says yes, make two writes to today's note (show both as a single preview before confirming):

**1. Replace the `# 🗺️ Game plan` body** with the tiered plan:

```markdown
# 🗺️ Game plan
_Prioritized [time] via /prioritize-day_

### 🟢 Must Do Today
[items]

### 🔵 Planned For Today
[items]

### 🟡 Slipping — May Not Happen
[items, or omit this section entirely if empty]

### 🔴 Captured — Not Today
[items]
```

**On re-prioritization:** Before asking the user about anything else, surface any current 🔵 items and ask which — if any — are slipping given how the day has gone. Items the user flags as slipping move to 🟡. Do not surface 🔴 items unless the user asks.

Everything from the line after `# 🗺️ Game plan` up to the next `---` or top-level `#` heading is replaced. The heading itself stays.

**2. Append a timestamped log entry** to `# 👀 OBSERVE` (always append — never replace existing entries):

```
H:MMam/pm ⚡️ Prioritized the day via /prioritize-day ([N] items: [X] 🟢, [B] 🔵, [Z] 🔴)
```

If this is a *re-prioritization* (the game plan body already starts with `_Prioritized`), the log entry should reflect that:

```
H:MMam/pm 🔄 Re-prioritized the day via /prioritize-day
```

The OBSERVE section is an append-only timeline of the day. The log entry gives a lightweight record of when and how often priorities are being revisited.

Today's note is user-created, so per vault rules: show the exact text that will be replaced/appended and confirm before writing.

If priorities have already been set (game plan body starts with `_Prioritized`), replace that body again rather than append. The OBSERVE entry always appends.

---

## Tone

Direct and grounding — the user is trying to focus, not read an essay. State the priorities clearly. If most of the list can push, say so honestly. If the day looks genuinely heavy, acknowledge that too. One short paragraph of commentary after the plan is plenty.
