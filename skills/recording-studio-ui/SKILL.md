---
name: recording-studio-ui
description: Design Recording Studio screens as mountable UI slices with reusable helpers and view components. Use when adding or changing views, choosing page shape, mounting a gem's screens, replacing gem UI in a host app, deciding layout or navigation, or reaching for custom CSS or JavaScript. Prefer this skill for UI architecture; use flatpack-ui for which components to render.
---

# Recording Studio UI

Recording Studio UI is **minimal on purpose**. Gems ship **working UI slices** the host can mount immediately, and they ship the **pieces** of that UI so a host can replace the views and controllers without losing the capability. Screens stay small, one-job, and independent so they work on phones and so addons do not fight over layout.

Build with **Flatpack ViewComponents**. Do not add custom CSS or JavaScript unless Flatpack and the core layout truly cannot do the job. If you think you need custom chrome, explain the gap first.

For which component to render, follow `flatpack-ui`. This skill is the shape of the product: slices, mount points, page layout, and ownership.

## UI slices

Every addon should arrive with at least one **UI slice** (and usually an **API slice**). Installing the gem should give the host usable screens, not a pile of internals the app still has to skin.

A UI slice is a contained set of views and controllers for one **mount point**. The host mounts it. People can complete that job without the host reinventing the screens.

A gem often has **more than one slice**. User-facing screens and a separate admin section are two slices of the same gem, not one blob of UI.

That is how new products come together quickly: assemble slices, choose routes, keep or replace the default screens.

## Default UI, replaceable by the host

Keep default views and controllers **in the gem** so a host that uses them gets upgrades. Design those screens so a host that **does not** use them still gets a working product.

Hosts should be able to:

- mount the gem’s screens as-is
- override a view or controller
- skip the gem screens and build their own, calling the same **core methods**

Do not bury the interesting UI only inside a gem template. Anything a host might want on *their* screen — a root switcher, an access grant widget, a “move this item” control — must also exist as a **helper or ViewComponent**.

**Root Switchable** is the pattern: the gem can ship screens, but the switcher itself is a reusable helper/component so a host layout, a custom home, or another gem can render it.

Put domain rules in **core methods**, not only in a gem controller. The default UI, a host override, and the API all call the same methods.

The host owns **routes** (what is mounted, and where). Do not copy gem templates into the app “just in case.” Override or replace only what must differ.

See `recording-studio-approach` for the three-layer split (core methods, gem UI, app routes).

## Mount points navigate like mini-apps

A gem is **not** one mini-app. A gem may expose **several mountable points**. Each mount point navigates like a small app: enter, do the work, close or go back.

Examples:

| Gem | Mount points (each navigates on its own) |
|---|---|
| **Webhooks** | User or workspace screens for endpoints, **and** a separate admin section for site admins |
| **Users** | Sign-in / profile / invitations, **and** an admin section for people management |
| **Admin** | The admin surface itself, mounted under an admin root, with sections underneath |

The usual shape **per mount point**:

1. The host **mounts** that slice at a path.
2. The entry screen is a **section**: it explains the area and links to the child screens.
3. Child screens do the work (index, show, new, edit, and one-shot actions).
4. When the person is done, they **close or go back** to whatever opened this mount point — often a home or hub that lists these areas.

A home (or similar hub) links mount points together. The mount points stay independent. They should not assume they sit inside another slice’s chrome.

**Admin** is the clearest single-surface example: mount admin under a root, get a section, then screens and widgets underneath. **Webhooks** shows the multi-slice case: user screens in one place, admin screens in another, same gem, two mini-app navigation stacks.

## Minimal screens, one clear action

Prefer **one primary action per page**. A screen that moves a folder is better than a screen that also publishes, assigns, and edits settings.

This is not a visual preference. It is what makes the ecosystem work:

- **Mobile.** A single action plus the core layout fits a phone without a custom responsive redesign.
- **Independence.** Screens do not share a crowded shell, so mount points can compose without CSS and nav collisions.
- **Clarity.** People finish one job, then leave.

Do not build kitchen-sink dashboards inside a slice. If several actions belong together, link them from the section screen and keep each action on its own page.

## The default page

Recording Studio core ships a **simple default layout**: focused on the current job, with **back** and **close** so people can leave the current mount point without extra nav chrome. Addon gems should use that layout. Do not invent a competing application shell.

A typical page is:

1. A Flatpack **page title**
2. An optional **subtitle** (one line of context)
3. An optional **row of buttons** (secondary actions or the primary submit if it sits in the header)
4. A **form** or the single piece of content the page exists for

That is enough. Lists, confirmations, and success/error alerts still belong in Flatpack. They should not grow into a second layout.

User-facing copy must not say "recording" or "recordable". Use product words: workspace, folder, page, webhook, site.

## Flatpack, not custom CSS and JS

Use **Flatpack ViewComponents** for buttons, forms, alerts, cards, titles, navigation, and similar chrome.

View components keep the UI **DRY and testable**: one component API, shared markup, and screens that can be rendered in tests without a one-off HTML dialect per gem. The same reason applies to **gem-provided** helpers and components — hosts and other slices can render them without copying markup.

Rules:

- Search this repo and https://flatpack.bowerbird.io/ before writing markup.
- Semantic layout wrappers are fine when Flatpack has no structure for them.
- **Avoid custom CSS and JavaScript** unless there is no Flatpack or core-layout path.
- If Flatpack cannot support the requirement, **explain the gap** before adding custom UI. Ask whether Flatpack should grow the component rather than forking styles in the gem.
- Do not rewrite unrelated legacy UI just because it is in a touched file.

## Do not

- Hand-roll buttons, forms, titles, or nav when Flatpack already has them.
- Add gem-specific CSS/JS to “make it look finished.”
- Trap a reusable control (switcher, picker, grant widget) inside a gem-only template. Ship a helper or ViewComponent.
- Assume the host will always keep the gem’s controllers and views. Design for replacement.
- Treat the whole gem as one navigation stack when it has both user and admin (or other) mount points.
- Build a wide dashboard of unrelated actions in one addon page.
- Invent a new layout, sidebar, or modal-heavy flow that other slices cannot share.
- Assume your screens sit inside another slice’s header. Use the core layout and back/close.

## Related skills

| Need | Skill |
|---|---|
| Which Flatpack component to render | `flatpack-ui` |
| Setup order | `getting-started-recording-studio` |
| Philosophy and gem ownership | `recording-studio-approach` |
| Admin sections and screens | `setup-admin-screens` |
| Same actions over HTTP | `recording-studio-api` |
