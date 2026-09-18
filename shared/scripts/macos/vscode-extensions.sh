#!/bin/bash
set -euo pipefail

create_profiles() {
  local cli="$1" bundle="$2" proc="$3" tsv="$4" profile created=
  while read -r profile; do
    "$cli" --profile "$profile" --list-extensions >/dev/null 2>&1 </dev/null && continue
    "$cli" --profile "$profile" --new-window </dev/null
    until "$cli" --profile "$profile" --list-extensions >/dev/null 2>&1 </dev/null; do sleep 1; done
    created=1
  done < <(cut -f1 "$tsv" | grep -vx default | sort -u)
  if [ -n "$created" ]; then
    until lsappinfo info -only pid "$bundle" | grep -q pid; do sleep 1; done
    osascript -e "tell application id \"$bundle\" to quit"
    until ! pgrep -x "$proc" >/dev/null; do sleep 1; done
  fi
}

install_from_tsv() {
  local cli="$1" tsv="$2" only="$3"
  while IFS=$'\t' read -r profile ext target; do
    [ "$target" = all ] || [ "$target" = "$only" ] || continue
    if [ "$profile" = default ]; then
      "$cli" --install-extension "$ext" </dev/null
    else
      "$cli" --profile "$profile" --install-extension "$ext" </dev/null
    fi
  done <"$tsv"
}

CODE="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
CURSOR="/Applications/Cursor.app/Contents/Resources/app/bin/cursor"
create_profiles "$CODE" com.microsoft.VSCode Code "$HOME/.config/vscode/extensions.tsv"
install_from_tsv "$CODE" "$HOME/.config/vscode/extensions.tsv" code
create_profiles "$CURSOR" com.todesktop.230313mzl4w4u92 Cursor "$HOME/.config/cursor/extensions.tsv"
install_from_tsv "$CURSOR" "$HOME/.config/cursor/extensions.tsv" cursor
