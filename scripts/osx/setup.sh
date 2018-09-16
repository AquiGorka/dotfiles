#!/bin/bash
# setup script for osx
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/AquiGorka/dotfiles/master/scripts/osx/setup.sh) new-hostname"

# Ask for the administrator password upfront
sudo -v

# change hostname
scutil --set ComputerName $@
scutil --set LocalHostName $@
scutil --set HostName $@
dscacheutil -flushcache

# add spanish iso to keyboard (manually)
# git clone https://github.com/myshov/xkbswitch-macosx
# ./xkbswitch-macosx/bin/xkbswitch -se Spanish-ISO

# move focus to next window (manually)
# https://apple.stackexchange.com/questions/280220/how-to-change-the-default-shortcut-for-move-focus-to-next-window-to-something

# expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# set default location for new Finder windows
# for other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# use list view in all Finder windows by default
# four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# hot corners
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner → Dashboard
defaults write com.apple.dock wvous-tl-corner -int 7
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Mission Control
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0

# Mac App Store
  # enable the automatic update check
  defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
  # download newly available updates in background
  defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
  # turn on app auto-update
  defaults write com.apple.commerce AutoUpdate -bool true

# kill affected applications
for app in "Activity Monitor" \
  "cfprefsd" \
  "Dock" \
  "Finder" \
  "Google Chrome" \
  "Messages" \
  "SystemUIServer" \
  "Terminal"; do
  killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect"
