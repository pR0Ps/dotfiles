#!/bin/bash

# Set some configuration options for macOS

# Close any open System Preferences panes to prevent them from overriding the settings
osascript -e 'tell application "System Preferences" to quit'

## Power

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Wake when lid is opened
sudo pmset -a lidwake 1

# Sleep the display after 10m on battery
sudo pmset -b displaysleep 10
sudo pmset -c displaysleep 0

# dim the screen before sleeping it
sudo pmset -a halfdim 1

# Sleep after 10m on battery
sudo pmset -b sleep 10
sudo pmset -c sleep 0

# Powernap only when charging
sudo pmset -b powernap 0
sudo pmset -c powernap 1

# Wake on magic packet
sudo pmset -c womp 1

# Put disks to sleep when possible on battery
sudo pmset -b disksleep 10

# Don't wake when power source is changed
sudo pmset -a acwake 0

## Interface

# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Maximize on double clicking window
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Maximize"

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false


## Keyboard

# Use function keys as function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -int 1

# Disable auto-correct and other annoying features
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false

# Disable press-and-hold for keys (repeat instead)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Configure keyboard repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25

## Trackpad

# Tracking speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1

# Force click (enable, firm click, make click sound)
defaults write com.apple.AppleMultitouchTrackpad ActuateDedents -int 1
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -int 0
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 2
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 2
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 1

# Disable the force click data detectors and lookup
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false

# Disable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false

# Right click with 2 fingers
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -bool false

# Disable “natural” (aka backwards) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable pinch to zoom
defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -bool true

# Disable smart zoom
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -bool false

# Disable rotation
defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool false

# Disable swiping between pages
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool false

# Swipe between full-screen apps and spaces with 3 or 4 finger swipe
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2

# Three finger swipe up for Mission Control
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.dock showMissionControlGestureEnabled -bool true

# Disable Launchpad and Show desktop gestures
defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 0
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false
defaults write com.apple.dock showDesktopGestureEnabled -bool false

# Finder

# Configure the icons to display on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show filename extensions and disable warnings for changing them
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false


## Dock

# Wipe all apps from the dock
defaults write com.apple.dock persistent-apps -array

# Minimize windows into the bar (not the icon)
defaults write com.apple.dock minimize-to-application -bool false

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Automatically hide and show the Dock (quickly)
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide -bool true

## Spaces and dashboard
# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Don't save and restore bash sessions
defaults write com.apple.Terminal NSQuitAlwaysKeepsWindows -bool false
