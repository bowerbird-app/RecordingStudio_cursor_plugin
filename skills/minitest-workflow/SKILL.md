---
name: minitest-workflow
description: Add or review Minitest coverage for Recording Studio gems, generators, hooks, and dummy-app wiring. Use when writing tests, checking coverage, or validating engine behavior before merge.
---

# Minitest workflow

## When to use

- Adding or updating Minitest coverage
- Writing regression tests for generators, hooks, services, or engine wiring
- Verifying dummy-app boot, assets, or migrations
- Reviewing whether validation coverage is enough before merge

## Procedure

1. Identify the narrowest tests that can falsify the change.
2. Add focused happy-path, failure-path, and edge-case coverage.
3. Prefer unit tests for POROs and services, and thin integration tests for engine wiring.
4. Preserve public behavior. Do not bypass production code to make tests pass.
5. Run `bundle exec rake test` from the repository root.
6. If dummy-app boot, assets, or migrations changed, run the dummy app setup used in CI as well.

## Recording Studio expectations

- Cover configuration defaults and overrides.
- Cover hook ordering, arguments, and error isolation.
- Assert immutable recordables and event history on write paths.
- Keep tests fast, deterministic, and scoped to the change.
