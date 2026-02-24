# Project Instructions

> This file is the universal entry point for all AI agents working on this project.
> Read this file first, then follow the references below.

## Project Overview

<!-- TODO: Replace with your project description -->
This project uses the **MOSAIC** multi-agent coordination framework. Multiple AI agents
may work on this codebase sequentially or in parallel.

## Quick Start for Agents

1. **Check for handoff context**: Read `.hive/transfers/latest.md` if it exists — a previous agent may have left you notes.
2. **Check current tasks**: Read `.hive/tasks/active.md` to see what needs to be done.
3. **Check session state**: Read `.hive/sessions/current.md` to see who's been working and on what.
4. **Before you start working**: Update `.hive/sessions/current.md` with your agent name and current task.
5. **When you finish**: Create a transfer note using `.hive/transfers/TEMPLATE.md` as a guide.

## Build / Test / Lint Commands

<!-- TODO: Replace with your project's commands -->
```bash
# Build
# npm run build

# Test
# npm test

# Lint
# npm run lint
```

## Key References

| Resource | Path | Purpose |
|----------|------|---------|
| Project Brief | `.hive/context/project-brief.md` | What this project is and why |
| Conventions | `.hive/context/conventions.md` | Coding standards and patterns |
| Architecture | `.hive/context/architecture.md` | System design decisions |
| Active Tasks | `.hive/tasks/active.md` | Current work items |
| Task Backlog | `.hive/tasks/backlog.md` | Future work items |
| Latest Transfer | `.hive/transfers/latest.md` | Most recent agent handoff |
| Decisions Log | `.hive/memory/decisions.md` | Key decisions and rationale |
| Dead Ends | `.hive/memory/dead-ends.md` | Approaches tried and failed |
| Agent Roster | `.hive/roster.yaml` | Available agents and capabilities |

## Workflow Rules

1. **Always update session state** when starting and finishing work.
2. **Always create a transfer note** when your session ends, even if work is incomplete.
3. **Log key decisions** in `.hive/memory/decisions.md` with rationale.
4. **Log failed approaches** in `.hive/memory/dead-ends.md` so others don't repeat them.
5. **Don't modify `.hive/config.yaml` or `.hive/roster.yaml`** unless explicitly asked.
6. **Commit frequently** with clear messages referencing task IDs when applicable.

## Agent-Specific Instructions

Some agents have additional instruction files:
- **Claude Code**: See `CLAUDE.md`
- **Gemini CLI**: See `GEMINI.md`
- **Codex CLI**: Reads this file (AGENTS.md) by default
- **OpenCode**: Reads this file (AGENTS.md) by default
