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

For each subtask, the conductor invokes the appropriate agent:

```
# Via subagent wrappers (Claude Code specific):
- Use @gemini-executor for large codebase analysis
- Use @codex-executor for focused implementation
- Use @opencode-executor for general tasks

# Via manual handoff (any agent):
- Create transfer note with specific subtask instructions
- Human starts the target agent
- Agent works and creates completion transfer note
- Human returns to conductor
```

### 3. Conductor: Synthesize

After all subtasks complete:

```
1. Review results from each agent/subtask
2. Integrate the pieces
3. Run full test suite
4. Handle any conflicts or gaps
5. Create final transfer note summarizing the full orchestration
```

## Orchestration Patterns

### Fan-Out / Fan-In
```
Conductor → [Agent A, Agent B, Agent C] → Conductor merges
```
Best for: independent analysis tasks, parallel implementations on separate branches.

### Pipeline
```
Conductor → Agent A (analyze) → Agent B (implement) → Agent C (review) → Conductor
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
  2. [Claude] Design auth architecture based on analysis
  3. [Codex] Implement auth middleware (branch: feat/auth-middleware)
  4. [Codex] Implement login/signup routes (branch: feat/auth-routes)
  5. [Claude] Review, integrate, and test
```

## Tips

- The conductor should keep a running summary in `.hive/tasks/active.md`
- Use `.hive/memory/decisions.md` to track routing rationale
- When a delegated agent produces unexpected results, log in `.hive/memory/learnings.md`
- Don't over-orchestrate simple tasks — use Solo Sprint or Relay Race instead
