# Workflow: Team Parallel (Concurrent Execution)

> Multiple agents work simultaneously on independent subtasks, each in its own worktree.
> Human decomposes the work upfront and merges when done.

## When to Use

- Task can be cleanly decomposed into independent pieces
- You have access to multiple agent CLIs
- Subtasks don't share the same files (minimal merge conflicts)
- You want to maximize throughput

## Prerequisites

- Clear task decomposition with minimal overlap
- Shared contracts defined upfront (interfaces, types, APIs) to prevent conflicts
- Git repository (worktrees require git)

## How It Works

`hive ensemble start` creates **git worktrees** — separate directories, each with a full
copy of the repo on its own branch. This means two agents can work at the same time in
different directories without any git conflicts until merge time.

```
your-project/
├── .hive/worktrees/
│   ├── subtask-a/    ← full repo copy, branch: stream/subtask-a
│   └── subtask-b/    ← full repo copy, branch: stream/subtask-b
├── src/              ← main branch (untouched while agents work)
└── ...
```

**Why not `git checkout` in two terminals?** Because both terminals share the same working
directory. The second checkout changes the branch for everyone. Worktrees solve this.

## Steps

### 1. Human: Plan & Decompose

```bash
# Break the task into independent subtasks
# Define shared contracts (interfaces, types, API signatures)
# Commit contracts to main BEFORE creating streams

# Create parallel worktrees:
hive ensemble start subtask-a subtask-b

# Update .hive/tasks/active.md with all subtasks
# Document the decomposition in .hive/memory/decisions.md
```

### 2. Human: Assign & Launch

```bash
# Terminal 1 — Agent A works in its own directory
cd .hive/worktrees/subtask-a
claude   # or whatever agent

# Terminal 2 — Agent B works in its own directory (simultaneously)
cd .hive/worktrees/subtask-b
gemini   # or whatever agent
```

Each agent:
1. Reads `AGENTS.md` (present in the worktree — it's a full repo copy)
2. Checks `.hive/tasks/active.md` for their assigned subtask
3. Works on their subtask ONLY
4. Commits to their branch frequently
5. Creates transfer note when done

### 3. Human: Merge

```bash
# Return to the project root (NOT a worktree)
cd /path/to/your-project

# Merge all streams, clean up worktrees and branches
hive ensemble merge
```

## Shared Contracts Pattern

To prevent conflicts, define interfaces before branching:

```
# Example: Two agents building features that share a data model
# BEFORE creating streams, commit:

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
4. **Each agent stays in its worktree** — never cd between worktrees mid-session
5. **Commit before merge** — uncommitted changes in worktrees will block the merge

## CLI Shortcut

If using Claude Code with MOSAIC skills:
```
/ensemble-plan    # Decompose, create worktrees, and assign agents
```
