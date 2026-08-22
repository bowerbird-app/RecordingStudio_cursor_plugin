---
name: recording-studio-taste
description: Judge and improve how Recording Studio screens look while staying on Flatpack. Use when composing gem, dummy, or Admin UI, reviewing screenshots, restyling a Flatpack component or theme, adding a host named theme, or when tempted to add custom CSS, Tailwind, or a third-party design skill. A review must return a four-part critique (not only a checklist). For which component to render, use recording-studio-flatpack. For page shape, use recording-studio-ui. For words, use recording-studio-text.
---

# Recording Studio taste

Flatpack is the kit. This skill is whether the page is any good, and whether a missing look belongs in Flatpack rather than in the caller.

Two jobs, both first-class:

1. **Compose** gem, dummy, and Admin product UI on rounded + core `recording_studio/default_layout`.
2. **Review and improve Flatpack** (the kit), including a host named theme when a full app needs its own look.

A Taste review says how the **actual page** would look better. Pre-flight is the fence after that, not the review. This is not a Tailwind / GSAP restyle pack. Do not invent a parallel visual language.

## When to use

- Composing gem, dummy, or Admin UI
- Reviewing or restyling a Flatpack component or theme (the kit)
- Adding a host named theme (Featured In, later hosts)
- Reviewing screenshots (return the four-part critique, not only ticks)
- Running the pre-flight after the critique
- Tempted to add custom CSS, Tailwind, or a third-party design skill

## Design read

Before composing or reviewing, name the surface in one line, then proceed. Do not stop.

- **Product** (gem / dummy / Admin): reading this as product UI on Flatpack rounded + core `recording_studio/default_layout` (`UsesDefaultLayout`), not a landing.
- **Kit review:** reading this as Flatpack itself (component or theme), not a gem screen.
- **Host theme / marketing:** reading this as a host named theme (for example `data-theme="featured-in"`). Product chrome stays `default_layout`. Marketing pages may use Flatpack `Hero` / `Carousel` under that theme.

Gem screens, dummy, and Admin stay product. Public slices use the same `default_layout`. Dummy Devise login may keep `layouts/application`. `recording_studio_publishable/application` is not a second public shell. Kitchen-sink `/demo` pages are not product screens.

## Critique (required)

A Taste review is this four-part output. Required when composing a page, reviewing a screenshot, or doing kit / host work. A checklist-only review is a fail. Pre-flight comes after this.

1. **One-line design read**
2. **What already looks good**
3. **3–7 specific “this would look better if…” notes**, each naming the Flatpack token or component to use
4. **One highest-leverage change**

Grain (point at the actual page):

- This title is too light vs body — `PageTitle` / `--surface-content-color`, not `--surface-muted-content-color`
- This stack gap is gallery, not density 5 — `--stack-gap-md` / `--stack-gap-lg`
- This is the one primary; that second button should be `Button` `style: :ghost`

“Tokens present / slot empty / rounded set” is fence, not a note. Do not restyle Flatpack or `rounded` to make the note true. Do not flatten `--gradient-*`. Do not cite `--surface-border-hover-color` on rounded as a visual win (no-op).

## Instructions

### One system: Flatpack

Look up the live kit the way a taste skill looks up an official package:

- Components: https://flatpack.bowerbird.io/
- Tokens and themes: Flatpack `docs/theming.md`
- Theme attribute: Flatpack `docs/dark_mode.md`
- Token source: Flatpack `app/assets/stylesheets/flat_pack/variables.css`

Do not invent CSS for something the kit has. Do not mix in a second system.

On product screens:

1. **Compose.** Build from Flatpack on core `recording_studio/default_layout` (`UsesDefaultLayout`). Public slices use that same layout. Dummy Devise login may keep `layouts/application`.
2. **Evolve the kit.** If the look is common (button, search, dropdown, flash, card, empty state, theme token) and Flatpack is weak, change Flatpack. Do not ship a custom control in the gem. If unsure it is common enough, stop and ask Nic via DJ.

### Dials (product chrome: gem / dummy / Admin)

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

