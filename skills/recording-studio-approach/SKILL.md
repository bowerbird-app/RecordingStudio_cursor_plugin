---
name: recording-studio-approach
description: Explain the overall Recording Studio architecture and product philosophy. Use when designing features, data models, access, billing ownership, deciding whether to extract a gem, choosing UI shape, or onboarding to the ecosystem.
---

# Recording Studio approach

Recording Studio is an ecosystem of Rails gems built on **Recording Studio core**. The goal is to ship most of an app as reusable, contained gems so new products come together quickly.

For a new app or gem, start with `getting-started-recording-studio`. That skill maps the setup order and the usual addons. This skill is the philosophy behind those choices.

## Core model: Basecamp-style delegation

Core follows a Basecamp-style **Recordings / Recordables / Events** model using Rails `delegated_type`, plus **logs** for high-volume caused-but-unowned data:

| Layer | Role |
| --- | --- |
| **Recording** | Stable identity and capability surface |
| **Recordable** | Immutable snapshot of state (delegated type) |
| **Event** | Append-only history for a recording |
| **Log** | Separate operational history that must not clog recordings |

That split keeps mixins and lifecycle operations on the recording, state versioned on the recordable, and recording history append-only. Prefer public helpers on `RecordingStudio` and `RecordingStudio::Recording` over private registrar internals.

When writing owned content, use the root recording API (`record`, `revise`, `log_event!`). Do not invent parallel write paths for content that belongs in the recording tree.

## Database approach: recordings, recordables, roots, and logs

The main content concepts are **recordings** and **recordables**.

- A **recording** is the durable identity row and mixin surface.
- A **recordable** is the immutable state snapshot the recording currently points at.
- Changing content creates a new recordable and repoints the recording; history for that content stays on **events**.

**Roots** are recordings/recordables that act as the top-level **bucket**. A root is still the same recording/recordable model — it is just declared as a root and owns the tree beneath it.

Think in this order:

1. Create or find the **root** (the bucket).
2. Put owned content under that root through the recording hierarchy.
3. Grant people and systems access to the root.
4. Keep high-volume caused-but-unowned data in **logs**, not recordings.

Do **not** treat users as the main holder of content. Roots hold content. Users are people with access to a bucket.

The same rule applies to billing: **roots hold billing**, not users. That keeps Recording Studio **team-first by default** — a workspace, site, or other root can have many people, shared content, and shared billing without redesigning the data model around a single account owner.

One benefit of this design is a **natural hierarchy**. Recordings nest under parents, so folders, pages, comments, and other content inherit the bucket and tree without a separate ownership system.

### Logs vs recordings and events

Use **logs** for data an actor may have caused, but that they do not own as content, and that should not fill the recordings table.

Examples:

- webhook delivery logs
- inbound request or processing logs
- similar operational trails tied to a root or integration

Guidelines:

- If the user should treat it as first-class content in the tree, it is a **recording/recordable**.
- If it is history of a recording's lifecycle or capability action, it is an **event**.
- If it is caused activity that must stay queryable without becoming owned tree content, it is a **log**.

Logs keep the recordings table focused on the hierarchy people navigate and collaborate on.

## Actors, not only users

When thinking about who can act in the system, think **actors**.

- A **user** is one kind of actor.
- Other actors can include API clients, AI agents, workspaces, or future identities.
- Access still goes through the same **Recording Studio Accessible** concept: grants on recordings in the hierarchy under a root, with the same predictable checks for every actor type.

Design features against actors and root-scoped access. Do not hard-code "only Devise users own everything."

For grant/check details, follow the `recording-studio-accessible` skill.

## Ecosystem of reusable gems

Assume **most of any app is reusable**. Prefer extracting shared behavior into gems over building one-off app code.

- Recording Studio core is the foundation.
- Addon gems are small, focused blocks (`recording-studio-*`) that compose into products.
- Avoid custom gems that only serve one application when the same capability can be abstracted for reuse.
- Capability mixins are opt-in: installing a gem does not silently enable behavior for every recordable type.

