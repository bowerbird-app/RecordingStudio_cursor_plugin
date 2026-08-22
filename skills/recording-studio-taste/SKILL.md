---
name: recording-studio-taste
description: Judge and improve how Recording Studio screens look while staying on Flatpack. Use when composing gem, dummy, or Admin UI, reviewing screenshots, restyling a Flatpack component or theme, running a pre-flight before screenshots leave the bot, or when tempted to add custom CSS, Tailwind, or a third-party design skill. For which component to render, use recording-studio-flatpack. For page shape, use recording-studio-ui. For words, use recording-studio-text.
---

# Recording Studio taste

Flatpack is the kit. This skill is whether the page is any good, and whether a missing look belongs in Flatpack rather than in the caller.

This is **product UI**: gem screens, dummy, and Admin. It is not a landing restyle pack. Do not invent a parallel visual language.

## When to use

- Composing gem, dummy, or Admin UI
- Reviewing screenshots
- Restyling a Flatpack component or theme
- Running the pre-flight before screenshots leave the bot
- Tempted to add custom CSS, Tailwind, or a third-party design skill

## Design read

Before composing or reviewing, state this line:

Reading this as product UI on Flatpack rounded + core `recording_studio/default_layout` (`UsesDefaultLayout`), not a landing.

Gem screens, dummy, and Admin all read that way. Public slices use that same layout. Dummy Devise login may keep `layouts/application`.

If the brief is Featured In marketing / `recording_studio_publishable/application`, say so and **stop**. That is a different surface.

## Instructions

### One system: Flatpack

Look up the live kit the way a taste skill looks up an official package:

- Components: https://flatpack.bowerbird.io/
- Tokens and themes: Flatpack `docs/theming.md`
- Theme attribute: Flatpack `docs/dark_mode.md` (`html data-theme="rounded"`)

Do not invent CSS for something the kit has. Do not mix in a second system.

Two jobs:

1. **Compose.** Build from Flatpack on core `recording_studio/default_layout` (`UsesDefaultLayout`). Public slices use that same layout. Dummy Devise login may keep `layouts/application`.
2. **Evolve the kit.** If the look is common (button, search, dropdown, flash, card, empty state, theme token) and Flatpack is weak, change Flatpack. Do not ship a custom control in the gem. If unsure it is common enough, stop and ask Nic via DJ.

### Dials (this family, not landing)

Not a landing baseline. Product chrome. State these numbers, then use them:

- `DESIGN_VARIANCE: 3` — low. Predictable product chrome, not artsy chaos.
- `MOTION_INTENSITY: 2` — low. Hover and active via Flatpack only. No cinematic / GSAP.
- `VISUAL_DENSITY: 5` — medium. Daily app: room to breathe. Not art-gallery `py-32`. Not cockpit vanity totals.

**3 / 2 / 5.** Same on gem, dummy, and Admin.

How they drive the screen:

- **3** — same shell every time: default layout, `PageNav`, title, one primary. No masonry, no bento marketing grid, no serif hero. `Hero` and `Carousel` stay off product pages.
- **2** — Flatpack hover / active / loading / focus only. Use `--duration-fast` (150ms), `--duration-base` (200ms), `--duration-slow` (300ms). Rounded already paints `--shadow-button` and `--shadow-button-active`. No Motion, GSAP, sticky-stack, or horizontal-pan.
- **5** — stack with `--stack-gap-sm` (0.5rem), `--stack-gap-md` (1rem), `--stack-gap-lg` (1.5rem). Forms use `--form-control-padding`. Tables use `--table-padding`. Leave air. Do not squish stacks or fill the page with kitchen-sink toolbars or vanity totals.

Admin uses the same dials. A few high-signal widgets (`recording-studio-admin`). Dummy is not a restyle playground: rounded + default layout, then the real record.

### Type, color, radius, space

Use Flatpack tokens and the rounded theme. Look them up in `docs/theming.md` / `variables.css`. Do not invent parallel tokens.

**Theme.** Dummy must set `html data-theme="rounded"`. Missing rounded is a reject. Do not copy `default_layout` into dummy and edit it.

**Type.** Use the kit’s type as shipped. Titles through `PageTitle` / `PageHeader`: `--page-title-h1-size` … `--page-title-h6-size`. Body is `--surface-content-color`. Secondary is `--surface-muted-content-color`. Tooltips are `--tooltip-font-size`. No new font stack. No serif heroes. No Inter / Geist shopping.

**Color (rounded).** Near-black primary, light page, grey text. Name these, do not replace them:

- Primary: `--color-primary`, `--color-primary-hover`, `--color-primary-text`
- Secondary / ghost / default: `--color-secondary*`, `--color-ghost*`, `--color-default*`
- Status: `--color-success-*`, `--color-warning-*`, `--color-danger-*`
- Surfaces: `--surface-page-background-color`, `--surface-background-color`, `--surface-content-color`, `--surface-muted-background-color`, `--surface-muted-content-color`, `--surface-border-color`, `--surface-border-hover-color`
- Focus: `--color-ring`

No beige+brass marketing palette. No second accent. Brand primitives (`--brand-hue`, `--brand-chroma`, `--brand-lightness`) live in Flatpack. Do not fork them in the gem.

