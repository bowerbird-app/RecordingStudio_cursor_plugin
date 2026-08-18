---
name: recording-studio-approach
description: Explain Recording Studio philosophy: roots as buckets, actors not only users, recordings vs events vs logs, and reusable gems. Use when designing the data model or deciding where behaviour belongs. For setup order use getting-started-recording-studio.
---

# Recording Studio approach

Most of an app should be **reusable gems** on **Recording Studio core**, assembled by a thin host. Setup order and addons: `getting-started-recording-studio`.

## Recordings, recordables, events, logs

Core is a Basecamp-style `delegated_type` model:

| Layer | Role |
|---|---|
| **Recording** | Stable identity and mixin surface |
| **Recordable** | Immutable snapshot of state |
| **Event** | Append-only history of that recording |
| **Log** | Caused-but-unowned exhaust that must not clog the tree |

Prefer public helpers on `RecordingStudio` and `RecordingStudio::Recording`. Writes: `write-through-recording-studio`. Which layer: `recording-studio-logs`.

**Roots** are recordings declared as the top-level **bucket**. Content, settings, and **billing** live on the root — not on the user. People and systems get **access** to the bucket (`recording-studio-accessible`). Hierarchy is natural: nested recordings inherit the bucket.

## Actors, not only users

A user is one actor. API clients, AI agents, and later types are actors too. Same Accessible path for all of them. Do not hard-code “only Devise users own everything.”

## Reusable gems

Assume **most of the product is reusable**. Extract a `recording-studio-*` addon instead of one-app code (`build-recording-studio-gem`). Mixins are opt-in per type (`recording-studio-capabilities`).

If the gem has UI or API, they share **one domain action** (`recording-studio-ui`, `recording-studio-api`). Do not invent a second action for JSON.

Standard stack — do not replace these:

- Access: Accessible (ask if it cannot cover the case)
- Staff UI: Admin
- JSON: API
- Components: Flatpack

## Related

`getting-started-recording-studio`, `recording-studio-logs`, `recording-studio-accessible`, `build-recording-studio-gem`.
