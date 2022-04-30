#!/bin/sh

set -eu

if ! __exists port; then
    echo "Install MacPorts and run this script again"
    echo "See https://www.macports.org/"
    exit 1
fi

# Shell tools and must-haves for terminal environments

## Upgrade bash
sudo port install bash bash-completion
echo "/opt/local/bin/bash" | sudo tee -a /etc/shells >/dev/null
chsh -s "/opt/local/bin/bash"


## GNU replacements for built-in utils
sudo port install coreutils  # GNU coreutils
sudo port install gawk  # GNU awk
sudo port install gsed  # GNU sed
sudo port install grep  # GNU grep
sudo port install gnetcat  # GNU netcat
sudo port install gmake  # GNU make

## Essential shell tools
sudo port install moreutils  # A collection of the unix tools that nobody thought to write thirty years ago.
sudo port install lsd  # An ls clone with colors
sudo port install bat  # A cat clone with extra features
sudo port install fd  # A alternative to "find"
sudo port install ripgrep  # An alternative to "grep"
sudo port install fzf  # Command-line fuzzy finder written in Go
sudo port install tree  # Display directories as trees (with optional color/HTML output) 
sudo port install watch  # Executes a program periodically, showing output fullscreen
sudo port install parallel  # GNU parallel: Shell command parallelization utility
sudo port install htop  # Improved top
sudo port install pv  # Monitor the progress of data through a pipe
sudo port install p7zip  # 7-Zip implementation
sudo port install jq  # Lightweight and flexible command-line JSON processor
sudo port install fq # jq for binary formats
sudo port install jless # A command-line pager for JSON data
sudo port install progress  # Tool to show progress for cp, mv, dd, ...
sudo port install pipx  # Execute binaries from Python packages in isolated environments
sudo port install qrencode  # A fast and compact library for QR Code generation

## Development tools
sudo port install clang-11  # C, C++, Objective C and Objective C++ compiler
sudo port install cmake  # Cross-platform make
sudo port install shellcheck  # A static analysis tool for shell scripts
sudo port install git  # A fast version control system
sudo port install python39 && sudo port select --set python python39 && sudo port select --set python3 python39  # An interpreted, object-oriented programming language
pipx install virtualenv  # A more powerful version of the python venv module
sudo port install nodejs17 yarn  # Evented I/O for V8 JavaScript + JavaScript dependency manager
sudo port install android-platform-tools  # Platform-Tools for Google Android SDK (adb and fastboot)
sudo port install go  # compiled, garbage-collected, concurrent programming language developed by Google Inc
sudo port install cargo  # Cargo downloads your Rust project’s dependencies and compiles your project.

# Set up ccache (from https://trac.macports.org/wiki/howto/ccache)
sudo port install ccache  # object-file caching compiler wrapper
sudo sed -i -e 's/.*configureccache\s.*$/configureccache yes/' /opt/local/etc/macports/macports.conf # use it for MacPorts builds
( # Use ccache for compiling normal software by adding symlinks
  ccache_bin="$(which ccache)"
  dest_links="/opt/local/libexec/ccache"

  # set umask to avoid strict starting shell
  umask 022

  if [ ! -d "${dest_links}" ]; then
    sudo install -d "${dest_links}"
  fi

  find /usr/bin /opt/local/bin /usr/local/bin \( \
    -name "gcc*" -or -name "cc*" \
    -or -name "g++*" -or -name "c++*" \
    -or -name "clang++-mp*" -or -name "clang-mp*" -or -name "clang++" -or -name "clang" \) | \
    grep -E -v "cmake*|ccache*|ccomps*|c\+\+filt*" | \
  while read -r file; do
    sudo ln -s "${ccache_bin}" "${dest_links}/$(basename "$file")"
  done
)

## Network tools
sudo port install mtr  # 'traceroute' and 'ping' in a single tool
sudo port install nmap  # Port scanning utility for large networks
sudo port install rsync  # Fast incremental file transfer
sudo port install rclone  # Rclone is a command line cloud-service sync program
sudo port install socat  # netcat on steroids
sudo port install bandwhich  # Terminal bandwidth utilization tool
sudo port install iperf3  # Measures the maximum achievable bandwidth on IP network
sudo port install wget  # Internet file retriever
sudo port install curl  # Tool for transferring files with URL syntax
sudo port install wireshark3 && sudo dseditgroup -q -o edit -a "$(whoami)" -t user access_bpf  # Graphical network analyzer and capture tool + CLI utilities

sudo port install inetutils  # Inetutils is a collection of common network programs, including ftp, telnet, rsh, rlogin, tftp and the corresponding daemons.
for x in ftp telnet tftp ping ping6; do sudo ln -s /opt/local/bin/g$x /opt/local/libexec/gnubin/$x; done  # add non-prefixed versions to the gnubin

## Media manipulation
sudo port install exiftool  # General command line utility to read, write and edit EXIF metadata
sudo port install ffmpeg +nonfree  # FFmpeg is a complete solution to play, record, convert and stream audio and video.
sudo port install imagemagick  # Tools and libraries to manipulate images in many formats
sudo port install mkvtoolnix -qtgui  # Matroska media files manipulation tools.
sudo port install flac  # Free Lossless Audio Codec
sudo port install pngcrush  # optimizer for PNG files
sudo port install gifsicle  # GIF image/animation creator/editor
pipx install eyeD3  # MP3 ID3 tag viewing/editing

## Misc
sudo port install openssh  # OpenSSH secure login server
sudo port install youtube-dl  # Command-line program to download videos from YouTube.com and other sites
sudo port install aria2  # Download utility with resuming and segmented downloading
sudo port install megatools  # Command line client application for Mega.
sudo port install terminal-notifier  # A command line tool to send Mac OS X user notifications
sudo port install asciinema  # Record and share your terminal sessions, the right way
sudo port install fatsort  # Utility to sort FAT12, FAT16 and FAT32 partitions
sudo port install taglib  # TagLib Audio Meta-Data Library
pipx install crudini  # A utility for manipulating ini files
go get go.universe.tf/netboot/cmd/pixiecore  # Quickly set up a PXE server
