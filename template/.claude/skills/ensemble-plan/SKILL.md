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
| Stream | Branch | Agent | Subtask | Depends On |
|--------|--------|-------|---------|------------|
| A | stream/[name-a] | [agent] | [description] | contracts |
| B | stream/[name-b] | [agent] | [description] | contracts |

### Merge Order
1. stream/[name-a] → main
2. stream/[name-b] → main (resolve conflicts if any)

### Risk Assessment
- Conflict risk: [low/medium/high]
- Areas of potential overlap: [files/modules]
```

### 3. Execute (after user approval)

1. Create and commit shared contracts if any
2. Create branches:
   ```bash
   git checkout -b stream/[name-a]
   git checkout main
   git checkout -b stream/[name-b]
   git checkout main
   ```
3. Update `.hive/tasks/active.md` with all subtasks
4. Log the decomposition decision in `.hive/memory/decisions.md`
5. Show the user the commands to start each agent in separate terminals
