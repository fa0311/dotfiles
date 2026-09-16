#!/bin/bash
set -euo pipefail
in="${1:?usage: import.sh <input.tar.age>}"
work="$(mktemp -d)"
age -d "$in" | tar -C "$work" -xf -
mkdir -p ~/.ssh ~/.android
cp "$work/.ssh/id_ed25519" "$work/.ssh/id_ed25519.pub" ~/.ssh/
chmod 600 ~/.ssh/id_ed25519
cp "$work/.npmrc" ~/
chmod 600 ~/.npmrc
cp "$work/.android/debug.keystore" ~/.android/
gpg --import "$work/.gnupg/secret.asc"
gpg --import-ownertrust "$work/.gnupg/ownertrust.txt"
rm -rf "$work"
