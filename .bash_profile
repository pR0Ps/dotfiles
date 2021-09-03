#!/bin/bash
# Initializes a bash-like shell

[ -r ~/.profile ] && . ~/.profile
[ -r ~/.bashrc ] && . ~/.bashrc

# Ignore some suffixes when autocompleting paths
export FIGNORE="__pycache__:.egg-info:.DS_Store:.~"
