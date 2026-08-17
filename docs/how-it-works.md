# How this plugin works

This repository is a **Cursor plugin**. Cursor loads it as a bundle of skills, agents, rules, and commands. It is not a VS Code extension and it is not a Ruby gem.

## Why a plugin

Cursor can keep skills and agents in a project (`.cursor/skills`, `.cursor/agents`) or in your user folder (`~/.cursor/skills`, `~/.cursor/agents`). Those copies stay on one machine.

A plugin is the distribution format:

- Skills and agents live in git.
- Anyone on the team can install the same set.
- The same repo can be submitted to the [Cursor Marketplace](https://cursor.com/marketplace) or imported as a team marketplace.

This repo uses the **Cursor Plugin** format so it can ship agents as well as skills. The Agent Plugins open standard only covers skills and MCP servers.

## What Cursor loads

| Folder | Component | When it shows up |
| --- | --- | --- |
| `.cursor-plugin/plugin.json` | Manifest | Required. Identifies the plugin. |
| `skills/*/SKILL.md` | Skills | Listed under Customize → Skills. Cursor can auto-invoke them from the description, or you can run `/skill-name`. |
| `agents/*.md` | Agents | Custom subagents. The parent agent can delegate, or you can invoke `/agent-name`. |
| `commands/*.md` | Commands | Slash commands such as `/add-skill`. |
| `rules/*.mdc` | Rules | Persistent guidance. `alwaysApply: true` is included in every chat. |
| `assets/logo.svg` | Logo | Marketplace and Customize listing. |

Cursor discovers these folders automatically. The manifest does not list each file.

## Skill vs agent vs command vs rule

- **Skill**: a reusable workflow in the current conversation. Use for checklists and "how to do X".
- **Agent**: a specialist with its own context window. Use when you want a focused reviewer or implementer.
- **Command**: a slash-command shortcut that starts a known prompt.
- **Rule**: standing guidance that should not have to be re-explained.

## Local load path

For day-to-day authoring, symlink this repo into Cursor's local plugin directory:

```bash
ln -s /path/to/RecordingStudio_cursor_plugin ~/.cursor/plugins/local/recording-studio
```

Reload the Cursor window. Components appear under **Customize**.

Marketplace install uses the public git repo instead of a local symlink. The file layout is the same either way.

## Validation

`node scripts/validate-plugin.mjs` checks:

- `plugin.json` parses and has a valid kebab-case `name`
- referenced paths exist and stay inside the repo
- skills, agents, commands, and rules have the required YAML frontmatter

Run it after adding or renaming a component. GitHub Actions runs the same script on pull requests.

## Cloud Agents

`.cursor/environment.json` is the environment source for Cloud Agents. This plugin has no gem, npm packages, or running app, so install only confirms Node is available. Use `node scripts/validate-plugin.mjs` after checkout to check the plugin itself.

## Related docs

- [Adding skills and agents](adding-skills-and-agents.md)
- [Publishing to the Cursor Marketplace](publishing.md)
- [Cursor plugin reference](https://cursor.com/docs/reference/plugins.md)
- [Skills](https://cursor.com/docs/skills.md)
- [Subagents](https://cursor.com/docs/subagents.md)
