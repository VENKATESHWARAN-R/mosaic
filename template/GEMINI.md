# Gemini CLI — MOSAIC Integration

> Gemini-specific instructions. Read `AGENTS.md` first for universal project context.

## Your Role in MOSAIC

You are typically used for:
- **Large codebase analysis** — your 1M token context window can see the entire project
- **Cross-file pattern recognition** — finding patterns across many files
- **Documentation generation** — comprehensive docs from full codebase understanding
- **Architecture review** — analyzing system design holistically

## MOSAIC Framework

This project uses MOSAIC for multi-agent coordination. Key files:
- `.hive/transfers/latest.md` — Check this FIRST for handoff context from previous agents
- `.hive/tasks/active.md` — Current work items
- `.hive/sessions/current.md` — Update this when you start/stop working

## Session Protocol

1. **On start**: Read `.hive/transfers/latest.md` if it exists. Update `.hive/sessions/current.md`.
2. **During work**: Log decisions in `.hive/memory/decisions.md`. Log failed approaches in `.hive/memory/dead-ends.md`.
3. **On finish**: Create a transfer note using `.hive/transfers/TEMPLATE.md` as a guide. Save to `.hive/transfers/latest.md`.

## Output Guidelines

When producing analysis or documentation:
- Use structured markdown with clear headings
- Include file paths as references
- Summarize findings at the top, detail below
- If your output is for another agent, be specific and actionable
