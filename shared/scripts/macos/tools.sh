#!/bin/bash
set -euo pipefail
eval "$(/opt/homebrew/bin/brew shellenv)"
mise install --yes
git lfs install --skip-repo
