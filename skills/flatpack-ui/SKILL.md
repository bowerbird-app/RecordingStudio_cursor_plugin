---
name: flatpack-ui
description: Build Recording Studio screens with Flatpack ViewComponents instead of custom HTML or Tailwind. Use when adding or changing UI, forms, alerts, cards, navigation, or user-facing copy.
---

# Flatpack UI

Flatpack is the Recording Studio UI library. Search for an existing component before writing markup.

For **page shape** — UI slices, mini-apps, one-action screens, and the core default layout — follow `recording-studio-ui` first. This skill is which Flatpack component to render.

## When to use

- Adding or changing a screen, form, alert, card, table, modal, or navigation
- Deciding whether custom HTML is justified
- Checking that CSS actually loaded in the running app

## Instructions

1. Look up the component in this repo's Flatpack usage and at https://flatpack.bowerbird.io/.
2. Compose Flatpack components. Do not recreate buttons, forms, alerts, cards, or nav with custom markup.
3. Semantic layout markup is fine when Flatpack has no structure for it.
4. If Flatpack cannot support the requirement, explain the gap before adding custom UI.
5. Do not rewrite unrelated legacy UI just because it is in a touched file. Migrate a legacy element only when the change is local and behavior stays the same.
6. Keep user-facing copy free of backend terms such as recording or recordable.

## Validation

- Start the app and confirm Tailwind/Flatpack CSS loaded.
- Screenshot the screens you changed.
- Exercise the flow, not just the default render.
