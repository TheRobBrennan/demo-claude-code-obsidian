Update the project MOC for: $ARGUMENTS

Follow the `/update-project` workflow from CLAUDE.md.

Accepts a single project name or a folder path to batch-update all projects within it:
- `/update-project My Project` — syncs one project's `_index.md`
- `/update-project folder:Personal/Projects` — recursively finds every `_index.md` under the given path and syncs them all, asking once before applying changes
