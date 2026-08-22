# Recording Studio Cursor plugin

A Cursor plugin that stores **skills** and **agents** for Recording Studio work, so they can be installed from git or submitted to the [Cursor Marketplace](https://cursor.com/marketplace).

This is not a Rails gem and not a VS Code extension. Cursor loads the markdown and JSON in this repo as reusable AI components.

## What you get

### Agents

Specialists the main agent can delegate to:

| Agent | Use for |
| --- | --- |
| `project-manager` | Triage and split work across specialists |
| `rails-expert` | Implement or fix Rails code |
| `rails-security-expert` | Security review |
| `rails-refactoring-specialist` | Small, behavior-preserving refactors |
| `code-review-advisor` | Post-implementation review |
| `ui-style-expert` | Flatpack-first screens |
| `minitest-coverage` | Engine and dummy-app tests |

### Skills

Workflows Cursor can apply in the current chat:

| Skill | Use when |
| --- | --- |
| `recording-studio-getting-started` | Mapping a new app: setup order |
| `recording-studio-gems` | Approved ecosystem gems instead of third-party substitutes |
| `recording-studio-new-gem` | New addon from the gem template, then rename it |
| `add-skill-or-agent` | Saving a new skill or agent into this plugin |
| `recording-studio-big-picture` | Architecture, roots/actors, and gem/UI philosophy |
| `recording-studio-new-recordable` | Declaring a new recordable type |
| `recording-studio-data-shape` | Whether something is a Recording, Event, Log, or a separate table |
| `recording-studio-saving` | Saving recordings, recordables, and log events |
| `recording-studio-capabilities` | Opt-in mixins (move, trash, attach, …) |
| `recording-studio-ui` | UI slices, mount points, and replaceable gem views |
| `recording-studio-text` | Fun, short product text with a human voice |
| `recording-studio-flatpack` | Which Flatpack components to render |
| `recording-studio-taste` | Critique and compose screens so they do not look templated (Flatpack execution) |
| `recording-studio-redesign` | Audit an existing screen and upgrade it in Flatpack |
| `recording-studio-output` | Finish the whole deliverable; no truncated screens or critiques |
| `recording-studio-image-to-code` | Generate section images, then build the page in Flatpack |
| `recording-studio-soft` | Opt-in soft / expensive host theme direction |
| `recording-studio-minimalist` | Opt-in editorial host theme (dummy / gem / Admin stay rounded) |
| `recording-studio-brutalist` | Opt-in Swiss-print or terminal host theme |
| `recording-studio-brandkit` | Brand-kit image boards; Flatpack only on handoff to code |
| `recording-studio-imagegen-web` | One horizontal marketing-section image per section |
| `recording-studio-imagegen-mobile` | Mobile app screen images only |
| `recording-studio-admin` | Admin root, Accessible, and high-signal widgets |
| `recording-studio-access` | Hierarchy access grants for any actor |
| `recording-studio-api` | Capability actions, AI access, user vs admin APIs |
| `recording-studio-tests` | Adding or reviewing gem and dummy-app tests |

### Commands

- `/add-skill` — scaffold a new skill in this repo
- `/add-agent` — scaffold a new specialist agent

## Install locally while authoring

```bash
ln -s /path/to/RecordingStudio_cursor_plugin ~/.cursor/plugins/local/recording-studio
```

Reload the Cursor window. Open **Customize** and confirm the plugin's skills and agents are listed.

## Save a new skill or agent

This repo is the place to keep them.

1. Run `/add-skill` or `/add-agent`, or follow [docs/adding-skills-and-agents.md](docs/adding-skills-and-agents.md).
2. Run `node scripts/validate-plugin.mjs`.
3. Commit, push, and (for marketplace listings) bump `version` in `.cursor-plugin/plugin.json`.

## Publish

Public marketplace: submit this repo at [cursor.com/marketplace/publish](https://cursor.com/marketplace/publish).

Private team install: **Dashboard → Plugins → Add Marketplace** and import the GitHub repo.

Details: [docs/publishing.md](docs/publishing.md).

## Layout

```text
.cursor-plugin/plugin.json   # required manifest
.cursor/environment.json     # Cloud Agent environment
agents/                      # specialist subagents
skills/                      # reusable workflows
commands/                    # slash commands
rules/                       # standing guidance
assets/logo.svg
docs/
scripts/validate-plugin.mjs
```

How loading works: [docs/how-it-works.md](docs/how-it-works.md).

## Validate

```bash
node scripts/validate-plugin.mjs
```

The same command runs in GitHub Actions on pull requests.

Cloud Agents use `.cursor/environment.json`. The default image already includes Node 22, which is enough to run the validator. There is no package install, database, or dev server.

## License

MIT

Taste and branding skills are adapted from [leonxlnx/taste-skill](https://github.com/leonxlnx/taste-skill) (MIT, Leonxlnx). Attribution: [docs/taste-skill-attribution.md](docs/taste-skill-attribution.md).
