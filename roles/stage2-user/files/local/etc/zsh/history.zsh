#!/bin/zsh
#
# History settings
#

SAVEHIST=10000                          # Lines of history to save to a file
HISTSIZE=10000                          # Lines of history to keep in memory
HISTFILE=$HOME/.zhistory                # Save history in .cache

setopt APPEND_HISTORY                   # Append to $HISTFILE, not replace
setopt INC_APPEND_HISTORY               # Append to $HISTFILE while running
setopt SHARE_HISTORY                    # Share history between ZSH instances
setopt EXTENDED_HISTORY                 # Record additional information

setopt HIST_IGNORE_DUPS                 # Ignore adjacent reapeated entries
setopt HIST_EXPIRE_DUPS_FIRST           # Remove duplicate entries first
setopt HIST_FIND_NO_DUPS                # Never find duplicates when searching
