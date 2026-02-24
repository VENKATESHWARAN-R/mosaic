# MOSAIC

**Multi-Agent Orchestration System for Agentic Intelligence Collaboration**

A filesystem-based, vendor-agnostic framework for coordinating multiple AI coding agents (Claude Code, Codex CLI, Gemini CLI, OpenCode, etc.) on a single project.

## The Problem

When working with multiple AI agents on one codebase:
1. **Context loss during agent switches** — each agent starts blind, repeats questions, undoes work
2. **No coordination for parallel work** — two agents on the same branch = merge hell
3. **No shared memory** — decisions made with Agent A are invisible to Agent B

## What MOSAIC Is

MOSAIC is **shared context + git isolation + handoff protocols** — all in plain markdown files.

```
.hive/
├── transfers/latest.md    ← Handoff notes between agents
├── tasks/active.md        ← Shared task tracking
├── sessions/current.md    ← Who's working on what right now
├── memory/decisions.md    ← Why things were done a certain way
├── context/project-brief.md ← What this project is
└── workflows/             ← Documented collaboration patterns
```

Every agent can read markdown. Every agent can read/write files. That's the entire trick.

## What MOSAIC Is NOT

Be clear about what you're getting:

- **Not an auto-orchestrator.** MOSAIC does not automatically invoke agents, route tasks, or "make agents talk to each other." You are the conductor.
- **Not an agent runtime.** It doesn't run Claude, Gemini, or Codex for you. You start each agent yourself in its own terminal.
- **Not magic.** It's structured files and a small shell CLI. The value is in the *conventions*, not the tooling.
- **Not a replacement for understanding git.** Parallel workflows use git worktrees. You should know what those are.

## Quick Start

```bash
# Install the CLI
./install.sh

# Initialize MOSAIC in any project
cd your-project
hive init

# Check status
hive status
```

## Workflows

### 1. Solo Sprint — One agent, focused work

The simplest pattern. One agent at a time, shared context for next time.

```bash
hive init
claude  # or codex, gemini, opencode

# Agent reads AGENTS.md → .hive/tasks/active.md
# Agent works, commits, logs decisions
# You stop the agent when done
```

### 2. Relay Race — Sequential handoff between agents

Agent A finishes, leaves notes, Agent B picks up. **Same terminal, same directory.**

```bash
# Agent A (Claude) works on architecture
claude
# ... Claude works, you stop it ...

# Prepare handoff
hive relay claude gemini

# Agent B (Gemini) picks up with context
gemini
# Gemini reads AGENTS.md → .hive/transfers/latest.md → continues
```

### 3. Team Parallel — Multiple agents on independent work streams

**This is where people get confused.** You can't just `git checkout` in two terminals — that's the same working directory. MOSAIC uses **git worktrees** to give each agent its own isolated copy.

```bash
# Create parallel streams (creates separate directories)
hive ensemble start backend frontend

# Output tells you the paths:
#   .hive/worktrees/backend/   (branch: stream/backend)
#   .hive/worktrees/frontend/  (branch: stream/frontend)

# Terminal 1 — Backend agent
cd .hive/worktrees/backend
codex

# Terminal 2 — Frontend agent (simultaneously, different directory)
cd .hive/worktrees/frontend
gemini

# When both are done, return to project root
hive ensemble merge
```

**Why worktrees?** Each worktree is a full copy of your repo on its own branch. Two agents can work at the same time in different directories without any git conflicts until merge time.

### 4. Full Orchestra — Conductor delegates to specialists

One agent (usually Claude) plans the work, then you execute the plan across agents.

```bash
# 1. Claude plans the work
claude
# "Read .hive/tasks/ and break TASK-003 into parallel subtasks"

# 2. You create streams based on Claude's plan
hive ensemble start api database ui

# 3. Run each agent in its stream
cd .hive/worktrees/api && codex       # Terminal 1
cd .hive/worktrees/database && claude  # Terminal 2
cd .hive/worktrees/ui && gemini        # Terminal 3

# 4. Merge when done
cd /path/to/project
hive ensemble merge
```

## CLI Commands

| Command | Description |
|---------|-------------|
| `hive init` | Initialize `.hive/` in current project |
| `hive status` | Show tasks, session, transfers, git state |
| `hive relay <from> <to>` | Prepare handoff between agents |
| `hive ensemble start <a> <b>` | Create worktrees for parallel streams |
| `hive ensemble merge` | Merge all stream/ branches + cleanup |
| `hive roster` | List available agents |

## Example: Todo App with 3 Agents

A concrete example of parallel development:

```bash
# 1. Initialize
cd my-todo-app && git init && hive init

# 2. Fill in project context
#    Edit .hive/context/project-brief.md — what we're building
#    Edit .hive/tasks/active.md — define TASK-001 (backend) and TASK-002 (frontend)
#    Edit AGENTS.md — add build/test commands

# 3. Create parallel streams
hive ensemble start backend frontend

# 4. Backend agent (Terminal 1)
cd .hive/worktrees/backend
codex
> "Read .hive/tasks/active.md. Work on TASK-001. Build a FastAPI backend."

# 5. Frontend agent (Terminal 2)
cd .hive/worktrees/frontend
gemini
> "Read .hive/tasks/active.md. Work on TASK-002. Build a React frontend."

# 6. Both agents commit on their own branches.
#    They share the same task definitions but can't step on each other.

# 7. Merge (back in project root)
hive ensemble merge
# backend/ and frontend/ are separate dirs → clean merge
```

## Claude Code Integration

MOSAIC includes Claude Code skills (slash commands) in the template:
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

## Common Mistakes

| Mistake | What happens | Do this instead |
|---------|-------------|-----------------|
| `git checkout` in two terminals | Second terminal changes the branch for both | Use `hive ensemble start` (creates worktrees) |
| Forgetting to commit before merge | Uncommitted changes block `hive ensemble merge` | Commit in each worktree before merging |
| Two agents editing the same file | Merge conflicts | Split work by directory/module in your task definitions |
| Not filling in `.hive/tasks/` | Agents don't know what to do | Always define tasks with clear specs before starting agents |
| Expecting auto-orchestration | Nothing happens | You start each agent manually. MOSAIC provides context, not automation. |

## How It Actually Works (No Magic)

1. `hive init` copies structured markdown templates into your project
2. You fill in project context, tasks, and conventions
3. Every agent reads `AGENTS.md` first — it points to `.hive/` for context
4. `hive ensemble start` creates git worktrees so agents can work in parallel directories
5. `hive relay` archives transfer notes so the next agent has handoff context
6. `hive ensemble merge` merges branches back and cleans up worktrees
7. Shared memory (decisions, learnings, dead-ends) persists across all sessions

**The value is not in the CLI. The value is in every agent reading the same structured context.**

## Design Principles

1. **Filesystem is the universal bus** — every agent can read/write files
2. **Markdown is the universal language** — every agent understands markdown
3. **Human is always the orchestrator** — framework assists, never replaces
4. **Convention first, automation second** — usable immediately with zero tooling
5. **Incremental adoption** — start with relay, add parallel when you need it
