#!/bin/bash
set -euo pipefail
[ -x /opt/homebrew/bin/brew ] && exit 0
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
