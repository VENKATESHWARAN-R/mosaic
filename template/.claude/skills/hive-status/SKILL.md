# /hive-status

Show the current state of the MOSAIC framework.

## Instructions

When the user invokes `/hive-status`, gather and display the following:

1. **Read state files**:
   - `.hive/sessions/current.md` — active session info
   - `.hive/tasks/active.md` — current tasks and progress
   - `.hive/transfers/latest.md` — most recent transfer note (if exists)

2. **Gather git context**:
   - Current branch: `git branch --show-current`
   - Uncommitted changes: `git status --short`
   - Recent commits: `git log --oneline -5`

3. **Display a dashboard** in this format:

```
## MOSAIC Status

### Session
- Agent: [name or none]
- Working on: [task or none]
- Since: [timestamp or N/A]

### Active Tasks
- [TASK-XXX]: [title] — [status] ([subtasks completed]/[total])
  ...

### Latest Transfer
- From: [agent] at [time]
- Status: [status]
- Summary: [1-line summary]

### Git State
- Branch: [branch]
- Uncommitted changes: [count]
- Last commit: [hash] [message]
```

4. **Flag any issues**:
   - Stale session (no update in >30 min based on config)
   - Tasks marked in-progress with no active session
   - Uncommitted changes that might be lost
