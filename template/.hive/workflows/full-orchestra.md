# Workflow: Full Orchestra (Hybrid Orchestration)

> A conductor agent plans, decomposes, delegates to specialist agents, and synthesizes
> results. Combines sequential and parallel patterns.

## When to Use

- Complex tasks requiring multiple agent capabilities
- You want one agent to maintain the "big picture"
- Mix of analysis, implementation, and review needed
- You're comfortable with Claude Code as the orchestrator

## Prerequisites

- Claude Code as the conductor (has subagent capabilities)
- Other agents available via CLI (Gemini, Codex, OpenCode)
- Subagent wrappers configured in `.claude/agents/`

## Steps

### 1. Conductor: Analyze & Plan

The conductor agent (Claude Code) reads the task and creates a plan:

```
1. Read AGENTS.md and .hive/tasks/active.md
2. Analyze the task requirements
3. Decompose into subtasks
4. Decide routing:
   - Which subtasks can be parallel?
   - Which agent is best for each? (consult .hive/roster.yaml)
   - What are the dependencies?
5. Document the plan in .hive/tasks/active.md
6. Log routing decisions in .hive/memory/decisions.md
```

### 2. Conductor: Delegate

For parallel subtasks, create worktrees:
```bash
hive ensemble start subtask-a subtask-b
# Creates .hive/worktrees/subtask-a/ and .hive/worktrees/subtask-b/
```

Then start each agent in its worktree directory:
```bash
# Terminal 1
cd .hive/worktrees/subtask-a && codex

# Terminal 2
cd .hive/worktrees/subtask-b && gemini
```

For sequential subtasks, use relay handoff:
```bash
# Agent A finishes, hand off to Agent B
hive relay claude gemini
gemini   # picks up from .hive/transfers/latest.md
```

Via subagent wrappers (Claude Code specific — stays in one terminal):
- Use `@gemini-executor` for large codebase analysis
- Use `@codex-executor` for focused implementation
- Use `@opencode-executor` for general tasks

### 3. Conductor: Synthesize

After all subtasks complete:

```
1. Merge parallel streams: hive ensemble merge
2. Review results from each agent/subtask
3. Run full test suite
4. Handle any conflicts or gaps
5. Create final transfer note summarizing the full orchestration
```

## Orchestration Patterns

### Fan-Out / Fan-In
```
Conductor → hive ensemble start a b c → agents work in worktrees → hive ensemble merge
```
Best for: independent analysis tasks, parallel implementations on separate modules.

### Pipeline
```
Conductor → Agent A (analyze) → relay → Agent B (implement) → relay → Agent C (review)
```
Best for: tasks that benefit from different perspectives at each stage.

### Iterative Refinement
```
Conductor → Agent A (draft) → Conductor (review) → Agent A (refine) → Done
```
Best for: getting the best output from a single agent with conductor guidance.

## Example: Building a New Feature

```
Task: Add user authentication

Conductor (Claude Code) plans:
  1. [Gemini] Analyze existing codebase for auth patterns (large context)
     → relay handoff, sequential
  2. [Claude] Design auth architecture based on analysis
     → sequential
  3. Parallel phase — hive ensemble start auth-middleware auth-routes:
     [Codex] cd .hive/worktrees/auth-middleware && implement middleware
     [Codex] cd .hive/worktrees/auth-routes && implement login/signup
  4. hive ensemble merge
  5. [Claude] Review, integrate, and test
```

## Tips

- The conductor should keep a running summary in `.hive/tasks/active.md`
- Use `.hive/memory/decisions.md` to track routing rationale
- When a delegated agent produces unexpected results, log in `.hive/memory/learnings.md`
- Don't over-orchestrate simple tasks — use Solo Sprint or Relay Race instead