Gems are meant to provide a **UI slice** and an **API slice**, so setup stays fast. Prefer gem-owned views and controllers (easy to upgrade), app-owned route choices, and overrides only when the product truly needs them. Register domain actions once, enable them on the right API endpoints, and authorize with Recording Studio Accessible — do not duplicate action logic for JSON. Prefer rich APIs that AI agents can use on a user’s behalf, and separate user vs admin data with multiple named APIs. Follow `recording-studio-api` when exposing APIs.

## Gem-owned UI, app-owned routes

Ship features in three layers so gems stay upgradable and apps stay in control:

| Layer | Owner | Purpose |
| --- | --- | --- |
| **Core methods / services** | Gem (or core) | Stable domain API that UI, API, and custom host code can call |
| **Controllers and views** | Gem | Fast default implementation; upgrades improve every host app |
| **Routes and overrides** | Host app | Choose mount paths / route helpers; replace views or controllers only when needed |

Guidelines:

- Put business rules in **core methods** (and capability APIs), not only in controllers.
- Prefer **gem-owned controllers and views** so bugfixes and UI improvements ship with the gem.
- Let the **host app decide routes** (where the feature is mounted, path helpers, which surfaces appear).
- Allow the host to **override views and controllers** when product-specific behavior is required — without forking the gem’s domain logic.
- Custom host controllers should call the same core methods the gem controllers use, so behavior stays consistent with the UI and API slices.

Avoid copying gem controllers into the host “just in case.” Start with the gem implementation, mount the routes the app wants, and override only the pieces that must differ.

## UI strategy

Keep screens simple and **one primary action per page**.

That supports:

- modular gem composition (fewer layout and UX collisions between addons)
- a **mobile-first** ecosystem
- faster onboarding for new apps

The default layout from Recording Studio core is deliberately **minimal and focused on the immediate action**. Use it as the shared shell. Do not invent competing page chrome in addon gems unless the host app explicitly needs it.

Build UI with **Flatpack** ViewComponents. Prefer existing Flatpack pieces over custom markup.

## Dependencies and realism

Early designs tried to keep things like access highly pluggable. In practice the ecosystem leans on known dependencies:

- **Recording Studio Accessible** for access control across actors — **required; do not invent custom access**
- **Recording Studio Admin** for admin sections, screens, and reporting UI gated by Accessible
- **Recording Studio API** for JSON APIs that reuse the same capability actions as the UI
- **Flatpack** for UI

Prefer the standard stack over inventing alternate access, admin, API, or design systems. If Accessible (or another standard dependency) cannot support the requirement, ask how to proceed instead of building a one-off replacement.

When building admin UI, follow the `setup-admin-screens` skill: create an **admin root**, mount admin screens under it, grant Accessible access to that root (do not nominate special admin users), enable sections on the recordable, then define screens/widgets in `app/admin`.

## Fast start, then configure and override

The default path should be:

1. Get Recording Studio working immediately with gem defaults (core methods + gem UI/API slices).
2. Let the host app choose routes and configuration.
3. Let the host app override views or controllers only where product-specific UI or flow is required.

Do not require deep customization before the basics run. Defaults should be useful; routing choices and targeted overrides are the escape hatches — not a rewrite of the gem.

## Decision checklist

When adding a feature, ask:

1. Does ownership belong on a **root** (content, billing, access bucket) rather than a user?
2. Should this data be a **recording**, an **event**, or a **log**?
3. Are we modeling the actor as an **actor**, not only a user?
4. Does this belong in core, an existing addon, or a new reusable gem?
5. Can another app reuse it, or is it truly one-product logic?
6. Does the UI stay a single-purpose page that fits the default layout?
7. Are core methods reusable by gem UI, API, and host customizations?
8. Is the gem keeping views/controllers while the app owns routes (and overrides only when needed)?
9. Are we using Flatpack and Recording Studio Accessible instead of a one-off approach?
10. If Accessible seems insufficient, have we asked how to proceed instead of inventing custom access?
11. Will a host app work out of the box, then configure or override only what must differ?

If the answer points to root-scoped data, reusable gems, simple UI, and defaults first, you are aligned with Recording Studio.

## Related skills

| Need | Skill |
|---|---|
| Setup order and addon map | `getting-started-recording-studio` |
| Access grants | `recording-studio-accessible` |
| Admin root | `setup-admin-screens` |
| HTTP API | `recording-studio-api` |
| UI | `flatpack-ui` |