**Radius (rounded).** `--radius-sm` 0.75rem, `--radius-md` 1rem, `--radius-lg` 1.5rem, `--radius-xl` 2rem. Buttons, alerts, inputs inherit `--radius-md` (`--button-border-radius`, `--alert-border-radius`, `--popover-radius`). Do not pick a new corner language.

**Space.** `--stack-gap-*`, `--form-control-padding`, `--table-padding`. Density 5 uses those gaps. Not gallery padding. Not cockpit packing.

### Slot

`PageNav` right slot: only actions for the thing on the page. Access belongs there when the record is Accessible. Sign out and Root Switchable are site-wide — never in the slot.

### Interactive cycles

Every control people can use needs the Flatpack cycle: **loading, empty, error, hover, active**. Use kit states, not custom Motion / GSAP.

- **Loading:** `Button` `loading:`, `Skeleton`, pagination loading text.
- **Empty:** `EmptyState` (title, one line, one action). If an addon is not built, the screen is just the real record — no fake empty theatre.
- **Error:** input `error` / `help_text`, `Alert` (`style:` info / success / warning / danger). Copy: `recording-studio-text`.
- **Hover / active:** Flatpack `Card` `hover:`, `--color-*-hover`, `--surface-border-hover-color`, `--shadow-button-active`. Duration tokens only.
- **Flash:** one. Core `default_layout` already paints flash. Do not render notice again in the view. Do not add a second `Toast` for the same notice.

**Contrast (WCAG AA).** Button text on button fill (`--color-primary-text` on `--color-primary`). Form label, value, placeholder, helper, error, and `--color-ring` against `--surface-background-color`. Fail: white-on-white, grey-on-grey, ghost with no stroke.

**One primary action** per page. One `:primary` button. No duplicate CTA intent (Save + Update for the same write).

## AI tells

Reject these on product UI:

- Lorem / Acme / John Doe / fake-perfect metrics
- Elevate / Seamless / Unleash / Next-Gen (copy: `recording-studio-text`)
- Three vanity metric cards (`Card::Stat` is not a completeness trick)
- Junk placeholders, fake section labels, empty `PageNav` glyphs, empty rich-text
- Second flash; notice rendered again in the view
- More than one primary action
- Eyebrow on every section — do not label what the title already says
- Copy not audited (`recording-studio-text`)

If an addon is not built, ship the real record. No placeholder blocks.

## Screenshot gate

Reject before Nic sees it:

- CSS/JS not loaded, unstyled HTML
- Default layout missing on product pages
- Dummy home/login/sidebar instead of the gem screen
- Missing rounded
- Sign out or Root Switchable in the slot
- Double flash, empty glyphs, empty editor, placeholder sections
- Seeded records missing on list/show/edit/admin

## Pre-flight

Tick every box before screenshots leave the bot. One fail = not done.

- [ ] Design read declared (product UI, Flatpack rounded, `recording_studio/default_layout` / `UsesDefaultLayout`, not a landing)
- [ ] Dials stated: `DESIGN_VARIANCE 3` / `MOTION_INTENSITY 2` / `VISUAL_DENSITY 5`
- [ ] Flatpack looked up (https://flatpack.bowerbird.io/ + `docs/theming.md`)
- [ ] `html data-theme="rounded"` present (dummy missing rounded = reject)
- [ ] Product pages use core `default_layout` — not dummy home, login, or sidebar
- [ ] Dummy Devise login may keep `layouts/application`; everything else does not
- [ ] CSS/JS loaded; not unstyled HTML
- [ ] Slot holds only page actions (Access ok if Accessible; never Sign out or Root Switchable)
- [ ] `default_layout` was not copied into dummy and edited
- [ ] One flash (layout paints it; view does not render notice again)
- [ ] One primary action; no duplicate CTA intent
- [ ] No junk / placeholders / fake section labels / empty glyphs / empty editor
- [ ] Seeded records on list / show / edit / admin
- [ ] Copy audit (`recording-studio-text`; no Elevate / Seamless / Unleash / Next-Gen)
- [ ] No generic frontend pack installed (`leonxlnx/taste-skill`, minimalist-ui, GSAP, Motion, shadcn, Geist, Fluent, Carbon, Material, Phosphor)
- [ ] Common missing look → Flatpack change, not a custom control in the gem
- [ ] Button and form contrast pass WCAG AA
- [ ] Loading, empty, error, hover, active use Flatpack states
- [ ] Featured In / `recording_studio_publishable/application` was not used as gem chrome

## Do not

- Install `leonxlnx/taste-skill` or other generic frontend taste packs on gems or dummies.
- Recreate Flatpack in Tailwind, custom CSS, or a gem ViewComponent.
- Restyle around Flatpack (new fonts, serif heroes, bento marketing grids, GSAP) on product screens.
- Put marketing chrome or `recording_studio_publishable/application` on gem UI. Featured In marketing is a different surface.
- Drop landing-only devices onto product UI: heroes, marquees, GSAP sticky-stack / horizontal-pan, image-gen heroes, Liquid Glass, beige+brass, Inter / Geist shopping, shadcn / Fluent / Carbon / GOV.UK maps.

## Related

`recording-studio-flatpack`, `recording-studio-ui`, `recording-studio-text`, `recording-studio-admin`.
