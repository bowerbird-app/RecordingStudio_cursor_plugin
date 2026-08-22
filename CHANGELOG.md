# Changelog

## 0.1.3

- Add a `recording-studio-taste` skill for judging Flatpack composition and when a missing look belongs in Flatpack, not the caller.
- Point `recording-studio-flatpack` and `recording-studio-ui` at that skill for taste, kit evolution, and third-party design packs.
- Thicken `recording-studio-taste` after review: design read, product dials (3 / 2 / 5), Flatpack tokens, interactive cycles, AI tells, and a mechanical pre-flight.
- Make kit review and host named themes first-class in `recording-studio-taste` (Featured In is a Flatpack theme, not a stop).

Upgrade: reload the plugin so Cursor can invoke `recording-studio-taste`. Do not install `leonxlnx/taste-skill` or other generic frontend taste packs.

## 0.1.2

- Document mixin enablement as `include RecordingStudio::Capabilities::<Name>.to(**opts)` only.
- Keep Accessible on `RecordingStudio.enable_capability(:accessible, on: …)`.
- Show Moveable as `.to(allow_cross_root: …)` (keyword-only). Drop `.enabled` / `.with` examples.

Upgrade: enable recordable mixins with `.to`. Accessible still uses `enable_capability`. Do not follow older `.enabled` / `.with` examples.

## 0.1.1

- Expand `recording-studio-data-shape` into the decision guide for Recording vs Recordable vs Event vs Log vs a separate table.
- Spell out hierarchy vs foreign key, objects vs facts, and when not to use a Recording (exhaust, derived data, volume, polymorphism-only).
- Point getting-started, saving, new-recordable, big-picture, the always-on rule, and project-manager at that skill instead of restating it.

## 0.1.0

- Add the Cursor plugin manifest (`.cursor-plugin/plugin.json`).
- Package Recording Studio specialist agents for Rails, security, refactoring, tests, UI, and review.
- Add skills for saving new skills/agents, writing through Recording Studio, Flatpack UI, and Minitest.
- Add slash commands for creating a new skill or agent in this plugin.
- Document local install, how the plugin works, and marketplace publishing.
- Add `node scripts/validate-plugin.mjs` and a GitHub Action that runs it on pull requests.
- Add `.cursor/environment.json` so Cloud Agents boot with Node available for the validator.
- Update the Minitest skill and agent to require both gem and dummy-app suites, and to treat ~94% coverage as the usual working target.
- Add a `recording-studio-big-picture` skill covering Basecamp-style delegation, reusable gem composition, UI slices, and defaults-first configuration.
- Expand `recording-studio-big-picture` with roots-as-buckets, actors vs users, root-scoped billing, and hierarchy.
- Distinguish logs from recordings and events for caused-but-unowned operational data.
- Add a `recording-studio-admin` skill for Recording Studio Admin plus Accessible setup.
- Add a `recording-studio-access` skill for hierarchy-based access grants to any actor type.
- Require Recording Studio Accessible for access control; ask before inventing custom access.
- Add a `recording-studio-api` skill for capability actions, endpoint enablement, and UI/API parity.
- Document AI-agent API access and multiple named APIs for user vs restricted admin surfaces.
- Document gem-owned UI with app-owned routes and targeted view/controller overrides.
- Clarify admin access via an admin root and Accessible, not nominated admin users.
- Add a `recording-studio-getting-started` skill that maps first decisions, core setup, Accessible, and common addons.
- Add a `recording-studio-ui` skill for gem-owned UI slices, mini-apps, one-action screens, and the core default layout.
- Clarify that hosts can replace gem views/controllers, that distinctive UI ships as helpers or ViewComponents, and that each mount point (not the whole gem) navigates like a small app.
- Add a `recording-studio-text` skill for short, plain product text without developer jargon.
- Refine copy voice: playful and clear, little on-screen text, no expert or AI-speak.
- Prefer Flatpack tooltips, popovers, and admin widget extra info for details that would puzzle a newcomer, not walls of on-page help.
- Steer admin sections toward a few high-signal widgets (exceptions, queues, health) instead of vanity totals and a screen per model.
- Add `recording-studio-new-gem`, `recording-studio-capabilities`, and `recording-studio-data-shape` skills.
- Tighten `recording-studio-saving`, `recording-studio-new-recordable`, rails-expert, the always-on rule, and the admin file-tree example so they match those skills.
- DRY the skills: one owner per topic, recaps replaced with pointers, admin no longer duplicates Accessible install.
- Rename product skills to `recording-studio-<topic>` (`text`, `access`, `flatpack`, `admin`, `saving`, `data-shape`, `new-recordable`, and the rest). `add-skill-or-agent` stays — it is this plugin, not the Rails product.
- Add a `recording-studio-gems` skill that lists approved ecosystem gems (webhooks, billing, access, mixins, …) and forbids third-party substitutes.
