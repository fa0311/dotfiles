#!/bin/bash
set -euo pipefail
add_app() {
  if [ -d "$1" ]; then
    dockutil --add "$1" --no-restart
  else
    printf 'Skipping unavailable Dock app: %s\n' "$1" >&2
  fi
}

dockutil --remove all --no-restart
add_app "/System/Applications/Apps.app"
add_app "/Applications/Google Chrome.app"
add_app "/Applications/Microsoft Edge.app"
add_app "/Applications/Visual Studio Code.app"
add_app "/Applications/Cursor.app"
add_app "/Applications/Microsoft Teams.app"
add_app "/Applications/Slack.app"
add_app "/System/Applications/System Settings.app"
add_app "/System/Applications/Utilities/Activity Monitor.app"
add_app "/System/Applications/Utilities/Terminal.app"
add_app "/Applications/WireGuard.app"
add_app "/Applications/OBS.app"
add_app "/Applications/Transporter.app"
shopt -s nullglob
xcodes=(/Applications/Xcode-*.app)
if [ "${#xcodes[@]}" -gt 0 ]; then
  add_app "$(printf '%s\n' "${xcodes[@]}" | sort -V | tail -1)"
elif [ -d /Applications/Xcode.app ]; then
  add_app /Applications/Xcode.app
else
  printf 'Skipping unavailable Dock app: Xcode\n' >&2
fi
add_app "/Applications/ChatGPT.app"
add_app "/Applications/Claude.app"
killall Dock
