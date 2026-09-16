#!/bin/bash
set -euo pipefail
defaults write com.apple.dock tilesize -int 33
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 30
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "glyv"
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
killall Dock Finder
