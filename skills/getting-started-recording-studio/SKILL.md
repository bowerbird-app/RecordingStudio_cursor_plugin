---
name: getting-started-recording-studio
description: Map a new Recording Studio app or gem from first decisions through core setup, Accessible, and common addons. Use when starting a product, adding Recording Studio to a Rails app, choosing which gems to include, or asking how roots, actors, admin, API, billing, and UI fit together. Prefer this skill over jumping straight into a single addon.
---

# Getting started with Recording Studio

Treat a Recording Studio product as **gems assembled around a thin host app**, not as a custom monolith with a few shared libraries.

Work in this order: **decide the shape → install core → add Accessible → add the addons the product actually needs → ship UI and API from the same capabilities**. Do not start by inventing access control, admin users, or one-off JSON endpoints.

## 1. Decide the shape first

Answer these before generating models.

### What is the root?

A **root** is the bucket everything lives in. Content, settings, and **billing** belong on the root — not on the signed-in user.

| Product | Typical root | Why |
|---|---|---|
| Team workspace | Workspace / account | People join the bucket |
| Multi-site CMS | Site | Each site is billed and configured |
| Client portal | Organisation | Clients never own the data personally |

Default to **team-first**. Users get **access** to the bucket; they do not own it.

If two recordable types can both sit at the top of the tree, that is a **shared-root** design. Confirm that with the team before generating two root classes.

### Who acts?

**Actors** are whoever can do work: people, API clients, AI agents, and later types. Do not model the product as "users only" if machines will call the same actions.

### What are the recordables?

List the **types of content** in the tree (folders, pages, messages, jobs). Those become Recording Studio recordable types. Caused data that the tree should not own (webhook deliveries, audit trails) belongs in **logs**, not as extra recordables.

User-facing copy must not say "recording" or "recordable". Use product words: workspace, folder, page, site.

## 2. Install Recording Studio core

In a host app:

1. Add `recording_studio` and run `bundle install`.
2. Install and migrate: `bin/rails recording_studio:install:migrations` then `db:migrate`.
3. Generate the root recordable (for example `Workspace`) and include `RecordingStudio::RootRecording`.
4. Register it with `RecordingStudio.configuration.root_recording_type = "Workspace"`.
5. Implement `root_recording_for` so requests can resolve the current root.
6. Point the current user (or current actor) at `RecordingStudio.configuration.current_user`.

Core gives you **recordings, recordables, events, logs, and the write path**. It does **not** give you access control. Do not paper over that with a custom `admin?` flag or a home-grown ACL.

For a **new reusable gem** instead of a host app, start from **recording_studio-gem_template** so the dummy app, Flatpack, and test layout already match the ecosystem.

## 3. Add Accessible next (almost always)

**Accessible is the default access addon.** Add it as soon as more than one actor can see or change a root.

Accessible grants access **down a hierarchy**: access to a workspace includes its folders and pages unless a more specific rule says otherwise. The same grant path should cover humans, API clients, and AI agents.

Rules:

- Do not invent a parallel permission system.
- Do not nominate admin users on the user record.
- If Accessible cannot express the rule, **stop and ask** — do not code a workaround.

See `recording-studio-accessible` for grant modelling. See `setup-admin-screens` for the admin-root pattern that sits on top of Accessible.

## 4. Choose common addons

Add gems because the product needs the **capability**, not because the catalogue exists. Each addon should stay a contained slice with its own UI and API — not a dump of helpers into the host app.

### People, access, and switching

