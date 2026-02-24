# Changelog

All notable changes to MOSAIC will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-02-25

### Added
- Core `.hive/` directory structure for multi-agent coordination
  - `transfers/` — handoff notes between agents with archive
  - `tasks/` — shared task tracking (active + backlog)
  - `sessions/` — current session state
  - `memory/` — decisions, learnings, dead-ends
  - `workflows/` — documented collaboration patterns
  - `context/` — project brief and conventions
- `bin/hive` CLI with commands: `init`, `status`, `relay`, `ensemble`, `roster`
- Agent instruction files: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`
- Claude Code skills: `/relay-handoff`, `/hive-status`, `/ensemble-plan`, `/hive-init`
- Claude Code subagent wrappers: `@gemini-executor`, `@codex-executor`, `@opencode-executor`
- Four workflow patterns: Solo Sprint, Relay Race, Team Parallel, Full Orchestra
- `roster.yaml` for agent registry and routing
- `install.sh` for CLI installation
- MOSAIC self-maintenance skills: `/mosaic-update`, `/mosaic-setup`, `/mosaic-doctor`
- `framework-researcher` agent for read-only ecosystem research
