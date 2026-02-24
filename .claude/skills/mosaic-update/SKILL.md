# /mosaic-update — Framework Evolution

Research the latest agent CLI ecosystem changes and update MOSAIC accordingly.

## Usage

```
/mosaic-update                    # Full research across all ecosystems
/mosaic-update claude             # Only research Claude Code updates
/mosaic-update gemini             # Only research Gemini CLI updates
/mosaic-update codex              # Only research Codex CLI updates
/mosaic-update agents.md          # Only research AGENTS.md standard
```

## Instructions

You are updating the MOSAIC multi-agent orchestration framework. Follow these phases:

### Phase 1: Research (delegate to @framework-researcher)

Based on the user's scope (or all if unspecified), research:

- **Claude Code**: Latest features — skills, hooks, agents/subagents, teams, MCP servers, settings, CLAUDE.md conventions. Search for "Claude Code CLI features 2025 2026", "Claude Code agents", "Claude Code skills".
- **Codex CLI**: Latest OpenAI Codex CLI features. Search for "OpenAI Codex CLI features 2025 2026".
- **Gemini CLI**: Latest Google Gemini CLI features. Search for "Google Gemini CLI features 2025 2026", "GEMINI.md".
- **OpenCode**: Latest OpenCode features. Search for "OpenCode CLI AI coding 2025 2026".
- **AGENTS.md standard**: Evolution of the AGENTS.md convention. Search for "AGENTS.md standard specification 2025 2026".

Delegate this research to the `@framework-researcher` agent to keep the main context clean.

### Phase 2: Analysis

Compare research findings against current MOSAIC template files:
- Read `template/AGENTS.md`, `template/CLAUDE.md`, `template/GEMINI.md`
- Read `template/.hive/roster.yaml`
- Read `template/.claude/skills/` and `template/.claude/agents/`
- Read `bin/hive`

Identify gaps: what's in the latest standards that MOSAIC doesn't support yet?

### Phase 3: Proposal

Present findings to the user as a structured list:

```
## Research Summary
[What was found]

## Proposed Updates
1. [Update description] — [which files affected]
2. ...

## No Action Needed
- [Things that are already up to date]
```

Do NOT auto-apply changes. Wait for user approval.

### Phase 4: Apply (after user approval)

For each approved update:
1. Modify the relevant template files
2. Update `bin/hive` if the CLI needs changes
3. Update `README.md` if features changed
4. Bump version in `bin/hive` VERSION variable

### Phase 5: Changelog

Append an entry to `CHANGELOG.md` with:
- New version number (bump minor for features, patch for fixes)
- Date
- List of changes under appropriate headers (Added/Changed/Fixed/Removed)
