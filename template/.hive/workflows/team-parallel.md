# Workflow: Team Parallel (Concurrent Execution)

> Multiple agents work simultaneously on independent subtasks, each on its own branch.
> Human decomposes the work upfront and merges when done.

## When to Use

- Task can be cleanly decomposed into independent pieces
- You have access to multiple agent CLIs
- Subtasks don't share the same files (minimal merge conflicts)
- You want to maximize throughput

## Prerequisites

- Clear task decomposition with minimal overlap
- Shared contracts defined upfront (interfaces, types, APIs) to prevent conflicts
- Separate git branches for each stream

## Steps

### 1. Human: Plan & Decompose

```
1. Break the task into independent subtasks
2. Define shared contracts (interfaces, types, API signatures)
   - Commit these to main BEFORE branching
3. Create branches:
   git checkout -b stream/subtask-a
   git checkout main
   git checkout -b stream/subtask-b
4. Update .hive/tasks/active.md with all subtasks
5. Document the decomposition in .hive/memory/decisions.md
```

### 2. Human: Assign & Launch

```
Terminal 1 (on stream/subtask-a):
  $ cd project && git checkout stream/subtask-a
  $ claude   # or whatever agent

Terminal 2 (on stream/subtask-b):
  $ cd project && git checkout stream/subtask-b
  $ gemini   # or whatever agent
```

Each agent:
```
1. Read AGENTS.md
2. Check .hive/tasks/active.md for their assigned subtask
3. Update .hive/sessions/current.md (note: may conflict — that's OK)
4. Work on their subtask ONLY
5. Commit to their branch frequently
6. Create transfer note when done
```

### 3. Human: Monitor & Merge

```
1. Check progress in each terminal
2. When all streams complete:
   git checkout main
   git merge stream/subtask-a
   git merge stream/subtask-b
3. Resolve any conflicts
4. Run full test suite
5. Clean up branches
```

## Shared Contracts Pattern

To prevent conflicts, define interfaces before branching:

```
# Example: Two agents building features that share a data model
# BEFORE branching, commit:

# types/user.ts (the contract)
interface User {
  id: string;
  name: string;
  email: string;
}

# Agent A builds: user registration (uses User interface)
# Agent B builds: user profile page (uses User interface)
# No conflict because both consume the same contract
```

## Safety Rules

1. **Never merge without running tests** on the merged result
2. **Define contracts first** — this is the most common failure point
3. **Keep subtasks truly independent** — if they touch the same files, use Relay Race instead
4. **Each agent stays on its branch** — never switch branches mid-session

## CLI Shortcut

If using Claude Code with MOSAIC skills:
```
/ensemble-plan    # Decompose and create branches
```
