---
name: recording-studio-api
description: Build Recording Studio APIs by registering capability actions and enabling them on endpoints. Use when exposing JSON APIs, adding member actions, wiring API access with Accessible, or avoiding duplicate UI/API logic.
---

# Recording Studio API

**Recording Studio API** (`recording_studio_api`) is the mountable engine for authenticated JSON APIs over Recording Studio.

The product idea is simple: **every gem should provide both a UI slice and an API slice**. Register the domain action once, enable it where it belongs, and let Accessible authorize the same way for people and API clients.

Do not rebuild the same “move folder / publish page / …” logic in a separate API controller. If the UI can do it, expose it as an API capability action and enable it on the relevant resource endpoint.

## Core idea

1. Addon gems own the **capability** (for example `:movable`, `:publishable`).
2. The gem registers an **API capability action** once (`:move`, `:publish`, …) with a handler.
3. The host (or gem) registers the **recordable type API** and lists which `capability_actions` that endpoint may call.
4. When the recordable enables the Recording Studio capability **and** the action is allowlisted, the API exposes it automatically.
5. Handlers authorize through **Recording Studio Accessible** via the request’s `AccessGrant`.

That keeps one action path for UI and API, with predictable access results for any actor.

## Prefer enablement over duplicate controllers

Bad:

- UI calls `folder.move!(...)`
- API invents a custom `FoldersController#relocate` with copied rules

Good:

```ruby
# Gem registers the action once
RecordingStudioApi.register_capability_action(
  :move,
  capability: :movable,
  version: "2.0.0",
  http_verb: :post,
  required_role: :edit,
  handler: RecordingStudioMoveable::Api::MoveRecording
)

# Folders endpoint enables that action
RecordingStudioApi.register_recordable_type_api(
  "Folder",
  operations: %i[index show create update destroy],
  capability_actions: %i[move],
  serializer: ->(folder, **) { { name: folder.name } },
  output_keys: %i[name],
  writable_attributes: %i[name]
)
```

If a user can move a folder in the UI because `:movable` is enabled, enable `:move` on the folders API endpoint. Same capability, same authorization story, no second implementation.

`capability_actions` is **default-deny**. An action must be:

1. Registered with `register_capability_action`
2. Backed by an enabled Recording Studio capability on the recordable
3. Listed in that type’s `capability_actions`

Only then is it callable and shown in OpenAPI.

## Access uses Recording Studio Accessible

API auth is credential-based (OAuth2 `client_credentials` or host bearer authenticators), but **authorization is still Accessible**.

Request flow:

1. Authenticate bearer token → API client / credential
2. Resolve `AccessGrant` (`api_client`, `credential`, `access_recording`, `root_recording`, access actor)
3. Dispatch to resource or capability handler
4. Handler calls `context.access_grant.authorize!(recording: ..., role: ...)` or `RecordingStudioAccessible.authorized?`

Do **not** invent custom API permission tables. Use Accessible. If Accessible cannot cover a case, ask how to proceed.

API clients sit under `RecordingStudio::Access` recordings in the tree, so they inherit the same root/hierarchy access model as users and other actors.

## Register resources quickly

Expose a recordable type as a flat JSON resource:

```ruby
RecordingStudioApi.register_recordable_type_api(
  "Page",
  serializer: ->(page, **) { { title: page.title } },
  output_keys: %i[title],
  writable_attributes: %i[title],
  operations: %i[index show create update destroy],
  capability_actions: %i[publish],
  relationships: {
    # named children / custom relationships as needed
  }
)
```

`operations` chooses standard CRUD exposure (`:index`, `:show`, `:create`, `:update`, `:destroy`). Omit only what you intentionally want closed.

Routes follow the recording tree (member actions beside resources):

```text
POST /recording_studio_api/api/v1/folders/:id/actions/move
```

(compat alias without `/actions/` also exists)

## Handler pattern

```ruby
class PublishRecording
  def self.call(context)
    context.access_grant.authorize!(recording: context.recording, role: :edit)

    # Prefer calling the same domain API the UI uses
    context.recording.publish!(actor: context.access_grant.actor)
    context.recording
  end
end
```

Keep business rules in the capability/domain layer. The API handler should authorize, adapt params, and call that layer — not fork behavior.

Member actions default to required role `:edit`. Override per action or via `config.capability_action_roles`.

## UI slice + API slice checklist for gem authors

When adding a capability to a Recording Studio gem:

1. Implement the domain behavior once (UI and services call it).
2. Register `RecordingStudioApi.register_capability_action(...)` for the API slice.
3. Document which recordable types should list it in `capability_actions`.
4. Ensure Accessible roles match the UI (`required_role`, through-actors if needed).
5. Add OpenAPI/input contract metadata so Scalar docs stay accurate.
6. Cover gem suite + dummy app tests, including unauthorized API calls.

## Host setup sketch

```bash
bin/rails generate recording_studio_api:install
bin/rails generate recording_studio_api:migrations
bin/rails db:migrate
```

Then:

1. Enable `:accessible` (and `:api_access_point` where API keys hang) on the right recordables.
2. Register recordable type APIs and capability actions.
3. Mount the engine / Scalar docs as needed.
4. Provision API clients from an Access recording (`ProvisionApiClient` / admin screens).

For Accessible details, follow `recording-studio-accessible`. For admin API screens, follow `setup-admin-screens`.

## Guardrails

- One domain action → UI + API. Do not duplicate business logic in API-only controllers.
- Enable actions explicitly with `capability_actions`; do not assume registration alone exposes them.
- Authorize with Accessible / `AccessGrant`, never a parallel ACL.
- Keep responses flat (`id`, `type`, `root_id`, `parent_id`, serializer keys). No legacy `attributes` / `relationships` wrappers.
- Nested writes use registered relationships; parent changes use the move capability action, not `parent_id` on update.
- If the API gem or Accessible cannot support the scenario, ask how to proceed.
