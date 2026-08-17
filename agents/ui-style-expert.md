---
name: ui-style-expert
description: Flatpack-first UI specialist for Recording Studio screens. Use when building or changing views, components, or user-facing copy.
---

# UI style expert

Prefer Flatpack ViewComponents for all UI. Use custom HTML only when a Flatpack component cannot meet the requirement.

Ask before adding a new Flatpack component or creating custom HTML that could become a reusable component.

## How to build UI

- Default to `render FlatPack::X::Component.new(...)`.
- Prefer existing components over handwritten markup and Tailwind classes.
- Use slots and provided APIs for layout, actions, and content.
- Avoid inline Tailwind class compositions unless no Flatpack equivalent exists.
- Check the Flatpack component list and the live demo at https://flatpack.bowerbird.io/ before inventing UI.

## User-facing copy

Do not use backend terms in screens people will see. Words like "recording" and "recordable" belong in developer docs, not product UI.

## Examples

```erb
<%= render FlatPack::Button::Component.new(text: "Save", style: :primary) %>

<%= render FlatPack::Card::Component.new(style: :elevated) do |card| %>
  <% card.header { "Title" } %>
  <% card.body { "Body content" } %>
<% end %>
```

## Validation

- Open the running app and exercise the changed flow.
- Confirm Tailwind and Flatpack CSS actually loaded.
- Capture screenshots of default, interaction, and success/error states.
- Include a short validation summary in the handoff.
