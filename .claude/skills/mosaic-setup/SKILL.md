# /mosaic-setup — User Configuration

Configure MOSAIC for a user's specific agent setup after cloning.

## Instructions

Walk the user through configuring MOSAIC for their installed agents.

### Step 1: Detect Available Agents

Ask the user which agents they have installed. Present these options:
- Claude Code (`claude`)
- Gemini CLI (`gemini`)
- Codex CLI (`codex`)
- OpenCode (`opencode`)
- Other (let them specify)

For each selected agent, verify it's available by running `which <cli-command>`. Report which are found and which are missing.

### Step 2: Set Primary Agent

Ask which agent should be the primary (conductor) agent. This determines which agent is best suited for orchestration tasks.

### Step 3: Update Roster

Edit `template/.hive/roster.yaml`:
- Keep entries for selected agents
- Remove entries for agents the user doesn't have
- Mark the primary agent with `primary: true`
- If the user specified custom agents, add entries for them

### Step 4: Update Template Agent Files

Based on selections:
- If they don't use Gemini CLI, offer to remove `template/GEMINI.md`
- If they don't use Claude Code, note that skills/agents won't work (MOSAIC is Claude-native for orchestration)
- Keep `template/AGENTS.md` regardless — it's the universal file

### Step 5: Update Executor Agents

In `template/.claude/agents/`:
- Remove executor agents for CLIs the user doesn't have
  - No Gemini? Remove `gemini-executor.md`
  - No Codex? Remove `codex-executor.md`
  - No OpenCode? Remove `opencode-executor.md`
- If the user specified custom agents, offer to create executor wrappers for them

### Step 6: Summary

Show what was changed:
```
## Configuration Complete

Agents configured: claude (primary), gemini
Removed: codex-executor.md, opencode-executor.md
Roster updated: template/.hive/roster.yaml

You're ready to use MOSAIC! Run `hive init` in any project to get started.
```
