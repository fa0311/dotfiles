#!/bin/bash
set -euo pipefail
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 30
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2
defaults write com.apple.HIToolbox AppleFnUsageType -int 2
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.dock tilesize -int 33
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.finder FXPreferredViewStyle -string "glyv"
defaults write com.apple.screencapture target -string "clipboard"
defaults write com.apple.screencapture show-thumbnail -bool false
defaults write com.apple.menuextra.clock ShowAMPM -bool true
defaults write com.apple.menuextra.clock ShowDate -int 0
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false
killall Dock Finder SystemUIServer ControlCenter
