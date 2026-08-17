#!/usr/bin/env bash
set -euo pipefail

# Cloud Agent bootstrap for this plugin repo.
# There are no package-manager dependencies; Node is required to run
# scripts/validate-plugin.mjs after checkout.
command -v node >/dev/null
node -v
