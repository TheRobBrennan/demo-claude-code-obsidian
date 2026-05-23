---
tags: [daily-note]
date: 2026-05-22
---

# May 22, 2026

## Morning intention

Focus on getting the Claude Code × Obsidian repo into a reviewable state.

## Open tasks

- [ ] Finish README for demo-claude-code-obsidian repo
- [ ] Test Ollama setup with qwen3-coder
- [x] Review Zettelkasten notes from last week
- [ ] Follow up with Jordan about the Acme project kickoff

## Notes from today

Been thinking about how the provenance system for Claude-generated notes should work. Key insight: the _claude/ staging folder should be **local to the context** — one per project, not one global dump. That way, when you're in Projects/Acme, the AI drafts are right there.

Also: need to look more into how the Obsidian graph handles files in subfolders. Notes in `_claude/` folders will show up in the graph, which could be noisy. May want to add a note in the setup docs about filtering these out.

## Links I want to explore

- The connection between [[Zettelkasten Method]] and how Claude Code reads a vault is interesting — in both cases, links are the navigation layer
- [[Machine Learning Notes]] — should add something about local embeddings for semantic search

## Tomorrow

- [ ] Write the project-tracker example vault content
- [ ] Test the CLAUDE.md with actual Claude Code
