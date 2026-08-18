---
name: setup-admin-screens
description: Set up Recording Studio Admin via an admin root and Accessible grants (not nominated admin users). Use when installing admin, mounting screens, defining sections or widgets, or deciding what belongs on an admin page. Prefer a few high-signal widgets over filling the section.
---

# Set up admin screens

Use **Recording Studio Admin** for reusable admin and reporting screens. Use **Recording Studio Accessible** to grant actors access and to gate those screens.

Admin comes after core and Accessible are in place. For the full setup map, see `getting-started-recording-studio`. Admin is one **mount point**: a section and child screens that navigate like a small app (`recording-studio-ui`). Other gems often ship a user slice *and* a separate admin slice.

## Admin approach: roots, not nominated admins

Recording Studio does **not** nominate special “admin users” as a separate identity class.

Instead:

1. Create an **admin root** (a normal root recording/recordable — for example `AdminRoot`).
2. Mount admin screens and functionality **under that root**.
3. Grant actors access to the admin root with the **standard Accessible** model (`grant_access`, roles, hierarchy).

Whoever can access the admin root can use the admin UI, subject to Accessible roles on that recording (and any tighter checks on section/screen blast radius). The same actors model applies: users, API clients, AI agents, and future types.

Do **not** invent `is_admin?` flags, parallel admin ACL tables, or a second permission system for staff. If Accessible cannot express the policy, ask how to proceed.

Admin does not invent its own auth model. Mounted screens authenticate through the host app, then authorize against a mandatory **access recording** (typically the admin root recording) with `RecordingStudioAccessible.authorized?`.

For Accessible itself — hierarchy grants, actors, and effective roles — follow `recording-studio-accessible`. Do not invent custom access for admin gating.

## What each gem does

| Gem | Job |
| --- | --- |
| `recording_studio_accessible` | Grants and checks actor access on recordings; mounts access-management UI |
| `recording_studio_admin` | Code-defined sections, screens, widgets, charts, tables; mounts admin surfaces |

Keep three admin concerns separate:

1. **Access recording** — which `RecordingStudio::Recording` gates the mounted admin UI
2. **Enabled sections** — which registered sections appear for the current recordable type
3. **Section recordable** — optional Recording Studio object created/resolved after a section opens

## Install Accessible first

```ruby
gem "recording_studio", "~> 3.0"
gem "recording_studio_accessible"
gem "recording_studio_admin"
```

```bash
bundle install
bin/rails generate recording_studio:install
bin/rails generate recording_studio:migrations
bin/rails generate recording_studio_accessible:install
bin/rails generate recording_studio_accessible:migrations
bin/rails db:migrate
```

Configure actor types that may receive grants, and enable `:accessible` on recordables that should hold access children:

```ruby
RecordingStudioAccessible.configure do |config|
  config.access_actor_types = ["User", "Workspace"]
end

class Workspace < ApplicationRecord
  recording_studio_recordable label: "Workspace", root: true
  RecordingStudio.enable_capability(:accessible, on: self)
end
```

Grant and check access through the public API:

```ruby
RecordingStudioAccessible.grant_access(
  recording: recording,
  actor: user,
  role: :view,
  manager_actor: current_actor
)

RecordingStudioAccessible.authorized?(
  actor: user,
  recording: recording,
  role: :view
)
```

Effective access is the strongest role on the target recording or an applicable ancestor. Think **actors**, not only users.

Optional mounted access UI:

```bash
bin/rails generate recording_studio_accessible:access_management --link-helper
```

## Install Admin

```bash
bin/rails generate recording_studio_admin:install
bin/rails generate recording_studio_admin:admin_root   # optional host-owned admin root scaffolding
```

Mount Accessible and an admin surface together:

```ruby
mount RecordingStudioAccessible::Engine, at: "/admin/access"
recording_studio_admin_for :admin, at: "/admin", root_section: :root
```

Configure auth, actor lookup, and the mandatory access recording — usually the **admin root** recording:

```ruby
RecordingStudioAdmin.configure do |config|
  config.default_mount_path = "/admin"
  config.authentication_method = :authenticate_user!
  config.current_actor_method = :current_user
  config.access_recording_resolver = ->(context) {
    # Resolve the admin root recording (or other access recording for this surface)
    context.controller.current_admin_root_recording
  }
end
```

Actors become “admins” by receiving Accessible access on that root — not by a separate nomination system.

Fail-closed behavior:

- missing auth method → `401`
- missing access recording or Accessible denial → `403`

By default admin checks `RecordingStudioAccessible.authorized?` with role `:view` before resolving sections, widgets, or screen queries.

## Enable sections on a recordable

Registering a section defines the capability. Enabling it on a recordable decides where it appears.

```ruby
class AdminRoot < ApplicationRecord
  include RecordingStudio::Recordable
  include RecordingStudioAccessible::AllowsAccessibleChildren
  include RecordingStudioAdmin::AllowsAdminSections

  recording_studio_recordable label: "Admin", root: true
  recording_studio_accessible_children :access

  recording_studio_admin_sections do
    section :root
    section :api
    section :users
  end
end
```

