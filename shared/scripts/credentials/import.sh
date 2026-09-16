#!/bin/bash
set -euo pipefail
in="$(cd "$(dirname "$0")/../../.." && pwd)/secret"
mkdir -p ~/.ssh
cp "$in/.ssh/id_ed25519" ~/.ssh/
chmod 600 ~/.ssh/id_ed25519
gpg --import "$in/.gnupg/secret.asc"
