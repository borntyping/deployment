#!/bin/zsh
#
# Completion rules
#

fpath=("$HOME/.local/share/zsh/functions" $fpath)

autoload -Uz compinit && compinit       # Loads completion modules
setopt AUTO_MENU                        # Show completion menu on tab press
setopt ALWAYS_TO_END                    # Move cursor after completion
setopt COMPLETE_ALIASES                 # Allow autocompletion for aliases
setopt COMPLETE_IN_WORD                 # Allow completion from middle of word
setopt LIST_PACKED                      # Smallest completion menu
setopt AUTO_PARAM_KEYS                  # Intelligent handling of characters
setopt AUTO_PARAM_SLASH                 #   after a completion
setopt AUTO_REMOVE_SLASH                # Remove trailing slash when needed

bindkey '^[[Z' reverse-menu-complete    # Shift-Tab to go back in menus

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.cache/zsh/completion/"
zstyle ':completion:*:*:*:users' ignored-patterns '*'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
