#!/bin/bash
# Initializes an interactive bash-like shell

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Disable session save/restore feature for Apple terminal
if [ "$TERM_PROGRAM" == "Apple_Terminal" ]; then
    # Only checked in a sourced script so no need to export
    # shellcheck disable=2034
    SHELL_SESSION_DID_INIT=1
fi

# Source global bashrc
[ -r /etc/bashrc ] && . /etc/bashrc


# History settings
# Every terminal gets its own history file based on start time
export HISTDIR="$HOME/.bash_history.d"
export HISTFILE="$HISTDIR/$(date -u "+%Y/%m/%d/%H-%M-%S-%N").hist"
mkdir --parents "$(dirname "$HISTFILE")"

# Always append history after every command and on logout
PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
shopt -s histappend

# Pruning
export HISTIGNORE="cd:ls:vim:exit:history:[bf]g:%*:clear:reset:pwd:htop"
export HISTCONTROL=ignoredups:ignorespace  # no subsquent duplicates, ignore commands starting with " "

# Amount of history to store
export HISTSIZE=10000        # Load a large amount of history into memory for Ctrl+r searching
export HISTFILESIZE=99999999 # "Unlimited" number of lines in history files (https://lists.gnu.org/archive/html/bug-bash/2009-02/msg00108.html)

# Single line history wherever possible
# NOTE: newlines in literals will always be stored on multiple lines
shopt -s cmdhist  # Store multi-line commands as a single line
shopt -u lithist  # Prefer not using newlines to store history wherever possible

# Safer history expansion
set +H               # Disable by default
shopt -s histverify  # Give a chance to edit history expansions before running them

# Define a function that greps all past history
if __exists rg; then
    histgrep(){
        rg --no-heading --no-filename --no-line-number --sort path "$@" "$HISTDIR"
    }
else
    histgrep(){
        # Search, sort by filename+line number, cut filename+line number off
        grep --recursive --line-number --color=always "$@" "$HISTDIR" |\
            sort --field-separator ':' --key 1,1 --key 2n,2 |\
            cut --delimiter ':' --fields 3-
    }
fi

# Define a function to switch back into an existing session
# Useful in cases where a serminal is accidentally closed
histswitch(){
    if [ ! -r "$1" ]; then
        echo "Unable to find history session '$1'"
        return 1
    elif [ "$HISTFILE" -ef "$1" ]; then
        echo "Already using history session '$1'"
        return 2
    fi

    # Flush current history, switch HISTFILE, reload history from that session and previous
    history -a
    export HISTFILE="$1"
    history -c
    __load_bash_history "$1"
    echo "Switched to history session '$1'"
}
__histswitch_complete(){
    # NOTE: Will choke on spaces, doesn't expand shell variables properly
    # TODO: there has to be a better way
    local files=("$HISTDIR"/*/*/*/*.hist)
    COMPREPLY=( $(compgen -W "${files[*]}" -- "$2" ) )
}
complete -o default -F __histswitch_complete histswitch

# Load past history from across multiple files up to $HISTSIZE entries
__load_bash_history() {
    local first="${1:-}"  # optional param: history file to start at

    # Collect up all history files (will be sorted by date)
    local histfiles=("$HISTDIR"/*/*/*/*.hist)
    [ ${#histfiles[@]} -gt 0 ] || return

    # Find the index to start at in order to load $HISTSIZE lines
    local lines=0
    local start=${#histfiles[@]}-1
    local num=0
    for (( ; start >= 0 ; start-- )) ; do
        # Skip files until $first if it was provided
        if [ "$num" -eq 0 ] && [ -n "$first" ] && [ ! "$first" -ef "${histfiles[start]}" ]; then
            continue
        fi
        # Try to get the required number of lines from the file
        # Add the actual amount available to the total
        ((lines += $(head --lines $((HISTSIZE - lines)) "${histfiles[start]}" | wc -l)))
        ((num+=1))
        [ "$lines" -ge "$HISTSIZE" ] && break
    done
    # When there isn't enough history available start will be -1 which will mess up array slicing
    [ "$start" -lt 0 ] && start=0

    # Merge the selected history files and load the last $HISTSIZE lines from it
    local tmp="$(mktemp)"
    tail --silent --lines $HISTSIZE "${histfiles[@]:$start:$num}" | tail --lines $HISTSIZE > "$tmp"
    history -r "$tmp"
    rm "$tmp"
};
__load_bash_history



# Add completion for tools installed via brew
if [ "$OSNAME" = "macOS" ] && __exists brew; then
    [ -r "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion"
fi

# pipx completions
if __exists register-python-argcomplete && __exists pipx; then
    eval "$(register-python-argcomplete pipx)"
fi

# Set up fzf
# NOTE: Needs to be done *after* brew autocomplete or it will be overridden
[ -r ~/.fzf.bash ] && source ~/.fzf.bash

if __exists fzf; then
    # Use up to 50% of the terminal height
    export FZF_TMUX_HEIGHT="50%"

    # Enable processing of ansi color codes
    export FZF_DEFAULT_OPTS="--ansi"

    # When viewing history provide a preview window (toggled by ?) to see long commands
    export FZF_CTRL_R_OPTS="--preview 'echo {2..}' --preview-window wrap:down:hidden --bind ?:toggle-preview"

    # Provide a preview window that shows the first 100 lines when using Ctrl+t
    if __exists bat; then
        export FZF_CTRL_T_OPTS="--preview='bat --pager=never --style=header --color=always --line-range :100 {}'"
    else
        export FZF_CTRL_T_OPTS="--preview='head -n 100 {}'"
    fi

    # Prefer fd for generating fzf paths (faster, respects .gitignore)
    if __exists fd; then
        # Note that the "." is not a path, it's the search pattern (match anything)
        # No colors for directories as they're all the same color
        export FZF_DEFAULT_COMMAND="fd --type file --hidden --follow --color=always ."
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type directory --hidden --follow ."
        _fzf_compgen_path() {
            fd --hidden --follow --color=always . "$1" 2>/dev/null
        }
        _fzf_compgen_dir() {
            fd --type directory --hidden --follow . "$1" 2>/dev/null
        }
    fi
fi


# When a program's output has no trailing newline show a red arrow and insert the newline
PROMPT_COMMAND="printf '\033[31m⏎\033[0m%$((COLUMNS-1))s\r\033[K'${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
PS1='\u@\h \w\$ '

# Change prompt to something generic when recording asciicasts
if ps -o command= $PPID | grep -q "asciinema rec"; then
    PS1='ghost@ghost \w\$ '
fi

# Source aliases
[ -r ~/.aliases ] && . ~/.aliases
