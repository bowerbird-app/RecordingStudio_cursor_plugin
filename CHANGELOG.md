# Changelog

## 0.1.0

- Add the Cursor plugin manifest (`.cursor-plugin/plugin.json`).
- Package Recording Studio specialist agents for Rails, security, refactoring, tests, UI, and review.
- Add skills for saving new skills/agents, writing through Recording Studio, Flatpack UI, and Minitest.
- Add slash commands for creating a new skill or agent in this plugin.
- Document local install, how the plugin works, and marketplace publishing.
- Add `node scripts/validate-plugin.mjs` and a GitHub Action that runs it on pull requests.
- Add `.cursor/environment.json` so Cloud Agents boot with Node available for the validator.
- Update the Minitest skill and agent to require both gem and dummy-app suites, and to treat ~94% coverage as the usual working target.
- Add a `recording-studio-approach` skill covering Basecamp-style delegation, reusable gem composition, UI slices, and defaults-first configuration.
- Expand `recording-studio-approach` with roots-as-buckets, actors vs users, root-scoped billing, and hierarchy.
- Distinguish logs from recordings and events for caused-but-unowned operational data.
- Add a `setup-admin-screens` skill for Recording Studio Admin plus Accessible setup.
