---
name: minitest-coverage
description: Minitest coverage specialist for Recording Studio engines. Use when adding tests, reviewing coverage, or validating dummy-app wiring.
---

# Minitest coverage

Guide and write Minitest coverage for Recording Studio gems.

## Suites

Most Recording Studio gems have two suites, and both matter:

- Gem suite under `test/` for engine and library behavior
- Dummy app suite under `test/dummy/test/` for host-app wiring

Run both before considering work complete.

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
