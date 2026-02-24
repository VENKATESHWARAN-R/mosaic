# /relay-handoff

Generate a transfer note for handing off to another agent.

## Instructions

When the user invokes `/relay-handoff`, perform the following steps:

1. **Gather session context**:
   - Read `.hive/sessions/current.md` for the active session info
   - Read `.hive/tasks/active.md` for the current task and subtasks
   - Run `git log --oneline -10` to get recent commits
   - Run `git diff --stat HEAD~5..HEAD` to see recent changes (adjust range as needed)
   - Run `git branch --show-current` to get the current branch
   - Run tests if a test command is configured in AGENTS.md

2. **Generate the transfer note**:
   - Use the template from `.hive/transfers/TEMPLATE.md`
   - Fill in all sections based on gathered context
   - Be thorough in "What Was Done" and "What Remains"
   - List all modified files in "Files of Interest"

3. **Archive and save**:
   - If `.hive/transfers/latest.md` exists, move it to `.hive/transfers/archive/` with a timestamped filename (e.g., `2024-01-15T10-30-00_claude-code.md`)
   - Write the new transfer note to `.hive/transfers/latest.md`

4. **Update state files**:
   - Update `.hive/tasks/active.md` — check off completed subtasks, update status
   - Update `.hive/sessions/current.md` — clear active session, add log entry

5. **Commit the changes**:
   - Stage all `.hive/` changes
   - Commit with message: `chore(hive): relay handoff — [brief summary]`

6. **Report to user**:
   - Show a summary of the transfer note
   - Suggest which agent to start next based on `.hive/roster.yaml` routing heuristics
   - Provide the CLI command to start the next agent
