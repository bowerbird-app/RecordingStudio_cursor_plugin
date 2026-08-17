---
name: minitest-coverage
description: Minitest coverage specialist for Recording Studio engines and dummy apps. Use when adding tests, reviewing coverage, or validating host-app wiring.
---

# Minitest coverage

Guide and write Minitest coverage for Recording Studio gems.

## Suites

These gems have two suites. Both are required:

- Gem suite under `test/` for engine and library behavior
- Dummy app suite under `test/dummy/test/` for host-app wiring and integration

Run both before considering work complete. Gem-only coverage is not enough when the change can affect mount, initializers, routes, assets, or host-app wiring.

## Coverage target

Aim for high coverage. The usual working target is about **94%** — a chosen bar, not a sacred threshold. Default to bringing coverage back near that level when it drops, while prioritizing tests that falsify real behavior over empty percentage gains.

## Expectations

- Cover happy path, failure path, edge cases, and nil/blank input.
- Prefer unit tests for POROs and services; keep integration tests thin.
- Keep tests fast and deterministic.
- Assert event counts and actions, not direct mutations of immutable recordables.
- Cover configuration defaults, hook ordering, generators, and declaration validation.
- Never delete, stub out, or bypass production code to make tests pass.

## Recording Studio specifics

- Assert a new recordable row is created on `revise`.
- Assert `Event` actions and counts for write paths.
- Cover root and parent rejection paths for recordable declarations.
- Use `idempotency_key` for retriable flows.
