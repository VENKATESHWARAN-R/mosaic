# MOSAIC Development Guide

> This file is for Claude Code sessions working **on** the MOSAIC framework itself.
> For the template CLAUDE.md that gets copied into user projects, see `template/CLAUDE.md`.

## What is MOSAIC?

MOSAIC (Multi-Agent Orchestration System for Agentic Intelligence Collaboration) is a filesystem-based, vendor-agnostic framework for coordinating multiple AI coding agents on a single project. It uses structured markdown files and shell conventions — no databases, no servers.

## Project Structure

```
mosaic/
├── bin/hive              # CLI entry point (bash)
├── install.sh            # Symlinks bin/hive into PATH
├── template/             # Scaffold files copied by `hive init`
│   ├── .hive/            # Coordination directory structure
│   ├── .claude/          # Claude Code skills + agents (for user projects)
│   ├── AGENTS.md         # Universal agent instructions
│   ├── CLAUDE.md         # Claude Code instructions
│   ├── GEMINI.md         # Gemini CLI instructions
│   └── .gitignore        # Git ignores for user projects
├── .claude/              # Claude Code config for THIS project
│   ├── settings.json     # Permissions
│   ├── skills/           # MOSAIC maintenance skills
│   └── agents/           # Research agents
├── CLAUDE.md             # This file
├── README.md             # Public-facing documentation
├── CHANGELOG.md          # Version history
└── LICENSE               # MIT
```

## Key Concepts

- **`template/`** contains everything that `hive init` copies into a user's project. Changes here affect all new MOSAIC installations.
- **`bin/hive`** is the CLI. It references `$TEMPLATE_DIR` to find template files. Keep its `VERSION` in sync with CHANGELOG.md.
- **Root `.claude/`** contains skills/agents for maintaining MOSAIC itself (not the template).
- **`template/.claude/`** contains skills/agents for user projects using MOSAIC.

## Development Conventions

1. **Test changes manually** — run `hive init` in a temp directory after modifying templates
2. **Keep template files self-contained** — they must work without the MOSAIC repo being present
3. **Preserve backward compatibility** — existing `.hive/` directories should remain valid
4. **Use semantic versioning** — update CHANGELOG.md and `bin/hive` VERSION for releases
5. **Don't mix concerns** — root `.claude/` is for MOSAIC dev, `template/.claude/` is for users

## Available Skills

- `/mosaic-update` — Research latest agent CLI features and update framework
- `/mosaic-setup` — Configure MOSAIC for a user's specific agent setup
- `/mosaic-doctor` — Validate project consistency

## Modifying Templates

When editing files in `template/`:
- Changes to `template/.hive/` affect the directory structure `hive init` creates
- Changes to `template/.claude/skills/` affect slash commands available in user projects
- Changes to `template/.claude/agents/` affect subagent wrappers in user projects
- Changes to `template/AGENTS.md` affect the universal instruction file
- If you add new files to the template, update `bin/hive` `cmd_init()` to copy them
- If you add new template directories, ensure `bin/hive` creates them during init
