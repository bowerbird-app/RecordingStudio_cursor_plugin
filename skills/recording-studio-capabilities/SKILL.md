---
name: recording-studio-capabilities
description: Enable Recording Studio capability mixins on the right recordable types instead of hand-rolling move, trash, comments, or similar. Use when adding move, duplicate, attach, trash, publish, order, comments, or another mixin, or when installing an addon that does not show up on types.
---

# Recording Studio capabilities

Capability addons are **opt-in mixins**. Installing `recording_studio_moveable` (or trash, attach, comments, …) does **not** turn the behaviour on for every recordable. You enable it on the types that should have it.

Do not invent a custom move, trash, or comment system when an ecosystem mixin already exists. If a mixin cannot cover the case, **stop and ask** — same rule as Accessible.

## How enablement works

1. Add the addon gem and bundle.
2. Keep **parent rules** on the type (`recording_studio_recordable` / `allowed_parent_types`). Mixins do not replace core hierarchy.
3. Enable the capability **on each recordable class** that should get it.
4. Mount the gem’s UI (and API actions) from the host. Follow `recording-studio-ui` and `recording-studio-api`.
5. Authorize through **Accessible** when the mixin needs access checks. Do not add a second ACL.

Patterns you will see (use the addon’s public API, not a guessed one):

```ruby
# Accessible on a root that should hold grants
RecordingStudio.enable_capability(:accessible, on: Workspace)

# Moveable on types that can move
class Folder < ApplicationRecord
  recording_studio_recordable label: "Folder",
                              root: false,
                              allowed_parent_types: ["Workspace", "Folder"]

  include RecordingStudio::Capabilities::Moveable.enabled
end
```

Read that gem’s README for the exact include or `enable_capability` call. Do not copy a pattern from a different mixin if the README disagrees.

## Common mixins

Use these instead of writing the same feature in the host:

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
| Embed | **Embeddable** |

Accessible, Admin, API, Billing, Users, Webhooks, and similar are **addons**, but they are not “enable this on Folder” mixins in the same way. Approved kit: `recording-studio-gems`. This skill is the recordable mixins.

## UI and API

The mixin should expose the **same domain action** the screen uses. UI pieces: `recording-studio-ui`. API: `recording-studio-api`.

## Do not

- Assume `bundle install` enabled the mixin on Workspace, Folder, and Page.
- Enable a mixin on every type “for completeness.”
- Hand-roll move/trash/comments because the host wants slightly different copy — change the view or extra-info, not the domain.
- Put destination/parent rules only in the mixin when they belong in `allowed_parent_types`.

## Related

`recording-studio-new-recordable`, `recording-studio-api`, `recording-studio-access`, `recording-studio-gems`.
