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

# Helper function for adding dirs to environment variables
__add_env_dir(){
    if [ -d "$2" ]; then
        eval "export $1=\"$2\":\$$1"
    fi
}

# Add common locations to the path
__add_env_dir PATH /usr/local/sbin
__add_env_dir PATH ~/.local/bin    # pipx
__add_env_dir PATH ~/.cargo/bin    # Rust
__add_env_dir PATH ~/bin           # personal scripts
__add_env_dir PATH /opt/local/libexec/ccache # ccache
if [ "$OSNAME" = "macOS" ]; then
    # Add MacPorts-installed software to the path
    __add_env_dir PATH /opt/local/bin
    __add_env_dir PATH /opt/local/sbin
    __add_env_dir PATH /opt/local/libexec/gnubin # Use GNU coreutils by default

    # Override system vim with MacVim's version if it's installed
    __add_env_dir PATH /Applications/MacVim.app/Contents/bin
fi

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

# Define XDG directories in the futile hope that programs actually use them
if [ "$OSNAME" = "macOS" ]; then
    export XDG_DATA_HOME="$HOME/Library/Application Support/"
    export XDG_CACHE_HOME="$HOME/Library/Caches/"
    export XDG_STATE_HOME="$HOME/Library/Application Support/"
    export XDG_CONFIG_DIRS="/Library/Application Support/"
    export XDG_DATA_DIRS="/Library/Application Support/"
elif [ "$OSNAME" = "Linux" ]; then
    export XDG_DATA_HOME="$HOME/.local/share/"
    export XDG_CACHE_HOME="$HOME/.cache/"
    export XDG_STATE_HOME="$HOME/.local/state/"
    export XDG_CONFIG_DIRS="/etc/xdg/"
    export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
fi
# Use the same local config directory on every OS
export XDG_CONFIG_HOME="$HOME/.config/"
