---
name: recording-studio-ui
description: Design Recording Studio screens as gem-owned UI slices and mini-apps. Use when adding or changing views, choosing page shape, mounting a gem's screens, deciding layout or navigation, or reaching for custom CSS or JavaScript. Prefer this skill for UI architecture; use flatpack-ui for which components to render.
---

# Recording Studio UI

Recording Studio UI is **minimal on purpose**. Gems ship a **UI slice** the host can mount and use immediately. Screens stay small, one-job, and independent so they work on phones and so addons do not fight over layout.

Build with **Flatpack ViewComponents**. Do not add custom CSS or JavaScript unless Flatpack and the core layout truly cannot do the job. If you think you need custom chrome, explain the gap first.

For which component to render, follow `flatpack-ui`. This skill is the shape of the product: slices, mini-apps, page layout, and ownership.

## UI slices

Every addon should arrive with a **UI slice** (and usually an **API slice**). Installing the gem should give the host usable screens, not a pile of helpers the app still has to skin.

A UI slice is a contained set of views and controllers for one capability. The host **mounts** it. People can complete the job without the host reinventing the screens.

That is how new products come together quickly: assemble slices, choose routes, override only what must differ.

## Gems own the views

Keep views and controllers **in the gem**. When the gem improves a screen, every host that has not overridden it gets the upgrade.

The host owns **routes** (where the slice is mounted) and may override a view or controller when the product must diverge. Do not copy gem templates into the app “just in case.” Do not put domain rules only in a view — keep them in core methods the UI, API, and overrides can share.

See `recording-studio-approach` for the three-layer split (core methods, gem UI, app routes).

## Each gem is a mini-app

Think of a gem’s UI as a **small app inside the product**, not as scattered pages bolted onto a shared dashboard.

The usual shape:

1. The host **mounts** the gem at a path.
2. That entry screen is a **section**: it explains the area and links to the child screens.
3. Child screens do the work (index, show, new, edit, and one-shot actions).
4. When the person is done, they **close or go back** to the place that opened the mini-app — often a home screen that lists these areas.

**Admin** is the clearest example: mount admin under a root, get a section, then screens and widgets underneath. **Webhooks** works the same way: mount the webhook admin screens, get a section, then the CRUD and delivery screens below it.

A home (or similar hub) is the board that links these mini-apps together. The mini-apps themselves stay independent. They should not assume they sit inside another gem’s chrome.

## Minimal screens, one clear action

Prefer **one primary action per page**. A screen that moves a folder is better than a screen that also publishes, assigns, and edits settings.

This is not a visual preference. It is what makes the ecosystem work:

- **Mobile.** A single action plus the core layout fits a phone without a custom responsive redesign.
- **Independence.** Screens do not share a crowded shell, so gems can compose without CSS and nav collisions.
- **Clarity.** People finish one job, then leave.

Do not build kitchen-sink dashboards inside an addon. If several actions belong together, link them from the section screen and keep each action on its own page.

## The default page

Recording Studio core ships a **simple default layout**: focused on the current job, with **back** and **close** so people can leave the mini-app without extra nav chrome. Addon gems should use that layout. Do not invent a competing application shell.

A typical page is:

1. A Flatpack **page title**
2. An optional **subtitle** (one line of context)
3. An optional **row of buttons** (secondary actions or the primary submit if it sits in the header)
4. A **form** or the single piece of content the page exists for

That is enough. Lists, confirmations, and success/error alerts still belong in Flatpack. They should not grow into a second layout.

User-facing copy must not say "recording" or "recordable". Use product words: workspace, folder, page, webhook, site.

## Flatpack, not custom CSS and JS

Use **Flatpack ViewComponents** for buttons, forms, alerts, cards, titles, navigation, and similar chrome.

View components keep the UI **DRY and testable**: one component API, shared markup, and screens that can be rendered in tests without a one-off HTML dialect per gem.

Rules:

- Search this repo and https://flatpack.bowerbird.io/ before writing markup.
- Semantic layout wrappers are fine when Flatpack has no structure for them.
- **Avoid custom CSS and JavaScript** unless there is no Flatpack or core-layout path.
- If Flatpack cannot support the requirement, **explain the gap** before adding custom UI. Ask whether Flatpack should grow the component rather than forking styles in the gem.
- Do not rewrite unrelated legacy UI just because it is in a touched file.

## Do not

- Hand-roll buttons, forms, titles, or nav when Flatpack already has them.
- Add gem-specific CSS/JS to “make it look finished.”
- Put the gem’s screens in the host so they can be tweaked; override only what must differ.
- Build a wide dashboard of unrelated actions in one addon page.
- Invent a new layout, sidebar, or modal-heavy flow that other gems cannot share.
- Assume your screens sit inside another gem’s header. Use the core layout and back/close.

## Related skills

| Need | Skill |
|---|---|
| Which Flatpack component to render | `flatpack-ui` |
| Setup order | `getting-started-recording-studio` |
| Philosophy and gem ownership | `recording-studio-approach` |
| Admin sections and screens | `setup-admin-screens` |
| Same actions over HTTP | `recording-studio-api` |
