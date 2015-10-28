#!/bin/zsh
#
# Environment variables
#

export EDITOR=nano
export LS_COLORS='rs=0:di=01;34:ln=target:or=41:ex=32'
export SSH_RUN_SUDO_KEYRING=1

# Named directories
export borntyping="$HOME/Development/borntyping"
export datasift="$HOME/Development/datasift"
export sandbox="$HOME/Development/borntyping-sandbox"
export src="$HOME/Development/src"

# Add directories to $PATH if they exist
function add_to_path() { [[ -d $1 ]] && export PATH="$1:$PATH"; }

# add_to_path "${datasift}/chef/bin"      # Chef scripts
add_to_path "$HOME/.gem/ruby/2.0.0/bin" # Executables installed by 'gem'
add_to_path "$HOME/.gem/ruby/2.1.0/bin" # Executables installed by 'gem'
add_to_path "$HOME/.local/bin"          # User installed executables
add_to_path "$HOME/.bin"                # Personal scripts
