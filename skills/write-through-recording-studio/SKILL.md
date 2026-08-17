---
name: write-through-recording-studio
description: Use Recording Studio public write helpers instead of guessing internals. Use when creating, revising, or logging history for recorded content.
---

# Write through Recording Studio

Use this sequence before guessing.

## Checklist

1. Normalize the type with `RecordingStudio.recordable_type_name(...)` and `RecordingStudio.recordable_declaration_for(...)`.
2. If the write is for a top-level object, confirm `RecordingStudio.root_allowed?(type)` and call `RecordingStudio.root_recording_for(persisted_recordable)`.
3. If the write is for a child, resolve `parent_recording` first and verify `RecordingStudio.parent_allowed?(child_type:, parent_recording:)`.
4. If the child is capability-owned, inspect `RecordingStudio.recordable_parent_allowances_for(...)` and `RecordingStudio.parent_capabilities_for(child_type:, parent_recording:)` to explain why the parent is valid.
5. Prefer `record`, `revise`, and `log_event!` on `RecordingStudio::Recording`. Drop to `RecordingStudio.record!` only when you need the returned event.

## Identity vs state vs history

| Layer | Model | Responsibility |
| --- | --- | --- |
| Identity | Recording | Stable handle and mixin surface |
| State | Recordable | Immutable snapshot |
| History | Event | Append-only timeline |

## Tests

- Assert a new recordable row on `revise`.
- Assert event action and count, not in-place mutation.
- Use `idempotency_key` for retriable flows.

For the full method surface, read `docs/API_REFERENCE.md` in the Recording Studio gem.
