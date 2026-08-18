---
name: build-recording-studio-gem
description: Start a new Recording Studio addon from RecordingStudio_gem_template, rename it, and strip leftover template identity. Use when creating or extracting a recording-studio-* gem, scaffolding an engine, or when a new gem still says it is a template.
---

# Build a Recording Studio gem

Do not start a Recording Studio addon from `rails plugin new` or a blank gem. Start from **[RecordingStudio_gem_template](https://github.com/bowerbird-app/RecordingStudio_gem_template)** so the dummy app, Flatpack, Recording Studio v3 declarations, and both test suites are already in place.

A host app stays thin. Shared behaviour lives in a **reusable gem** with a UI slice and an API slice (`recording-studio-ui`, `recording-studio-api`).

## 1. Copy the template

Create a new repo from the template (GitHub “Use this template”, or clone and reset origin). Name the repo like the others: `RecordingStudio_webhooks`, `RecordingStudio_moveable`.

Do not keep developing in the template repo itself.

## 2. Rename it for real

The template still calls itself `gem_template` / `GemTemplate`. Run the shipped renamer **before** writing features:

```bash
bin/rename_gem recording_studio_webhooks
# preview first:
bin/rename_gem recording_studio_webhooks --dry-run
```

Use snake_case that matches the Rubygems name (`recording_studio_moveable`, not `RecordingStudioMoveable`). The script rewrites modules, gemspec, lib paths, and controllers.

Then **search for leftovers**. The renamer updates identity, but it does not make the repo read like a finished addon. Fix anything that still sounds like a template:

| Still template | Make it the gem |
|---|---|
| README titled “GemTemplate” / “internal template” | Product README for *this* addon |
| Gemspec summary/description about the template | What the gem actually does |
| Dummy sidebar “starter docs” copy | Docs for this capability |
| `example_service`, sample home controller | Real core methods and screens |
| Homepage still pointing at the template repo | This gem’s GitHub URL |
| Comments and titles that say “example” or “template” | Domain language |

`docs/gem_template/` is left as architectural reference on purpose. Do not treat it as the public README. Rewrite `README.md` so a stranger can install *this* gem without knowing it used to be a template.

Dummy login (`admin@admin.com`) can stay for the dummy app. It is not product copy (`recording-studio-copy`).

## 3. Shape the addon

1. Decide the **capability** (one job: move, trash, webhooks, …). Follow `recording-studio-capabilities` if it is a mixin.
2. Put behaviour in **core methods** the UI, API, and host overrides can share.
3. Ship default **views and controllers** in the gem. Host apps own **routes**.
4. Distinctive chrome (a switcher, a picker) is a **helper or ViewComponent**, not only a gem template (`recording-studio-ui`).
5. Enable the capability **on the types that need it**. Installing the gem must not silently turn it on for every recordable.
6. Register the same actions on the API (`recording-studio-api`).
7. Add admin only if staff operate this capability — a few high-signal widgets, not a vanity dashboard (`setup-admin-screens`).

Keep the dummy app as a **host that proves the gem**. Demo the primary behaviour on the home page. Do not turn dummy into the product.

## 4. Tests and release

Cover the gem suite (`test/`) and the dummy suite (`test/dummy/test/`). Dummy tests should prove the engine **mounts**, initializers run, and Accessible (when used) actually gates the action (`minitest-workflow`).

Bump the gem version once per branch, add changelog and upgrade notes, keep public APIs stable.

## Do not

- Scaffold a Rails engine from scratch “to stay simpler.”
- Ship a gem whose README, gemspec, or module names still say template / GemTemplate / example.
- Put one-app-only behaviour in a gem, or dump a reusable capability into the host.
- Copy gem views into the host so you can tweak them. Override only what must differ.

## Related skills

| Need | Skill |
|---|---|
| Setup order | `getting-started-recording-studio` |
| Mixin enablement | `recording-studio-capabilities` |
| UI slices | `recording-studio-ui` |
| API slice | `recording-studio-api` |
| Tests | `minitest-workflow` |
