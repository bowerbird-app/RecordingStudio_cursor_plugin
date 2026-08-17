# Adding skills and agents

Use this plugin as the source of truth for Recording Studio skills and agents. Saving them here means they can be reviewed in git, installed by the team, and submitted to the Cursor Marketplace.

## Quick path in Cursor

After the plugin is installed or symlinked locally:

- `/add-skill` scaffolds a new skill
- `/add-agent` scaffolds a new specialist agent
- The `add-skill-or-agent` skill has the full checklist

## Add a skill by hand

1. Create `skills/<name>/SKILL.md`.
2. Match the folder name to the frontmatter `name`.
3. Write a `description` that says what it does **and when to use it**. Cursor uses that text to decide whether to invoke the skill.

```markdown
---
name: example-skill
description: What it does. Use when <trigger>.
---

# Example skill

## When to use
- Trigger

## Instructions
1. Step
```

Optional extras in the same folder:

- `scripts/` for helper commands
- `references/` for longer docs loaded on demand
- `assets/` for templates or images

## Add an agent by hand

1. Create `agents/<name>.md`.
2. Include `name` and `description` frontmatter.
3. Put the specialist prompt in the body. Keep one job per agent.

```markdown
---
name: example-agent
description: What this specialist does and when to delegate to it.
---

# Example agent

You are ...
```

Optional frontmatter used by Cursor subagents: `model` (default `inherit`), `readonly`, `is_background`.

## Add a command or rule

- Commands: `commands/<name>.md` with `name` and `description`. These become slash commands.
- Rules: `rules/<name>.mdc` with `description` and `alwaysApply` or `globs`.

## After you add something

1. Run `node scripts/validate-plugin.mjs`.
2. Mention it in `README.md` if people should discover it.
3. Note it in `CHANGELOG.md`.
4. Do not put secrets in the plugin. If an MCP server needs a token later, declare the variable **name** in `.cursor-plugin/plugin.json` and let users set the value in **Plugins → Configure**.

## What not to do

- Do not put plugin skills in `.cursor/skills/` if you want them distributed. Cursor project skills stay in that repo only.
- Do not use a root `plugin.json` Agent Plugin manifest here. That format cannot ship custom agents.
- Do not add binaries. Marketplace plugins are markdown, JSON, and scripts.
