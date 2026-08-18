---
name: recording-studio-copy
description: Write short, plain product text for Recording Studio screens, buttons, flashes, and mail. Use when adding titles, labels, empty states, errors, or any copy people will read. Prefer this skill over putting long explanations into the UI.
---

# Recording Studio copy

Write for a person using the product, not for a developer reading the gem.

Keep it **short**. One idea. Everyday words. If a title, button, or flash needs a paragraph, the screen is doing too much (`recording-studio-ui`).

## Voice

- Simple and readable. Prefer “Move this folder” over “Relocate the selected recordable in the hierarchy.”
- Minimal. Cut words that do not help someone act.
- Direct. Say what the page is, then the action.
- Calm. No hype, no jokes that need explaining, no error text that blames the user.

Titles name the job. Subtitles add one line of context, or they stay empty. Buttons are verbs: Save, Move, Invite, Close.

## Product words, not gem words

Developer names stay in code and maintainer docs.

| Do not say | Say |
|---|---|
| recording, recordable | folder, page, workspace, site — the thing it is |
| root | workspace, site, or whatever the product calls the bucket |
| actor, grant, capability | person, access, or the action they can take |
| revise, event, log | only if the person must see history; then say “history” or “activity” |

Staff admin screens can be a little more precise. They still should not say “recordable.”

## Errors and empty states

- What happened, in plain language.
- What to do next, if there is something to do.
- No stack traces, class names, or “unauthorized for this recording.”

Good: “You don’t have access to this workspace.”  
Poor: “Accessible role check failed on the root recording.”

## Do not

- Explain the architecture on the screen.
- Repeat the title in the subtitle.
- Use help text to paper over a confusing form. Fix the form.
- Write different voice in each gem. Stay this short everywhere.

Page shape and Flatpack: `recording-studio-ui`, `flatpack-ui`.
