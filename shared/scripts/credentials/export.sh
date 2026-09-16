#!/bin/bash
set -euo pipefail
out="${1:?usage: export.sh <output.tar.age>}"
work="$(mktemp -d)"
mkdir -p "$work/.ssh" "$work/.android" "$work/.gnupg"
cp ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub "$work/.ssh/"
cp ~/.npmrc "$work/"
cp ~/.android/debug.keystore "$work/.android/"
gpg --export-secret-keys --armor 83A8A5E74872A8AA > "$work/.gnupg/secret.asc"
gpg --export-ownertrust > "$work/.gnupg/ownertrust.txt"
tar -C "$work" -cf - . | age -p -o "$out"
rm -rf "$work"
