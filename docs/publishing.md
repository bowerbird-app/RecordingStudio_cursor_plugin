# Publishing to the Cursor Marketplace

The public Cursor Marketplace is curated. You submit a public git repo; Cursor reviews it by hand. Updates are reviewed again.

## Before you submit

- This repo is public: https://github.com/bowerbird-app/RecordingStudio_cursor_plugin
- `.cursor-plugin/plugin.json` has a unique kebab-case `name` (`recording-studio`)
- `description`, `author`, `license`, and `logo` are set
- Skills, agents, commands, and rules have valid frontmatter
- `README.md` explains install and what is included
- `node scripts/validate-plugin.mjs` passes
- You have tried it locally from `~/.cursor/plugins/local/recording-studio`

## Local test

```bash
ln -s "$PWD" ~/.cursor/plugins/local/recording-studio
```

Reload Cursor. Confirm skills, agents, and `/add-skill` / `/add-agent` appear under **Customize**.

## Public marketplace

1. Push the plugin to this public GitHub repository.
2. Submit the repo URL at https://cursor.com/marketplace/publish
3. Wait for Cursor's review.

Official checklist: https://cursor.com/docs/reference/plugins.md#submitting-a-plugin

Security and listing policy: https://cursor.com/help/security-and-privacy/marketplace-security.md

## Team marketplace

If you only need this inside Bowerbird, skip public review:

1. In Cursor, open **Dashboard → Plugins → Add Marketplace**
2. Import this GitHub repo
3. Choose install mode: Default Off, Default On, or Required

Teams plans get one team marketplace. Enterprise plans can have more.

## After listing

Install from **Customize** or https://cursor.com/marketplace at project or user scope.

When you change skills or agents, bump `version` in `.cursor-plugin/plugin.json`, update `CHANGELOG.md`, and resubmit. Marketplace listings do not auto-update.