Use Flatpack tokens. Look them up in `docs/theming.md` / `variables.css`. For rounded, read the `[data-theme="rounded"]` block in `variables.css`, not the `docs/theming.md` `:root` table. Do not invent parallel tokens.

**Theme (product).** Dummy and gem screens stay `html data-theme="rounded"`. Missing rounded on dummy is a reject. Do not copy `default_layout` into dummy and edit it. Kitchen-sink `/demo` pages are not product screens.

**Type.** Use the kit’s type as shipped. Titles through `PageTitle` / `PageHeader`: `--page-title-h1-size` … `--page-title-h6-size`. Body is `--surface-content-color`. Secondary is `--surface-muted-content-color`. Tooltips are `--tooltip-font-size`. No new font stack in the gem, dummy, or host. No serif heroes. No Inter / Geist shopping. If a brand needs type or radius, it lands in the Flatpack theme.

**Color (rounded product).** Near-black primary, light page, grey text. Name these, do not replace them on dummy / gem:

- Primary: `--color-primary`, `--color-primary-hover`, `--color-primary-text`
- Secondary / ghost / default: `--color-secondary*`, `--color-ghost*`, `--color-default*`
- Status: `--color-success-*`, `--color-warning-*`, `--color-danger-*`
- Surfaces: `--surface-page-background-color`, `--surface-background-color`, `--surface-content-color`, `--surface-muted-background-color`, `--surface-muted-content-color`, `--surface-border-color`, `--surface-border-hover-color`
- Focus: `--color-ring`

No beige+brass marketing palette on product screens. No second accent in the gem. Brand primitives (`--brand-hue`, `--brand-chroma`, `--brand-lightness`) live in Flatpack. Do not fork them in the gem.

**Radius (rounded).** Read the theme block, not the `:root` table in `docs/theming.md`. Rounded is `--radius-sm` 0.75rem, `--radius-md` 1rem, `--radius-lg` 1.5rem, `--radius-xl` 2rem. Buttons, alerts, inputs inherit `--radius-md` (`--button-border-radius`, `--alert-border-radius`, `--popover-radius`). Do not pick a new corner language in the caller.

**Space.** `--stack-gap-*`, `--form-control-padding`, `--table-padding`. Density 5 uses those gaps. Not gallery padding. Not cockpit packing.

**Rounded facts** (from `[data-theme="rounded"]` in `variables.css`):

- Do not flatten `--gradient-1` … `--gradient-4`. Rounded ships them (slate, amber, green, violet).
- Hover-border is a no-op: `--surface-border-hover-color` and `--surface-border-color` are both `#d1d5db`. Do not cite hover-border as a look fix. Use `--color-*-hover`, `Card` `hover:`, `--shadow-button-active`.
- Warning text stays dark on amber: `--color-warning-text: #1f1f1f` on `--color-warning-background-color: oklch(0.80 0.15 83)`. Do not “fix” it to white (`:root` warning text is white; rounded is not).
- Muted `--surface-muted-content-color: #666` needs an AA check against the actual fill (`--surface-background-color` `#f8f9fa` vs `--surface-muted-background-color` `#e5e5e5`).

### Slot

`PageNav` right slot: only actions for the thing on the page. Access belongs there when the record is Accessible. Sign out and Root Switchable are site-wide — never in the slot.

### Interactive cycles

Every control people can use needs the Flatpack cycle: **loading, empty, error, hover, active**. Use kit states, not custom Motion / GSAP.

- **Loading:** `Button` `loading:`, `Skeleton`, pagination loading text.
- **Empty:** `EmptyState` (title, one line, one action). If an addon is not built, the screen is just the real record — no fake empty theatre.
- **Error:** input `error` / `help_text`, `Alert` (`style:` info / success / warning / danger). Copy: `recording-studio-text`.
- **Hover / active:** Flatpack `Card` `hover:`, `--color-*-hover`, `--shadow-button-active`. Duration tokens only. On rounded, `--surface-border-hover-color` is a no-op (same as `--surface-border-color`).
- **Flash:** one. Core `default_layout` already paints flash. Do not render notice again in the view. Do not add a second `Toast` for the same notice.

