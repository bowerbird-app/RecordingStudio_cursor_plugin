---
name: recording-studio-approach
description: Explain the overall Recording Studio architecture and product philosophy. Use when designing features, deciding whether to extract a gem, choosing UI shape, or onboarding to the ecosystem.
---

# Recording Studio approach

Recording Studio is an ecosystem of Rails gems built on **Recording Studio core**. The goal is to ship most of an app as reusable, contained gems so new products come together quickly.

## Core model: Basecamp-style delegation

Core follows a Basecamp-style **Recordings / Recordables / Events** model using Rails `delegated_type`:

| Layer | Role |
| --- | --- |
| **Recording** | Stable identity and capability surface |
| **Recordable** | Immutable snapshot of state (delegated type) |
| **Event** | Append-only history |

That split keeps mixins and lifecycle operations on the recording, state versioned on the recordable, and history append-only. Prefer public helpers on `RecordingStudio` and `RecordingStudio::Recording` over private registrar internals.

When writing data, use the root recording API (`record`, `revise`, `log_event!`). Do not invent parallel write paths.

## Ecosystem of reusable gems

Assume **most of any app is reusable**. Prefer extracting shared behavior into gems over building one-off app code.

- Recording Studio core is the foundation.
- Addon gems are small, focused blocks (`recording-studio-*`) that compose into products.
- Avoid custom gems that only serve one application when the same capability can be abstracted for reuse.
- Capability mixins are opt-in: installing a gem does not silently enable behavior for every recordable type.

Gems are meant to provide a **UI slice** as well as domain behavior, so setup stays fast: mount the gem, configure, override only what must differ.

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

- **Recording Studio Accessible** for access control
- **Flatpack** for UI

Prefer the standard stack over inventing alternate access or design systems unless there is a clear product requirement.

## Fast start, then configure and override

The default path should be:

1. Get Recording Studio working immediately with defaults.
2. Let the host app configure settings.
3. Let the host app override views where product-specific UI is required.

Do not require deep customization before the basics run. Defaults should be useful; configuration and view overrides are the escape hatches.

## Decision checklist

When adding a feature, ask:

1. Does this belong in core, an existing addon, or a new reusable gem?
2. Can another app reuse it, or is it truly one-product logic?
3. Does the UI stay a single-purpose page that fits the default layout?
4. Are we using Flatpack and the usual access gem instead of a one-off approach?
5. Will a host app work out of the box, then configure or override views only as needed?

If the answer points to reusable gem + simple UI + defaults first, you are aligned with Recording Studio.
