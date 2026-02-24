# /mosaic-doctor — Health Check

Validate that the MOSAIC project is internally consistent and well-formed.

## Instructions

Run through each check below. Report results as PASS/WARN/FAIL with details.

### Check 1: Template Structure

Verify these template files exist:
- `template/.hive/config.yaml`
- `template/.hive/roster.yaml`
- `template/.hive/tasks/active.md`
- `template/.hive/tasks/backlog.md`
- `template/.hive/sessions/current.md`
- `template/.hive/transfers/TEMPLATE.md`
- `template/.hive/transfers/archive/.gitkeep`
- `template/.hive/memory/decisions.md`
- `template/.hive/memory/learnings.md`
- `template/.hive/memory/dead-ends.md`
- `template/.hive/context/project-brief.md`
- `template/.hive/context/conventions.md`
- `template/.hive/workflows/solo-sprint.md`
- `template/.hive/workflows/relay-race.md`
- `template/.hive/workflows/team-parallel.md`
- `template/.hive/workflows/full-orchestra.md`
- `template/AGENTS.md`
- `template/CLAUDE.md`
- `template/GEMINI.md`
- `template/.gitignore`

### Check 2: CLI References

Read `bin/hive` and verify:
- `cmd_init()` copies all template directories that exist
- VERSION variable matches latest CHANGELOG.md version
- All commands referenced in `cmd_help()` have corresponding functions

### Check 3: Roster Consistency

Read `template/.hive/roster.yaml` and verify:
- Each agent listed has a valid `cli_command`
- Agents with executor wrappers have matching files in `template/.claude/agents/`
- No orphaned executor agents (agents in `.claude/agents/` not in roster)

### Check 4: Skills Consistency

For each skill in `template/.claude/skills/`:
- Verify `SKILL.md` exists and is non-empty
- Check that any file paths referenced in the skill actually exist

### Check 5: README Accuracy

Compare `README.md` against actual features:
- CLI commands listed match `bin/hive` commands
- Skills listed match `template/.claude/skills/`
- Agents listed match `template/.claude/agents/`
- Workflow names match `template/.hive/workflows/`

### Output Format

```
## MOSAIC Doctor Report

### Template Structure
- [PASS] All 20 template files present

### CLI References
- [PASS] cmd_init copies all template dirs
- [WARN] VERSION (1.0.0) doesn't match CHANGELOG (1.1.0)

### Roster Consistency
- [PASS] All roster agents have executor wrappers
- [FAIL] orphaned executor: aider-executor.md not in roster

### Skills Consistency
- [PASS] All 4 template skills valid

### README Accuracy
- [WARN] README lists /foo skill but it doesn't exist

### Summary: X passed, Y warnings, Z failures
```
