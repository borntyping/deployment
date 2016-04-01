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

setopt AUTO_NAME_DIRS
export borntyping="$HOME/Development/borntyping"
export datasift="$HOME/Development/datasift"
export sandbox="$HOME/Development/borntyping-sandbox"
export src="$HOME/Development/src"

export PROV_PATH="$HOME/.provision/state"
# export PROV_PATH="$HOME/.sift/provision/state"
