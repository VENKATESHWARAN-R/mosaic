# /hive-init

Initialize the MOSAIC `.hive/` structure in the current project.

## Instructions

When the user invokes `/hive-init`:

### 1. Check Preconditions

- Verify we're in a git repository (warn if not, but continue)
- Check if `.hive/` already exists (abort if so, suggest manual cleanup)

### 2. Create Structure

Create the following directory structure and files:

```
.hive/
├── config.yaml
├── roster.yaml
├── context/
│   ├── project-brief.md
│   └── conventions.md
├── tasks/
│   ├── backlog.md
│   └── active.md
├── sessions/
│   └── current.md
├── transfers/
│   ├── TEMPLATE.md
│   └── archive/
├── memory/
│   ├── decisions.md
│   ├── dead-ends.md
│   └── learnings.md
└── workflows/
    ├── solo-sprint.md
    ├── relay-race.md
    ├── team-parallel.md
    └── full-orchestra.md
```

### 3. Create AGENTS.md

If `AGENTS.md` doesn't exist at the project root, create it from the template.
If it does exist, add a section pointing to `.hive/` resources.

### 4. Configure Project

Ask the user for:
- Project name and brief description
- Primary programming language / framework
- Build, test, and lint commands

Update `.hive/config.yaml` and `.hive/context/project-brief.md` with answers.
Update `AGENTS.md` with the build/test/lint commands.

### 5. Update .gitignore

Append MOSAIC-specific ignores if not already present:
```
# MOSAIC
.hive/sessions/current.md
.hive/transfers/latest.md
```

### 6. Initial Commit

Stage and commit:
```bash
git add .hive/ AGENTS.md .gitignore
git commit -m "chore: initialize MOSAIC .hive/ structure"
```

### 7. Report

Show the user:
- What was created
- Quick start: "Start working by editing `.hive/tasks/active.md`"
- Available workflows: list the 4 workflow patterns
