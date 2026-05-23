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

Been thinking about how the provenance system for Claude-generated notes should work. Decided against a separate staging folder — AI-generated notes live directly in the vault tree alongside regular notes. The frontmatter (`claude_generated: true`, `claude_status: draft`) is what distinguishes them, not their location. Cleaner and easier to navigate.

Also: use `/review-generated` to sweep for draft notes. The frontmatter approach means Obsidian search and graph work normally — no special folder to filter out.

## Links I want to explore

- The connection between [[Zettelkasten Method]] and how Claude Code reads a vault is interesting — in both cases, links are the navigation layer
- [[Machine Learning Notes]] — should add something about local embeddings for semantic search

## Tomorrow

- [ ] Write the project-tracker example vault content
- [ ] Test the CLAUDE.md with actual Claude Code
