#!/usr/bin/env zsh

# shellcheck disable=SC2034
# shellcheck disable=SC2154

autoload -U vcs_info         # Version control information
autoload -U colors && colors # Adds variables for printing colors
setopt PROMPT_SUBST          # Allow substitution in PROMPT

_src_prompt_fg="${fg[magenta]}"
_src_prompt_fg_highlight="${fg[blue]}"
_src_prompt_fg_danger="${fg[red]}"

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' stagedstr "%{${fg[green]}%}+%{${reset_color}%}"
zstyle ':vcs_info:*' unstagedstr "%{${fg[yellow]}%}+%{${reset_color}%}"
zstyle ':vcs_info:*' formats "%{${_src_prompt_fg}%}%b%{${reset_color}%}%c%u%m "
zstyle ':vcs_info:*' actionformats "%{${_src_prompt_fg}%}%b%{${reset_color}%}%c%u%m|%a "
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-remote

function +vi-git-clean() {
  if [[ $(git status --porcelain | wc -c) -eq 0 ]]; then
    backend_misc[clean]+="%{${fg[red]}%}CLEAN%{${reset_color}%}"
  else
    backend_misc[clean]+="%{${fg[red]}%}NOT CLEAN%{${reset_color}%}"
  fi
}

# Add a marker to %u for untracked files
function +vi-git-untracked() {
  if git status --porcelain | fgrep '??' &>/dev/null; then
    hook_com[unstaged]+="%{${fg[red]}%}+%{${reset_color}%}"
  fi
}

# Show +N/-N when a local branch is ahead-of or behind remote HEAD.
function +vi-git-remote() {
  local ahead behind

  ahead=$(git rev-list "${hook_com[branch]}@{upstream}..HEAD" 2>/dev/null | wc -l)
  ((ahead)) && hook_com[misc]+=" %{${fg[green]}%}↑${ahead}%{${reset_color}%}"

  behind=$(git rev-list "HEAD..${hook_com[branch]}@{upstream}" 2>/dev/null | wc -l)
  ((behind)) && hook_com[misc]+=" %{${fg[red]}%}↓${behind}%{${reset_color}%}"
}

# Display the current virtualenv when active
function _src_precmd_venv() {
  local virtualenv
  _src_prompt_venv=""
  if [[ -v 'VIRTUAL_ENV' ]]; then
    if [[ "${VIRTUAL_ENV}" =~ /venv$ || "${VIRTUAL_ENV}" =~ /.venv$ ]]; then
      virtualenv="$(basename "$(dirname "${VIRTUAL_ENV}")")"
    else
      virtualenv="$(basename "${VIRTUAL_ENV}")"
    fi
    _src_prompt_venv="%{${_src_prompt_fg_highlight}%}venv:${virtualenv}%{${reset_color}%} "
  fi
}

# Display the current kubectl context
# Run 'kubectx -u' to unset the current context
function _src_precmd_kubectl() {
  _src_prompt_kubectl=""
  if [[ -f "${KUBECONFIG:-$HOME/.kube/config}" ]] && [[ -v 'commands[kubectl]' ]] && [[ -v 'commands[kubens]' ]]; then
    _src_prompt_kubectl="%{${_src_prompt_fg_highlight}%}kube:$(kubectl config current-context 2>/dev/null):$(kubens --current)${namespace}%{${reset_color}%} "
  fi
}

# Display the current AWS profile when active
function _src_precmd_aws() {
  _src_prompt_aws=""
  if [[ -v 'AWS_PROFILE' ]]; then
    _src_prompt_aws="%{${_src_prompt_fg_danger}%}aws:${AWS_PROFILE}%{${reset_color}%} "
  elif [[ -v 'AWS_ACCESS_KEY_ID' ]]; then
    _src_prompt_aws="%{${_src_prompt_fg_danger}%}aws:${AWS_ACCESS_KEY_ID}%{${reset_color}%} "
  fi
}

# Zoxide sets `$_zoxide_result`, which interferes with `AUTO_NAME_DIRS`. Only
# needs to run in `precmd_functions` before which is executed before the
# prompt is shown, but should be before any functions that display the current
# working directory.
function _src_precmd_zoxide() {
  unset _zoxide_result
}

# Sets the window title to the current working directory.
function _src_precmd_title() {
  case "$TERM" in
  xterm*) print -Pn "\e]2;%~\a" ;;
  esac
}

# Sets the window title to the current working directory and executing command.
function _src_preexec_title() {
  case "$TERM" in
  xterm*) print -Pn "\e]2;%~ $ $2\a" ;;
  esac
}

export precmd_functions=($precmd_functions _src_precmd_zoxide _src_precmd_title vcs_info _src_precmd_venv _src_precmd_kubectl _src_precmd_aws)
export preexec_functions=($preexec_functions _src_preexec_title)

# Assemble the prompt
#
#   $ ~ll /
#   $ ...
#   $ ~/directory main
#   $ ...
#   $ ~/directory main venv:example kube:example aws:example
#   $ ...
#
# The %{ and %} characters are used to stop the prompt from counting invisible
# characters when calculating the length
PROMPT="%{$_src_prompt_fg%}$ %{$_src_prompt_fg_highlight%}%~%{$reset_color%} \${vcs_info_msg_0_}\${_src_prompt_venv}\${_src_prompt_kubectl}\${_src_prompt_aws}
%{$_src_prompt_fg%}$%{$reset_color%} "
