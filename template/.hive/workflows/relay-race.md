# Workflow: Relay Race (Sequential Handoff)

> Agent A works, creates a transfer note, Agent B picks up and continues.
> The core workflow for switching between agents.

## When to Use

- Switching agents mid-task (subscription limit, different strengths needed)
- Handing off between work sessions
- Any sequential multi-agent collaboration

## Steps

### Agent A: Finish & Hand Off

```
1. Complete current work to a stable stopping point
2. Commit all changes with clear messages
3. Run tests to document current state
4. Create transfer note:
   a. Copy .hive/transfers/TEMPLATE.md
   b. Fill in ALL sections thoroughly
   c. Save as .hive/transfers/latest.md
   d. Archive any previous latest.md to .hive/transfers/archive/
5. Update .hive/tasks/active.md:
   - Check off completed subtasks
   - Add remaining subtasks if discovered
6. Update .hive/sessions/current.md:
   - Clear active session
   - Add completion log entry
7. Commit the .hive/ changes
```

### Human: Switch Agents

```
1. Review the transfer note (.hive/transfers/latest.md)
2. Optionally add human notes to the transfer
3. Start the next agent (e.g., `gemini`, `codex`, `claude`)
```

### Agent B: Pick Up & Continue

```
1. Read AGENTS.md (automatic for most agents)
2. Read .hive/transfers/latest.md — this is your primary context
3. Read the files listed in "Files of Interest"
4. Read .hive/tasks/active.md for remaining work
5. Update .hive/sessions/current.md with your info
6. Continue the work from "What Remains"
7. When done, create your own transfer note (repeat cycle)
```

## Transfer Note Quality Checklist

A good transfer note should let Agent B start working **without reading any other files first**. Verify:

- [ ] Summary is clear and self-contained
- [ ] All modified files are listed
- [ ] Key decisions include rationale
- [ ] Current state includes branch, commit, test status
- [ ] "What Remains" has specific, actionable items
- [ ] Blockers/warnings mention any gotchas
- [ ] Files of Interest lists the most important files to read

## Common Pitfalls

- **Too-brief transfer notes**: "I worked on auth" is useless. Be specific.
- **Missing decision rationale**: The next agent will question your choices without context.
- **Uncommitted changes**: Always commit before handoff.
- **Stale task state**: Update active.md to reflect reality.

## CLI Shortcut

If using Claude Code with MOSAIC skills:
```
/relay-handoff
```
This automates transfer note creation and state updates.
