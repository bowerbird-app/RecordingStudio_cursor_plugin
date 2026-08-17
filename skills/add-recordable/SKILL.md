---
name: add-recordable
description: Add or register a Recording Studio recordable type with hierarchy declarations, labels, and tests. Use when creating a new content type, root, or nested model in a Recording Studio gem or host app.
---

# Add a recordable

Follow Recording Studio's public API. Do not invent private registrar internals.

## When to use

- Adding a new content type to a host app or addon gem
- Declaring root vs nested hierarchy rules
- Wiring labels, table names, and tests for a new type

## Steps

1. Create a lean recordable model. Snapshot tables should not need `updated_at`. Prefix tables with `recording_studio_` when the model lives in an engine.

2. Declare hierarchy on the model:

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

## Guardrails

- Recordables are immutable snapshots. Use `revise` to change state.
- Put activity on `Event` through `log_event!`, never by writing `Event` rows directly.
- Prefer public helpers such as `RecordingStudio.root_allowed?` and `RecordingStudio.parent_allowed?`.
- Capability mixins are opt-in. Registering a type does not enable comments, attachments, or similar addons.
- Cover declaration, root rejection, and parent rejection paths in Minitest.
