#!/bin/bash
set -euo pipefail
out="$(cd "$(dirname "$0")/../../.." && pwd)/secret"
mkdir -p "$out/.ssh" "$out/.gnupg"
cp ~/.ssh/id_ed25519 "$out/.ssh/"
gpg --export-secret-keys --armor 83A8A5E74872A8AA > "$out/.gnupg/secret.asc"
