# /ensemble-plan

Decompose a task for parallel multi-agent execution.

## Instructions

When the user invokes `/ensemble-plan`, perform the following:

### 1. Understand the Task

- Ask the user what task they want to parallelize (if not already specified)
- Read `.hive/tasks/active.md` and `.hive/context/architecture.md` for context
- Read `.hive/roster.yaml` to understand available agents

### 2. Decompose

Analyze the task and propose a decomposition:

- Identify independent subtasks that can run in parallel
- Identify shared contracts (interfaces, types, APIs) needed before branching
- Identify dependencies between subtasks
- Recommend which agent should handle each subtask (based on roster routing)

Present the plan to the user for approval:

```
## Ensemble Plan: [Task Title]

### Shared Contracts (commit to main first)
- [ ] [contract 1]: [description]
- [ ] [contract 2]: [description]

### Parallel Streams
| Stream | Worktree | Agent | Subtask | Depends On |
|--------|----------|-------|---------|------------|
| A | .hive/worktrees/[name-a] | [agent] | [description] | contracts |
| B | .hive/worktrees/[name-b] | [agent] | [description] | contracts |

### Merge Order
1. stream/[name-a] → main
2. stream/[name-b] → main (resolve conflicts if any)

### Risk Assessment
- Conflict risk: [low/medium/high]
- Areas of potential overlap: [files/modules]
```

### 3. Execute (after user approval)

1. Create and commit shared contracts if any
2. Create parallel worktrees using the hive CLI:
   ```bash
   hive ensemble start [name-a] [name-b]
   ```
   This creates separate directories under `.hive/worktrees/` — one per stream,
   each on its own git branch. Agents can work simultaneously without interference.
3. Update `.hive/tasks/active.md` with all subtasks
4. Log the decomposition decision in `.hive/memory/decisions.md`
5. Show the user the commands to start each agent:
   ```
   # Terminal 1
   cd .hive/worktrees/[name-a] && [agent-cli]

   # Terminal 2
   cd .hive/worktrees/[name-b] && [agent-cli]
   ```

### Important

- **Do NOT use `git checkout` in separate terminals** — that shares the same working directory.
  `hive ensemble start` creates git worktrees (separate directories) so agents can truly work in parallel.
- Each worktree has the full repo on its own branch.
- When done, the user runs `hive ensemble merge` from the project root.
