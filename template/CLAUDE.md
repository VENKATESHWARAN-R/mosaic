# Claude Code — MOSAIC Integration

> Claude-specific instructions. Read `AGENTS.md` first for universal project context.

## MOSAIC Framework

This project uses MOSAIC for multi-agent coordination. Key files:
- `.hive/transfers/latest.md` — Check this FIRST for handoff context
- `.hive/tasks/active.md` — Current work items
- `.hive/sessions/current.md` — Update this when you start/stop working

## Available Skills

- `/relay-handoff` — Create a transfer note and prepare for agent switch
- `/hive-status` — Show current tasks, session state, recent transfers
- `/ensemble-plan` — Decompose a task for parallel multi-agent execution
- `/hive-init` — Initialize `.hive/` structure in a new project

## Available Subagents

Use these to delegate work to other agent CLIs:
- `@gemini-executor` — Delegate large codebase analysis to Gemini CLI
- `@codex-executor` — Delegate focused implementation to Codex CLI
- `@opencode-executor` — Delegate general tasks to OpenCode

## Session Protocol

1. **On start**: Read `.hive/transfers/latest.md` if it exists. Update `.hive/sessions/current.md`.
2. **During work**: Log decisions in `.hive/memory/decisions.md`. Log failed approaches in `.hive/memory/dead-ends.md`.
3. **On finish**: Run `/relay-handoff` or manually create a transfer note.
