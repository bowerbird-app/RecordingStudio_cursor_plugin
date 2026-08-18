---
name: getting-started-recording-studio
description: Map a new Recording Studio app from first decisions through core setup, Accessible, and which addons to include. Use when starting a product, adding Recording Studio to a Rails app, or choosing gems. Prefer this skill over jumping into a single addon. For a new addon gem, use build-recording-studio-gem.
---

# Getting started with Recording Studio

Treat a product as **gems around a thin host**, not a custom monolith. Philosophy: `recording-studio-approach`.

Order: **shape → core → Accessible → only the addons you need**. Do not invent access control, admin users, or one-off JSON endpoints.

## 1. Decide the shape

Answer these before generating models. Why: `recording-studio-approach`.

- **Root** — the bucket for content, settings, and **billing**. Not the signed-in user. Team workspace, site, or organisation. Confirm with the team before two types both sit at the top (**shared roots**).
- **Actors** — people, API clients, AI agents. Not “users only.”
- **Recordables** — types of tree content (`add-recordable`). Exhaust (deliveries, traces) is a **log** (`recording-studio-logs`).

## 2. Install core

1. Add `recording_studio`, install migrations, `db:migrate`.
2. Generate the root recordable (for example `Workspace`) with `RecordingStudio::RootRecording`.
3. Set `RecordingStudio.configuration.root_recording_type`.
4. Implement `root_recording_for`.
5. Wire the current **actor**. Core’s hook is `RecordingStudio.configuration.current_user` — pass the actor (person or machine), not a Devise-only assumption. Other gems use their own keys (`Current.actor`, `current_actor_method`).

Core is recordings, recordables, events, logs, and the write path. It is **not** access control.

New addon gem: `build-recording-studio-gem`.

## 3. Add Accessible

Add it as soon as more than one actor can see a root. Grants, actors, and “stop and ask”: `recording-studio-accessible`. Admin as an admin root, not `user.admin?`: `setup-admin-screens`.

## 4. Choose addons

Add a gem for a **need**, not because it exists. If that need has UI or API, expose the **same domain action** — do not add a dashboard or JSON surface “for completeness.”

| Need | Addon | Follow |
|---|---|---|
| Sign-in, invitations | **Users** (or host auth) | Auth identifies the actor; Accessible still authorizes |
| Grants | **Accessible** | `recording-studio-accessible` |
| Switch workspace/site | **Root switchable** | Host picks current root. Switcher is a helper/component (`recording-studio-ui`) |
| Staff operations UI | **Admin** | Admin root + Accessible (`setup-admin-screens`) |
| HTTP API / AI agents | **API** | `recording-studio-api` |
| Plans and usage | **Billing** | On the **root**, never `plan_id` on `User` |
| Menus | **Navigation** | Gems register items; one host menu — no second sidebar |
| Type icons | **Icons** | Reuse shared icons |
| Move, trash, attach, … | Mixins | Opt-in per type (`recording-studio-capabilities`) |
| Webhook endpoints | **Webhooks** | Endpoints are recordings; deliveries are logs (`recording-studio-logs`) |
| Notices / threads | **Notifications**, **Messages** | |

Typical first slice: **core → Accessible → auth → tree UI → API if agents → Admin if staff → Billing when you charge the root.**

Screens: `recording-studio-ui`. Components: `flatpack-ui`. Words: `recording-studio-copy`. Writes: `write-through-recording-studio`. Tests: `minitest-workflow`.

## Sequence

1. Name the root, actors, and first types.
2. Install core; wire `root_recording_for` and the current actor.
3. Add Accessible; grant access to the root.
4. Add auth. Still no custom ACL.
5. Tree UI + write-through.
6. Root switchable if people have more than one root.
7. API when integrations or agents need the same actions.
8. Admin only for operations — admin root, few widgets.
9. Billing on the root.
10. Mixins as the tree needs them.
11. Domain logic in gems; host stays thin.