## Define screens, sections, and widgets

Keep definitions in `app/admin` capability folders and register them from `to_prepare` so development reloads stay correct.

Typical layout — a hub plus **one job** screen, not a widget kit:

```text
app/admin/
  manifest.rb
  webhooks/
    manifest.rb
    section.rb                    # links + maybe “failed last 24h” list
    failed_deliveries/
      screen.rb
      table.rb
```

```ruby
Rails.application.config.to_prepare do
  load Rails.root.join("app/admin/manifest.rb")
  AdminScreens.load!
  AdminScreens.register!
end
```

If `app/admin` is manifest-loaded rather than Zeitwerk-named:

```ruby
Rails.autoloaders.main.ignore(root.join("app/admin"))
```

Definition roles:

- **Section** — hub: links to the jobs in this area, plus a few signals
- **Screen** — one operational job: query, filters, table and/or chart
- **Widget** — a card (`number`, `list`, `chart`, `progress`) that changes what someone does next. Use the extra-info param when the title or number would puzzle someone new (`recording-studio-copy`).
- **Resource** — registered admin actions linked from tables; host app owns the mutation controller

## Useful widgets, not filler

Admin has the same failure mode as copy: **empty space is not a problem.** Agents often invent a widget per model (`Total users`, `Total pages`, `Total webhooks`…) and a screen per table. Staff ignore that. Do not ship it.

Start from the **job**, not from the schema.

Ask:

1. What does someone come here to **notice, decide, or fix**?
2. What would they check this week if the product was on fire?
3. If we removed this widget, would any action change?

If the answer is “it looks complete,” delete it.

### What earns a widget

Useful widgets are **exceptions, queues, and health** — not inventory.

| Worth a widget | Rarely worth a widget |
|---|---|
| Failed deliveries in the last 24 hours | Total webhooks ever |
| Invites waiting | Total users |
| Jobs stuck / oldest wait | Rows in the table already on this screen |
| Usage vs plan, queue depth | A second chart of the same count |
| A short list of things to handle | “Activity” with no decision attached |

Match the shape to the job:

- **Number** — a count that is interesting when it moves (especially when it should be zero)
- **List** — the actual items to deal with (better than a number you cannot act on)
- **Chart** — a trend that changes a decision (errors over time, not “everything over time”)
- **Progress** — toward a real limit (plan, quota, drain a queue)

Do not repeat the same fact as a number, a chart, *and* a list. Pick one.

### What earns a screen

A **screen** is a place to do one job: filter, inspect, act. Examples: failed webhook deliveries, people in this workspace, API requests that 500’d.

Do **not** add a screen because a model exists. Do not add a section because a gem exists if nobody operates it from admin. A gem’s admin slice should cover **that gem’s operational questions** (webhooks: deliveries and failures) — not a tour of unrelated totals.

A **section** is a hub. Two to four widgets that tell you **which screen to open**, plus links. It is not a dashboard of every metric you can query.

White space on a section is fine. One sharp “Needs attention” list beats six vanity numbers.

### Newcomer check

Look at the page as someone who has never opened it. Can they tell what needs them? If a number is cryptic, use extra-info — do not add three more widgets to “explain” it. If nothing needs them, the page can be almost empty.

## Link with context helpers

```ruby
context.admin_screen_path("api_requests")
context.admin_section_path("root")
```

## Access wiring checklist

1. Actor can authenticate (`authentication_method`).
2. Current actor resolves (`current_actor_method` / `Current.actor`).
3. `access_recording_resolver` returns a real `RecordingStudio::Recording`.
4. That recording's recordable enables the needed admin sections.
5. Actor has Accessible access on that recording (usually at least `:view`).
6. For site-wide blast radius screens, configure `site_admin_recording_resolver`.

## Guardrails

- Prefer Flatpack rendering shipped by Admin; do not invent a second admin UI system.
- Keep queries in screen/section definitions or app services, not controllers or ERB.
- Use **logs** for admin audit trails when the data is caused-but-unowned operational history.
- Host controllers that mutate through resources should authorize with `RecordingStudioAdmin.authorize_resource!` and wrap changes with `perform_recording_studio_admin_action!`.
- Do not nominate special admin users — grant Accessible access on the admin root instead.
- Do not grant broad workspace-root access just to unlock one admin page — grant access on the admin root (or the correct access recording) and enable only the needed sections.
- Do not fill a section with vanity totals or a screen per ActiveRecord model. Ship the smallest set of widgets and screens that support a real staff job.

## Canonical references

- Admin README and `docs/gem_template/ADMIN_SCREENS.md` in `RecordingStudio_admin`
- Dummy app under `RecordingStudio_admin/test/dummy/app/admin`
- Accessible README and grant/check APIs in `RecordingStudio_accessible`
