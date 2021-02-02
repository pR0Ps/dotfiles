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


# Source history script and start a new session
if [ -r ~/.histrc ]; then
    . ~/.histrc
    hist-new
    hist-load
fi


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
