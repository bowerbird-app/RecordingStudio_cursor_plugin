---
name: recording-studio-logs
description: Choose recordings, events, or logs for Recording Studio data. Use when modelling webhook deliveries, audit trails, inbound requests, or other caused activity, or when deciding whether something belongs in the tree.
---

# Logs vs recordings

Not everything an actor touches is a recording. The tree stays for **content people navigate**. High-volume caused activity belongs in **logs** so it does not clog recordings.

## Pick a layer

| It is… | Use | Example |
|---|---|---|
| Something in the tree people open, move, and share | **Recording + recordable** | Workspace, folder, page, webhook *endpoint* |
| History of that item’s lifecycle or a capability action | **Event** (`log_event!`) | Page revised, folder moved |
| Caused activity they do not own as content | **Log** | Webhook *delivery* attempts, inbound request traces |

Ask:

1. Would someone treat this as a thing in the workspace, with a place in the hierarchy? → recording.
2. Is it “what happened to that thing”? → event on that recording.
3. Is it operational exhaust you still need to query, without putting it in the tree? → log.

Webhook **endpoints** (the configuration people create) are recordings. Webhook **deliveries** (each attempt, payload, status) are logs.

## Why logs exist

Recordings are the collaboration tree. Filling them with deliveries, processor runs, or raw request dumps makes the hierarchy noisy and mixes owned content with exhaust.

Logs stay queryable (admin tables, retries, debugging) without becoming folders and pages. Admin screens that inspect deliveries should read **logs**, not invent a recordable type per attempt (`setup-admin-screens`).

## Writes

- Create and change owned content with `record` / `revise` (`write-through-recording-studio`).
- Append recording history with `log_event!`. Never insert `Event` rows by hand.
- Write caused-but-unowned trails through the gem’s **log** API or tables — not `root.record(Delivery)`.

User-facing copy still must not say “recording,” “recordable,” or “log table.” Say delivery, history, activity (`recording-studio-copy`).

## Do not

- Add a recordable type because “we need to store these rows.”
- Put billing invoices, deliveries, or request dumps in the tree to reuse Accessible by accident. Access stays on the **endpoint** or root; the log rows hang off that.
- Duplicate the same fact as an event *and* a log unless they answer different questions (lifecycle vs exhaust).

## Related skills

| Need | Skill |
|---|---|
| New types | `add-recordable` |
| Write path | `write-through-recording-studio` |
| Philosophy | `recording-studio-approach` |
| Admin of exhaust | `setup-admin-screens` |
