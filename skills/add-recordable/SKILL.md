---
name: add-recordable
description: Add or register a Recording Studio recordable type with hierarchy declarations, product labels, and tests. Use when creating a new content type, root, or nested model — not for webhook deliveries, audit exhaust, or other logs.
---

# Add a recordable

Follow Recording Studio's public API. Do not invent private registrar internals.

First decide whether this is a **recordable at all**. Caused activity (deliveries, inbound traces) is a **log**, not a new type (`recording-studio-logs`). Capability mixins (move, trash, comments) are **opt-in** on types that already exist (`recording-studio-capabilities`). Registering a type does not enable them.

## When to use

- Adding a new content type to a host app or addon gem
- Declaring root vs nested hierarchy rules
- Wiring labels, table names, and tests for a new type

## Steps

1. Create a lean recordable model. Snapshot tables should not need `updated_at`. Prefix tables with `recording_studio_` when the model lives in an engine.

2. Declare hierarchy on the model. The `label` is **product language** people may see — never “Recordable” or “Recording”:

```ruby
class Workspace < ApplicationRecord
  recording_studio_recordable label: "Workspace", root: true
end

class Page < ApplicationRecord
  recording_studio_recordable label: "Page",
                              root: false,
                              allowed_parent_types: ["Workspace", "Page"]
end
```

3. Register the type in the host initializer:

```ruby
RecordingStudio.configure do |config|
  config.recordable_types = ["Workspace", "Page"]
end
```

4. Validate declarations:

```ruby
RecordingStudio.validate_recordable_declarations!
```

5. Write through the root recording API, not by inserting recordings by hand:

```ruby
root = RecordingStudio.root_recording_for(workspace)
root.record(Page) { |page| page.title = "Getting started" }
```

6. Enable only the mixins this type needs (`recording-studio-capabilities`). Installing Moveable or Commentable does not attach them here for free.

## Guardrails

- Recordables are immutable snapshots. Use `revise` to change state (`write-through-recording-studio`).
- Put activity on `Event` through `log_event!`, never by writing `Event` rows directly.
- Prefer public helpers such as `RecordingStudio.root_allowed?` and `RecordingStudio.parent_allowed?`.
- Cover declaration, root rejection, and parent rejection paths in Minitest.
- Screens use `recording-studio-copy`. Labels and empty states say folder, page, workspace — not the class name internals.