**Contrast (WCAG AA).** Button text on button fill (`--color-primary-text` on `--color-primary`). Form label, value, placeholder, helper, error, and `--color-ring` against `--surface-background-color`. Fail: white-on-white, grey-on-grey, ghost with no stroke.

**One primary action** per page. One `:primary` button. No duplicate CTA intent (Save + Update for the same write).

### Host named theme

Custom Flatpack styles for a full app (Featured In, later hosts) are in scope. They are a named theme in Flatpack, not a restyle around the kit.

Wire it the way `docs/theming.md` and `docs/custom_theming.md` already do:

- Built-in variants are override-only: `[data-theme="dark"]`, `ocean`, `rounded` (`docs/dark_mode.md`). A host look is another named selector, for example `[data-theme="featured-in"]`, in Flatpack `variables.css`.
- Prefer brand primitives: `--brand-hue`, `--brand-chroma`, `--brand-lightness`. `--color-primary` is `oklch(var(--brand-lightness) var(--brand-chroma) var(--brand-hue))`. Hover is 0.10 darker. Surfaces pick up `--brand-hue` only.
- Exact brand hex: set `--color-primary` and `--color-primary-hover` instead of inventing new color names (`docs/theming.md`).
- Host only sets `html data-theme="featured-in"` (and those brand tokens if that is the documented hook). Optional switcher: `flat-pack--theme`. Do not put Flatpack tokens back into a Tailwind `@theme` block.

Rules:

- Dummy / gem screens stay `data-theme="rounded"`.
- Host must not add a parallel stylesheet, Tailwind restyle, or copy `default_layout` to restyle it.
- Product chrome stays `default_layout`. `recording_studio_publishable/application` is not a second public shell.
- Marketing pages may use Flatpack `Hero` / `Carousel` under the host theme.
- Do not invent fonts or a second radius language in the host. If the brand needs those, they land in the Flatpack theme.
- One product’s brand is a named theme. Do not special-case `rounded` to match Featured In.

## Reviewing and improving Flatpack itself

When the work is Flatpack (the kit), not a gem screen.

### When to use

- A Flatpack component or theme is weak, inconsistent, or missing a common look
- Recapturing a Flatpack demo page after a kit change
- Deciding theme token vs new prop vs named theme

### Instructions

1. Look up the component on https://flatpack.bowerbird.io/ and in Flatpack `docs/theming.md` / `variables.css`.
2. Audit: public API, tokens, loading / empty / error / hover / active, WCAG AA, rounded theme still works.
3. Prefer a theme token or an existing prop over a new one-off prop. Component tokens (`--button-*`, `--alert-*`) stay `var(--semantic)`. Named themes override brand / semantic tokens only (`docs/theming.md` hierarchy).
4. If the look is common across apps, change the component or `rounded`. If it is one product’s brand, add a named theme. Do not special-case `rounded`.
5. Recapture the Flatpack demo page for that component. Do not break `dark`, `ocean`, `rounded`, or other named themes.
6. Run `bin/rake flat_pack:audit_tokens` when tokens move. Fail if a `var(--*)` in the gem is missing from `variables.css`.

### Do not

- Tailwind-restyle Flatpack, add GSAP / Motion, or mix in a second kit
- Ship a one-off prop when a token or existing prop already covers it
- Special-case `rounded` for one host’s brand
- Skip the demo recapture, or leave other themes broken
- Invent fonts, radius, or color names that are not in `variables.css`

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
- Kitchen-sink `/demo` pages treated as product screens
- Missing rounded on dummy / gem product screens (a host named theme is not this fail)
- Sign out or Root Switchable in the slot
- Double flash, empty glyphs, empty editor, placeholder sections
- Seeded records missing on list/show/edit/admin

Featured In theme work is not a fail.

## Pre-flight

Tick every box on the shared list, then the track you are on. One fail = not done. This is the fence after the critique, not the review itself.

### Shared

