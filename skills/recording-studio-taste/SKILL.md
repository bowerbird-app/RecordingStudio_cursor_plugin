---
name: recording-studio-taste
description: Judge and improve how Recording Studio screens look while staying on Flatpack. Use when composing gem or dummy UI, reviewing screenshots, restyling a Flatpack component or theme, or when tempted to add custom CSS, Tailwind, or a third-party design skill. For which component to render, use recording-studio-flatpack. For page shape, use recording-studio-ui. For words, use recording-studio-text.
---

# Recording Studio taste

Flatpack is the kit. This skill is whether the page is any good, and whether a missing look belongs in Flatpack rather than in the caller.

Do not invent a parallel visual language. Look up the live kit first: https://flatpack.bowerbird.io/ and the dummy default theme `html data-theme="rounded"` (Flatpack `docs/theming.md`).

## When to use

- Composing gem or dummy UI
- Reviewing screenshots
- Restyling a Flatpack component or theme
- Tempted to add custom CSS, Tailwind, or a third-party design skill

## Instructions

Two jobs:

1. **Compose.** Build from Flatpack on core `recording_studio/default_layout` (`UsesDefaultLayout`). Public slices use that same layout. Dummy Devise login may keep `layouts/application`.
2. **Evolve the kit.** If the look is common (button, search, dropdown, flash, card, empty state, theme token) and Flatpack is weak, change Flatpack. Do not ship a custom control in the gem. If unsure it is common enough, stop and ask Nic via DJ.

Visual default:

- **Theme:** Flatpack rounded. Missing `data-theme="rounded"` on dummy is a reject.
- Do not copy `default_layout` into dummy and edit it.
- **Slot** (PageNav right): only actions for the thing on the page. Access belongs there when the record is Accessible. Sign out and Root Switchable are site-wide — never in the slot.
- **Density:** room to breathe. No squished stacks, kitchen-sink toolbars, vanity totals.
- One primary action per page.
- No junk to look complete: no placeholder blocks, fake section labels, empty PageNav glyphs, empty rich-text, Lorem/Acme/John Doe. If an addon is not built, the screen is just the real record.
- **Flashes:** one. Core `default_layout` already paints flash. Do not render notice again in the view.
- **Copy:** `recording-studio-text`. No Elevate/Seamless/Unleash/Next-Gen.

### Screenshot gate

Reject before Nic sees it:

- CSS/JS not loaded, unstyled HTML
- Default layout missing on product pages
- Dummy home/login/sidebar instead of the gem screen
- Missing rounded
- Sign out or Root Switchable in the slot
- Double flash, empty glyphs, empty editor, placeholder sections
- Seeded records missing on list/show/edit/admin

## Do not

- Install `leonxlnx/taste-skill` or other generic frontend taste packs on gems or dummies.
- Recreate Flatpack in Tailwind, custom CSS, or a gem ViewComponent.
- Restyle around Flatpack (new fonts, serif heroes, bento marketing grids, GSAP) on product screens.
- Put marketing chrome or `recording_studio_publishable/application` on gem UI. Featured In marketing is a different surface.

## Related

`recording-studio-flatpack`, `recording-studio-ui`, `recording-studio-text`, `recording-studio-admin`.
