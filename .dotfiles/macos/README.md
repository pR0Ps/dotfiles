macOS setup
===========

1. Run `./apply_os_settings.sh` then log out and back in. This will clear all the default apps out of
   the dock and set some system preferences.
2. Run `./install_software.sh` to install some CLI tools
3. Manually install GUI applications (listed below)
4. Install Powerline-compatible fonts
   - `Inconsolata-g for Powerline.otf` for vim (from https://github.com/powerline/fonts/tree/master/Inconsolata-g)
   - `Monaco Nerd Font Complete.dfont` for the iTerm2 non-ASCII font (patched using https://github.com/ryanoasis/nerd-fonts#font-patcher)
5. Set up Samba shares (`sudo vim /etc/auto_smb`)
6. Turn off System Integrity Protection (SIP) (see below)


Applications
------------
| Name | Details |
|------|---------|
| [360Controller](https://github.com/360Controller/360Controller)| Xbox controller driver |
| [Alfred](https://www.alfredapp.com/) | Spotlight replacement |
| [AltTab](https://github.com/lwouis/alt-tab-macos) | Sane cmd+tab switcher |
| [Android Studio](https://developer.android.com/studio) | Android development IDE |
| [Cyberduck](https://cyberduck.io/) | File transfer client |
| [Day-O](https://shauninman.com/archive/2016/10/20/day_o_2_mac_menu_bar_clock) | Adds a clock + calendar to the menu bar |
| [Discord](https://discord.com/) | Chat |
| [Docker](https://www.docker.com/) | Run containers |
| [Enjoy2](https://github.com/fyhuang/enjoy2) | Controller -> keyboard mapper |
| [FinderPath](https://bahoom.com/finderpath/) | Put the current path in the Finder bar |
| [Firefox Developer Edition](https://www.mozilla.org/firefox/new/) | Browser |
| [gfxCardStatus](https://gfx.io/) | Integrated/dedicated GPU monitoring and control |
| [GIMP](https://www.gimp.org/) | Image editor |
| [Google Chrome](https://www.google.com/chrome/) | Browser |
| [Hammerspoon](https://www.hammerspoon.org/) | Automation framework |
| [Hex Fiend](https://hexfiend.com/ ) | Hex editor |
| [IINA](https://iina.io/) | Media player |
| [iTerm2](https://iterm2.com/) | Terminal emulator |
| [Karabiner-Elements](https://github.com/pqrs-org/Karabiner-Elements) | Key remapping |
| [MacVim](https://github.com/macvim-dev/macvim) | Text editor |
| [Microsoft Remote Desktop](https://apps.apple.com/app/microsoft-remote-desktop/id1295203466) | RDP client |
| [Moonlight](https://moonlight-stream.org/) | NVIDIA GameStream client |
| [Sloth](https://sveinbjorn.org/sloth) | List open files and sockets of programs |
| [Smooze](https://smooze.co/ ) | Sane mouse support (extra buttons, better scrolling, etc) |
| [Stats](https://github.com/exelban/stats) | Display system stats in the menu bar |
| [Syncthing](https://syncthing.net/) | Sync files |
| [Tor Browser](https://www.torproject.org/) | Onion browser |
| [Transmission](https://transmissionbt.com/) | Torrent client |
| [VirtualBox](https://www.virtualbox.org/) | Run VMs |
| [VLC](https://www.videolan.org/) | Media player |
| [WebTorrent](https://webtorrent.io/) | Torrent client (supports WebRTC) |
| [Wireguard](https://apps.apple.com/app/wireguard/id1441195209) | Secure tunnels |


Turning off System Integrity Protection (SIP)
---------------------------------------------
1. Boot into recovery mode by holding CMD+R while booting
2. Launch Utilities -> Terminal
3. Run `csrutil disable`
4. Run `reboot`
