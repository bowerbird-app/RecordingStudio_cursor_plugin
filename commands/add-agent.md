---
name: add-agent
description: Save a new specialist agent into this Recording Studio Cursor plugin.
---

# Add an agent

Create a new specialist agent in this plugin so Cursor can delegate to it.

Follow the `add-skill-or-agent` skill.

1. Ask for the agent name, when to delegate to it, and the specialist prompt.
2. Add `agents/<name>.md` with `name` and `description` frontmatter.
3. Keep the prompt scoped to one job.
4. Run `node scripts/validate-plugin.mjs`.
5. Update `README.md` and `CHANGELOG.md`.
