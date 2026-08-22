---
name: recording-studio-minimalist
description: Express an opt-in editorial Flatpack named theme (warm bone paper, tight type, no gradients) for host marketing and brand surfaces. Use when a host named theme should feel editorial — not for dummy, gem, or Admin product chrome, and not as always-on taste. For compose, kit review, and host named themes in general, use recording-studio-taste. For components, use recording-studio-flatpack. For words, use recording-studio-text.
---

# Recording Studio minimalist

The **editorial look**: warm bone paper, tight type, no gradients. Opt-in. A named Flatpack theme, not a smaller pack, and not “make every screen quieter.”

This is not product chrome. Dummy, gem, and Admin stay `recording-studio-taste` + `data-theme="rounded"` + core `recording_studio/default_layout`. Taste stays the product / kit skill. This skill is never always-on and is not a rule.

## When to use

- A host named Flatpack theme should feel editorial (marketing or brand surfaces that benefit)
- Tempted to reach for `leonxlnx/taste-skill`, a generic `minimalist-ui` pack, a Tailwind restyle, GSAP, or shadcn to get that look

## When not to use

- Dummy, gem, or Admin screens — those stay Taste + `rounded` + `default_layout`
- Making `rounded` look editorial, or special-casing `rounded` for one host
- Quiet-down-everything restyles of product chrome
- Featured In or dummy implementation — this skill is the look, not a restyle PR

## Instructions

1. Look up Flatpack `docs/theming.md`, `docs/custom_theming.md`, `docs/dark_mode.md`, and `app/assets/stylesheets/flat_pack/variables.css`. Do not invent token names.
2. Express the look as a **named theme in Flatpack** (`[data-theme="minimalist"]` or the host’s name). Built-in variants (`dark`, `ocean`, `rounded`) stay override-only. Do not change `rounded`.
3. Wire brand the way `docs/theming.md` already does:
   - Prefer `--brand-hue` / `--brand-chroma` / `--brand-lightness`. `--color-primary` is `oklch(var(--brand-lightness) var(--brand-chroma) var(--brand-hue))`. Hover is 0.10 darker. Surfaces pick up `--brand-hue` only.
   - Exact brand hex: set `--color-primary` and `--color-primary-hover` instead of inventing new color names.
4. Host only sets `html data-theme="minimalist"` (or the host’s name) plus those documented tokens. Optional switcher: `flat-pack--theme`. Missing looks go into Flatpack. Do not add a parallel stylesheet, remap tokens in a Tailwind `@theme` block, or fork `default_layout`.
5. Type or radius the brand needs lands in the Flatpack theme. No new font stack in the host.

## Editorial bans (bind them to kit tokens)

Look up values in `docs/theming.md` / `variables.css`. Do not invent hex in the host.

- **No gradients.** Do not paint `--gradient-1` … `--gradient-4`. If a component still references them, flatten those tokens to solid fills in the Flatpack named theme.
- **No junk chrome.** No extra shell, kitchen-sink toolbar, vanity totals, second flash, or empty glyphs. Marketing pages may use Flatpack `Hero` / `Carousel` under this theme. Product chrome stays Taste + `rounded` + `default_layout`.
- **Tight type.** Use kit type tokens as shipped: `--page-title-h1-size` … `--page-title-h6-size` through `PageTitle` / `PageHeader`, body `--surface-content-color`, secondary `--surface-muted-content-color`, tooltips `--tooltip-font-size`. Tight means those sizes (or a tighter scale **in the Flatpack theme**), not a host font stack. No Geist / Inter shopping.
- **Warm bone paper.** Tune `--surface-page-background-color`, `--surface-background-color`, and `--surface-muted-background-color` in the Flatpack named theme. Surfaces follow `--brand-hue`. Do not drop a host beige hex beside the kit.

## Do not

- Install `leonxlnx/taste-skill`, a generic `minimalist-ui` pack, Tailwind restyles, GSAP, Motion, shadcn, Geist, Fluent, Carbon, or Material
- Restyle dummy or gem screens, or treat this as always-on taste
- Special-case `rounded` so product chrome looks editorial
- Put Flatpack tokens back into a Tailwind `@theme` block
- Ship this look by editing `default_layout` or adding a parallel stylesheet

## Related

`recording-studio-taste` (compose / kit review / host named themes in general), `recording-studio-flatpack`, `recording-studio-ui`, `recording-studio-text`.