| Need | Addon | Notes |
|---|---|---|
| Sign-in, invitations, profiles | **Users** (or the host's auth) | Auth identifies the actor. Accessible still decides what they can do. |
| Grants, roles, hierarchy | **Accessible** | Required for multi-actor products. |
| Switch current root | **Root switchable** | The host chooses the current root; this gem helps users move between buckets they can access. |

### Operating the product

| Need | Addon | Notes |
|---|---|---|
| Staff / operations UI | **Admin** | Create an **admin root**, mount screens there, grant Accessible access to that root. Never `user.admin = true`. |
| HTTP API, tokens, AI agents | **API** | Same actions as the UI. Register capability actions; enable them per named API (`user`, `admin`, …). |
| Plans, subscription, usage | **Billing** | Belongs on the **root**, not the user. |

### Product navigation and chrome

| Need | Addon | Notes |
|---|---|---|
| App nav, menus, wayfinding | **Navigation** | Keep host layout thin; let gems contribute nav items. |
| Icons for recordable types | **Icons** | Shared visual language across gems. |

### Recordable capabilities (mixins)

These usually land on folders, pages, and similar types once the tree exists:

| Need | Addon |
|---|---|
| Move in the tree | **Moveable** |
| Duplicate | **Duplicatable** |
| Attach files | **Attachable** |
| Comments | **Commentable** |
| Trash / restore | **Trashable** |
| Publish | **Publishable** |
| Order / sort | **Orderable** |
| Categories | **Categorisable** |
| Export | **Exportable** |

### Outbound and notifications

| Need | Addon |
|---|---|
| Signed webhooks | **Webhooks** (deliveries often belong in **logs**) |
| In-app or email notices | **Notifications** |
| Threads / inbox | **Messages** |

You do not need this whole list on day one. A typical first slice is:

**core → Accessible → Users (or existing auth) → Flatpack UI for the tree → API if agents or integrations matter → Admin if staff need a back office → Billing when you charge the root.**

## 5. Build UI and API from the same actions

- **Pages do one job.** Prefer a screen that moves a folder over a dashboard of unrelated actions.
- **Mobile-first**, simple layout. Do not invent a new design system.
- Use **Flatpack** for buttons, forms, alerts, cards, nav, and similar chrome (`flatpack-ui`).
- Put behaviour in **core methods** on the recordable. The UI calls them. The API calls them. Overrides call them.
- Gems should ship **views and controllers**. The **host app owns routes** and mounts engines.
- Override gem views only when the product must diverge. Prefer helpers, slots, and configuration.

If the UI can do it, the API should usually be able to do it too (`recording-studio-api`).

## 6. Prove it in both test suites

Add tests in the **gem** (`test/`) and the **dummy app** (`test/dummy/test/`). Cover write-through, Accessible, and the new capability — not only the happy-path controller.

See `minitest-workflow`.

## Suggested sequence (checklist)

Use this as the default path for a new app:

1. Name the root, the actors, and the first recordable types.
2. Install **recording_studio** core; generate the root; wire `root_recording_for` and current user/actor.
3. Add **Accessible** and grant access to the root (and down the tree).
4. Add auth (**Users** or host Devise/session) so actors can sign in. Still no custom ACL.
5. Build the first tree UI with **Flatpack** and write-through (`record` / `revise` / `log_event!`).
6. Add **Root switchable** if people belong to more than one root.
7. Add **API** when integrations or AI agents need the same actions.
8. Add **Admin** only when staff need operations UI — as an admin root plus Accessible, not a nominated admin user.
9. Add **Billing** on the root when the product charges for the bucket.
10. Add capability mixins (move, trash, attach, …) as the tree needs them.
11. Keep domain logic in gem core methods; host stays thin.

## Do not

- Start with a custom permission matrix, `current_user.admin?`, or per-model `user_id` ownership of the bucket.
- Put billing or the content tree on the user record.
- Build admin as "this person is an admin" instead of an admin root.
- Expose UI actions that the API cannot perform (or the reverse) without a deliberate reason.
- Hand-roll buttons, forms, and nav when Flatpack already has them.
- Skip Accessible because "it's only one workspace for now" if more than one actor will ever share it.

## Related skills

| Next | Skill |
|---|---|
| Philosophy and constraints | `recording-studio-approach` |
| Recordable types | `add-recordable` |
| Writes | `write-through-recording-studio` |
| Access | `recording-studio-accessible` |
| Admin root | `setup-admin-screens` |
| HTTP API | `recording-studio-api` |
| UI | `flatpack-ui` |
| Tests | `minitest-workflow` |
