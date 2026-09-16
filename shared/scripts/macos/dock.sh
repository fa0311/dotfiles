#!/bin/bash
set -euo pipefail
dockutil --remove all --no-restart
dockutil --add "/System/Applications/Apps.app" --no-restart
dockutil --add "/Applications/Google Chrome.app" --no-restart
dockutil --add "/Applications/Microsoft Edge.app" --no-restart
dockutil --add "/Applications/Visual Studio Code.app" --no-restart
dockutil --add "/Applications/Cursor.app" --no-restart
dockutil --add "/Applications/Microsoft Teams.app" --no-restart
dockutil --add "/Applications/Slack.app" --no-restart
dockutil --add "/System/Applications/System Settings.app" --no-restart
dockutil --add "/System/Applications/Utilities/Activity Monitor.app" --no-restart
dockutil --add "/System/Applications/Utilities/Terminal.app" --no-restart
dockutil --add "/Applications/WireGuard.app" --no-restart
dockutil --add "/System/Applications/QuickTime Player.app" --no-restart
dockutil --add "/Applications/OBS.app" --no-restart
dockutil --add "/Applications/Transporter.app" --no-restart
dockutil --add "$(ls -d /Applications/Xcode-*.app | sort -V | tail -1)" --no-restart
dockutil --add "/Applications/ChatGPT.app" --no-restart
dockutil --add "/Applications/Claude.app" --no-restart
killall Dock
