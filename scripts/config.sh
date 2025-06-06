#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$__dir/util.sh"

if [[ "$OSTYPE" == "darwin"* ]]
then
  # Originally based on https://github.com/jerodsanto/dotfiles/blob/master/osx
  # Some more docs at https://macos-defaults.com/

  headline_banner "Writing macOS defaults"

  # Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  # Enable subpixel font rendering on non-Apple LCDs
  defaults write NSGlobalDomain AppleFontSmoothing -int 2

  # Automatically hide and show the Dock
  defaults write com.apple.dock autohide -bool true

  # Make Dock icons of hidden applications translucent
  defaults write com.apple.dock showhidden -bool true

  # Show all filename extensions in Finder
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Show status bar in Finder
  defaults write com.apple.finder ShowStatusBar -bool true

  # Expand save panel by default
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

  # Disable the “Are you sure you want to open this application?” dialog
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  # Disable shadow in screenshots
  defaults write com.apple.screencapture disable-shadow -bool true

  # Display ASCII control characters using caret notation in standard text views
  # Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
  defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

  # Automatically open a new Finder window when a volume is mounted
  defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
  defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
  defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

  # Display full POSIX path as Finder window title
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  # Avoid creating .DS_Store files on network volumes
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  # Disable the warning when changing a file extension
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # Only use UTF-8 in Terminal.app
  defaults write com.apple.terminal StringEncodings -array 4

  # Show the ~/Library folder
  chflags nohidden ~/Library

  # Show dot files in finder
  defaults write com.apple.Finder AppleShowAllFiles -bool true

  # Speed up holding down keys
  defaults write -g InitialKeyRepeat -int 10
  defaults write -g KeyRepeat -int 1

  # Default screenshots storage
  mkdir -p ~/Screenshots
  defaults write com.apple.screencapture location ~/Screenshots

  for app in Safari Finder Dock Mail SystemUIServer
  do
    printf "💥 Reloading \033[0;34m%s\033[0m\n" "$app"
    killall "$app" >/dev/null 2>&1 || true
  done
  echo

  echo "⚠ Don't forget to import RectagleConfig.json into Rectangle.app"
  echo
fi
