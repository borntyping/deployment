#!/bin/zsh
#
# Options
#

setopt INTERACTIVE_COMMENTS             # Allow comments in interactive mode
setopt RM_STAR_WAIT                     # Force the user to wait before `rm *`

#
# Environment variables
#

export EDITOR=nano
export LS_COLORS='rs=0:di=01;34:ln=target:or=41:ex=32'
export SSH_RUN_SUDO_KEYRING=1

#
# Language specific configuration
#

export GOPATH="${HOME}/.go"
export NPM_CONFIG_PREFIX="$HOME/.npm"

#
# Named directories
#

setopt AUTO_NAME_DIRS
export borntyping="$HOME/Development/borntyping"
export generalbioinformatics="$HOME/Development/generalbioinformatics"
export gb="${generalbioinformatics}"
export sandbox="$HOME/Development/borntyping-sandbox"
export src="$HOME/Development/src"

