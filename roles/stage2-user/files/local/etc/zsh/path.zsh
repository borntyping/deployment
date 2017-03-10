#!/bin/zsh
#
# $PATH
#

function add_to_path() {
  if [[ -d $1 ]] && echo $PATH | grep -v $1 >/dev/null; then
    export PATH="$1:$PATH"
  fi
}

add_to_path "${HOME}/.chefdk/gem/ruby/2.1.0/bin"
add_to_path "${HOME}/.gem/ruby/2.3.0/bin"
add_to_path "${HOME}/.go/bin"
add_to_path "${HOME}/.multirust/toolchains/beta/cargo/bin"
add_to_path "${HOME}/.multirust/toolchains/nightly/cargo/bin"
add_to_path "${HOME}/.multirust/toolchains/stable/cargo/bin"
add_to_path "${HOME}/.npm/bin"

add_to_path "${HOME}/.local/bin"
add_to_path "${HOME}/.bin"
