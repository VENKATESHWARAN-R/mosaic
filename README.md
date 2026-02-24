# MOSAIC

**Multi-Agent Orchestration System for Agentic Intelligence Collaboration**

A filesystem-based, vendor-agnostic framework for coordinating multiple AI coding agents (Claude Code, Codex CLI, Gemini CLI, OpenCode, etc.) on a single project.

## The Problem

When working with multiple AI agents on one codebase:
1. **Context loss during agent switches** — each agent starts blind
2. **No coordination** — parallel agents can step on each other's work

## The Solution

MOSAIC uses **structured markdown files** and **conventions** that every agent can read. No databases, no servers — just files and shell scripts.

```
.hive/
├── transfers/latest.md    ← Handoff notes between agents
├── tasks/active.md        ← Shared task tracking
├── sessions/current.md    ← Who's working on what right now
├── memory/decisions.md    ← Why things were done a certain way
└── workflows/             ← Documented collaboration patterns
```

## Quick Start

```bash
# Install the CLI
./install.sh

# Initialize MOSAIC in any project
cd your-project
hive init

# Check status
hive status

# Hand off between agents
hive relay claude gemini

# Run agents in parallel
hive ensemble start backend frontend
hive ensemble merge
```

## Workflows

| Workflow | Use Case |
|----------|----------|
| **Solo Sprint** | Single agent, focused session with checkpoints |
| **Relay Race** | Sequential handoff between agents |
| **Team Parallel** | Multiple agents on independent branches |
| **Full Orchestra** | Conductor agent delegates to specialists |

See `.hive/workflows/` for detailed guides.

## CLI Commands

| Command | Description |
|---------|-------------|
| `hive init` | Initialize `.hive/` in current project |
| `hive status` | Show tasks, session, transfers, git state |
| `hive relay <from> <to>` | Prepare handoff between agents |
| `hive ensemble start <a> <b>` | Create parallel work branches |
| `hive ensemble merge` | Merge parallel branches |
| `hive roster` | List available agents |

## Claude Code Integration

MOSAIC includes Claude Code skills (slash commands):
- `/relay-handoff` — Generate transfer note and prepare for agent switch
- `/hive-status` — Show framework status dashboard
- `/ensemble-plan` — Decompose task for parallel execution
- `/hive-init` — Initialize MOSAIC in current project

And subagent wrappers for cross-agent invocation:
- `@gemini-executor` — Delegate to Gemini CLI
- `@codex-executor` — Delegate to Codex CLI
- `@opencode-executor` — Delegate to OpenCode

## Supported Agents

| Agent | Instruction File | Strength |
|-------|-----------------|----------|
| Claude Code | `CLAUDE.md` | Orchestration, complex reasoning |
| Codex CLI | `AGENTS.md` | Fast focused implementation |
| Gemini CLI | `GEMINI.md` | Large codebase analysis (1M context) |
| OpenCode | `AGENTS.md` | Flexible model selection |

Add more agents by editing `.hive/roster.yaml`.

## Design Principles

1. **Filesystem is the universal bus** — every agent can read/write files
2. **Markdown is the universal language** — every agent understands markdown
3. **Human is always the orchestrator** — framework assists, never replaces
4. **Convention first, automation second** — usable immediately with zero tooling
5. **Incremental adoption** — start with one pattern, add complexity as needed