- [ ] Four-part critique returned (design read, what looks good, 3–7 specific notes with tokens/components, one highest-leverage change). Checklist-only is a fail
- [ ] Design read declared (product / kit review / host theme — then proceed)
- [ ] Flatpack looked up (https://flatpack.bowerbird.io/ + `docs/theming.md`; rounded radii from the theme block, not the `:root` table)
- [ ] CSS/JS loaded; not unstyled HTML
- [ ] No generic frontend pack installed (`leonxlnx/taste-skill`, minimalist-ui, GSAP, Motion, shadcn, Geist, Fluent, Carbon, Material, Phosphor)
- [ ] Product chrome is still `default_layout` (publishable application is not a second public shell)

### Gem / dummy / Admin

- [ ] Dials stated: `DESIGN_VARIANCE 3` / `MOTION_INTENSITY 2` / `VISUAL_DENSITY 5`
- [ ] `html data-theme="rounded"` present (dummy missing rounded = reject)
- [ ] Product pages use core `default_layout` — not dummy home, login, sidebar, or kitchen-sink `/demo`
- [ ] Dummy Devise login may keep `layouts/application`; everything else does not
- [ ] Slot holds only page actions (Access ok if Accessible; never Sign out or Root Switchable)
- [ ] `default_layout` was not copied into dummy and edited
- [ ] One flash (layout paints it; view does not render notice again)
- [ ] One primary action; no duplicate CTA intent
- [ ] No junk / placeholders / fake section labels / empty glyphs / empty editor
- [ ] Seeded records on list / show / edit / admin
- [ ] Copy audit (`recording-studio-text`; no Elevate / Seamless / Unleash / Next-Gen)
- [ ] Common missing look → Flatpack change, not a custom control in the gem
- [ ] Button and form contrast pass WCAG AA
- [ ] Loading, empty, error, hover, active use Flatpack states

### Flatpack review

- [ ] Demo looked up for that component
- [ ] Rounded still works
- [ ] New look is a theme token, existing prop, component change, or named theme — not a one-off prop, not special-cased `rounded`
- [ ] Other themes (`dark`, `ocean`, `rounded`, host names) not broken
- [ ] Demo recaptured
- [ ] No Tailwind / GSAP / second kit inside Flatpack
- [ ] `bin/rake flat_pack:audit_tokens` considered when tokens moved

### Host theme

- [ ] Named theme lives in Flatpack (`[data-theme="featured-in"]` or the host’s name)
- [ ] Wired through `--brand-hue` / `--brand-chroma` / `--brand-lightness` (or `--color-primary` / `--color-primary-hover` for an exact hex)
- [ ] Host only sets the theme attribute + those documented brand tokens
- [ ] Dummy / gem still `data-theme="rounded"`
- [ ] No parallel stylesheet / no Tailwind `@theme` remapping / no `default_layout` fork
- [ ] No invented fonts or radius in the host
- [ ] Product chrome still `default_layout`
- [ ] Marketing pages may use `Hero` / `Carousel` under the host theme; gem UI does not
- [ ] Featured In theme work is not treated as a fail

## Do not

- Install `leonxlnx/taste-skill` or other generic frontend taste packs on gems, dummies, or Flatpack.
- Recreate Flatpack in Tailwind, custom CSS, or a gem ViewComponent.
- Restyle around Flatpack (new fonts, serif heroes, bento marketing grids, GSAP) on product screens.
- Put marketing chrome or `recording_studio_publishable/application` on gem UI. Product chrome stays `default_layout`.
- Drop landing-only devices onto product UI: marquees, GSAP sticky-stack / horizontal-pan, image-gen heroes, Liquid Glass, beige+brass, Inter / Geist shopping, shadcn / Fluent / Carbon / GOV.UK maps.
- Special-case `rounded` for one host. Add a named theme instead.
- Add a parallel host stylesheet to restyle the kit.
- Treat Flatpack kitchen-sink `/demo` pages as product screens.
- Flatten `--gradient-*` on rounded, or cite `--surface-border-hover-color` as a rounded visual fix.
- Return only pre-flight ticks. The critique is the review.

## Related

`recording-studio-flatpack`, `recording-studio-ui`, `recording-studio-text`, `recording-studio-admin`.

`recording-studio-minimalist` (separate PR, in flight) is the opt-in editorial look for host themes that want warm bone / tight type / no gradients. It is not compulsory. Dummy / gem / Admin stay this skill + rounded.
