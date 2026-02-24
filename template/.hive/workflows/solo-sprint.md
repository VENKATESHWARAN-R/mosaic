# Workflow: Solo Sprint

> Single agent, focused session. The simplest MOSAIC workflow.

## When to Use

- One agent working on a single task
- No handoff planned (but you still want checkpoints)
- Quick fixes, small features, focused debugging

## Steps

### 1. Start Session

```
1. Read AGENTS.md
2. Check .hive/transfers/latest.md (if exists) for prior context
3. Read .hive/tasks/active.md to find your task
4. Update .hive/sessions/current.md:
   - Set your agent name
   - Set the timestamp
   - Set the task you're working on
```

### 2. Work

```
1. Work on the task
2. Commit frequently with clear messages
3. Log any key decisions in .hive/memory/decisions.md
4. Log any failed approaches in .hive/memory/dead-ends.md
```

### 3. Checkpoint / Finish

```
1. Update .hive/tasks/active.md:
   - Check off completed subtasks
   - Update status (completed or in-progress)
2. Create a transfer note from .hive/transfers/TEMPLATE.md
   - Save as .hive/transfers/latest.md
   - Even if you're the only agent, this captures session state
3. Update .hive/sessions/current.md:
   - Clear active session
   - Add log entry
```

## Tips

- Even solo, transfer notes help *you* when you return after a break
- Keep session state updated so other humans can see what's happening
- If you discover something surprising, add it to `.hive/memory/learnings.md`
