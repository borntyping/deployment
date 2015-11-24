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

# Named directories
setopt AUTO_NAME_DIRS
export borntyping="$HOME/Development/borntyping"
export datasift="$HOME/Development/datasift"
export sandbox="$HOME/Development/borntyping-sandbox"
export src="$HOME/Development/src"

#
# $PATH
#

# Add directories to $PATH if they exist
function add_to_path() { [[ -d $1 ]] && export PATH="$1:$PATH"; }

add_to_path "$HOME/Development/datasift/chef/bin"
add_to_path "$HOME/.gem/ruby/2.0.0/bin"
add_to_path "$HOME/.multirust/toolchains/nightly/cargo/bin"
add_to_path "$HOME/.multirust/toolchains/beta/cargo/bin"
add_to_path "$HOME/.multirust/toolchains/stable/cargo/bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.bin"
