#!/bin/bash

# Set some configuration options for macOS

# Close any open System Preferences panes to prevent them from overriding the settings
osascript -e 'tell application "System Preferences" to quit'


## Power

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Wake when lid is opened
sudo pmset -a lidwake 1

# Sleep the display after 10m and disable the screen saver
sudo pmset -b displaysleep 10
sudo pmset -c displaysleep 10
defaults -currentHost write com.apple.screensaver idleTime 0

# dim the screen before sleeping it
sudo pmset -a halfdim 1

# Sleep after 10m on battery (don't auto-sleep while charging)
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


## General

# Disable Gatekeeper (allow unsigned applications to run without manual approval)
sudo spctl --master-disable
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable the certificate revocation check when launching an application
if ! grep -q "127\.0\.0\.1 ocsp.apple.com" /etc/hosts; then
    echo -e '# Block certificate revocation checking\n127.0.0.1 ocsp.apple.com' | sudo tee -a /etc/hosts >/dev/null
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
fi

# Set up Samba auto-mount system
if [ ! -f /etc/auto_smb ]; then
  echo "
# Custom SMB mounts
/mnt auto_smb

# run 'sudo automount -vc' to apply changes" | sudo tee -a /etc/auto_master >/dev/null
  echo \
"# Add Samba mounts using the following format
# Make sure to urlencode the values (ie. '@' --> '%40')
#
# <name> -fstype=smbfs ://<user>@<server>/<share>
" | sudo tee /etc/auto_smb >/dev/null

  # Only allow root to view/edit the files (contains passwords)
  sudo chmod a-rwx,u+rw /etc/auto_smb
fi

# Disable resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false


## Interface

# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Zoom on double clicking a window's title bar
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Maximize"  # sic

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Don't group windows by application in Mission Control/Expose
defaults write com.apple.dock expose-group-apps -bool false

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

# Disable “natural” (aka backwards) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Tracking speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1.5

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

# Disable spring-loading directories (use force click to enter them)
defaults write NSGlobalDomain com.apple.springing.enabled -bool false

# Right click with 2 fingers
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -bool false

# Enable pinch to zoom
defaults -currentHost write NSGlobalDomain com.apple.trackpad.pinchGesture -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -bool true

# Disable smart zoom
defaults -currentHost write NSGlobalDomain com.apple.trackpad.twoFingerDoubleTapGesture -bool false

# Disable rotation
defaults -currentHost write NSGlobalDomain com.apple.trackpad.rotateGesture -bool false

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

# Show drives on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show hidden files
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

# Disable icon hover zooming
defaults write com.apple.dock magnification -bool false
