#!/bin/sh
# Initializes a login shell

# Figure out what OS we're running from and make it globally available as OSNAME
case "$(uname)" in
    'Linux')
        OSNAME='Linux'
        ;;
    'Darwin')
        OSNAME='macOS'
        ;;
    *)
        OSNAME='other'
        ;;
esac
export OSNAME

# Add common locations to the path
PATH=/usr/local/sbin:$PATH
PATH=~/.local/bin:$PATH    # pipx
PATH=~/.cargo/bin:$PATH    # Rust
PATH=~/bin:$PATH           # personal scripts
PATH=/usr/local/opt/ccache/libexec:$PATH # ccache
export PATH

# Use vim by default
export VISUAL=vim
export EDITOR=vim

# Pager
export PAGER=less

# Function to check if a command exists
__exists(){
    command -v "$1" >/dev/null 2>/dev/null
}
export -f __exists 2>/dev/null || : # Can error in POSIX sh - ignore it

if [ "$OSNAME" = "macOS" ] && __exists brew; then
    # Prefer brew-installed coreutils instead of the default BSD ones
    export PATH=$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH
    export MANPATH=$(brew --prefix)/opt/coreutils/libexec/gnuman:$MANPATH

    # Don't fall back to source builds if downloading a bottle fails
    # (could be a timeout or other temporary issue)
    export HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK=1
fi

# Define XDG directories in the futile hope that programs actually use them
if [ "$OSNAME" = "macOS" ]; then
    export XDG_CONFIG_HOME="$HOME/Library/Application Support/"
    export XDG_DATA_HOME="$HOME/Library/Application Support/"
    export XDG_CACHE_HOME="$HOME/Library/Caches/"
    export XDG_STATE_HOME="$HOME/Library/Application Support/"
    export XDG_CONFIG_DIRS="/Library/Application Support/"
    export XDG_DATA_DIRS="/Library/Application Support/"
elif [ "$OSNAME" = "Linux" ]; then
    export XDG_CONFIG_HOME="$HOME/.config/"
    export XDG_DATA_HOME="$HOME/.local/share/"
    export XDG_CACHE_HOME="$HOME/.cache/"
    export XDG_STATE_HOME="$HOME/.local/state/"
    export XDG_CONFIG_DIRS="/etc/xdg/"
    export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
fi
