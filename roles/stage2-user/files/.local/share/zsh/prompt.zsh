#!/usr/bin/env zsh

# shellcheck disable=SC2034
# shellcheck disable=SC2154

autoload -U vcs_info         # Version control information
autoload -U colors && colors # Adds variables for printing colors
setopt PROMPT_SUBST          # Allow substitution in PROMPT

prompt_fg="${fg[magenta]}"
prompt_highlight_fg="${fg[blue]}"

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' stagedstr "%{${fg[green]}%}+%{${reset_color}%}"
zstyle ':vcs_info:*' unstagedstr "%{${fg[yellow]}%}+%{${reset_color}%}"
zstyle ':vcs_info:*' formats "%{${prompt_fg}%}%b%{${reset_color}%}%c%u%m "
zstyle ':vcs_info:*' actionformats "%{${prompt_fg}%}%b%{${reset_color}%}%c%u%m|%a "
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
function prompt_python_info() {
  prompt_python=""
  if [[ -n "$PIPENV_ACTIVE" ]]; then
    prompt_python="%{${prompt_fg}%}pipenv%{${reset_color}%} "
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    if [[ "$VIRTUAL_ENV" =~ "/venv$" ]]; then
      virtualenv_name="$(basename "$(dirname "$VIRTUAL_ENV")")"
    else
      virtualenv_name="$(basename "$VIRTUAL_ENV")"
    fi
    prompt_python="%{${prompt_fg}%}virtualenv:${virtualenv_name}%{${reset_color}%} "
  fi
}

# Display the current kubectl context
function prompt_kubectl_info() {
  prompt_kubectl=""

  if ! command -v kubectl > /dev/null 2>&1; then
    return
  fi

  if ! command -v kubens > /dev/null 2>&1; then
    return
  fi

  local CONTEXT CONTEXT_COLOUR NAMESPACE NAMESPACE_COLOUR
  CONTEXT="$(kubectl config current-context 2>/dev/null)"
  CONTEXT_COLOUR="$prompt_fg"
  NAMESPACE="$(kubens --current)"
  NAMESPACE_COLOUR="$prompt_fg"

  if [[ -n "$CONTEXT" ]]; then
    # Set foreground based on the environment.
    [[ "$CONTEXT" == *"engineering"* ]] && CONTEXT_COLOUR="${fg[cyan]}"
    [[ "$CONTEXT" == *"sandbox"* ]] && CONTEXT_COLOUR="${fg[yellow]}"
    [[ "$CONTEXT" == *"production"* ]] && CONTEXT_COLOUR="${fg[red]}"
    prompt_kubectl="%{$CONTEXT_COLOUR%}${CONTEXT}%{$reset_color%} "
  fi

  if [[ -n "$NAMESPACE" ]]; then
    # Set foreground based on the environment.
    [[ "$NAMESPACE" == "integration" ]] && NAMESPACE_COLOUR="${fg[green]}"
    [[ "$NAMESPACE" == "staging" ]] && NAMESPACE_COLOUR="${fg[yellow]}"
    [[ "$NAMESPACE" == "production" ]] && NAMESPACE_COLOUR="${fg[red]}"
    prompt_kubectl="$prompt_kubectl%{$NAMESPACE_COLOUR%}${NAMESPACE}%{$reset_color%} "
  fi
}

function prompt_precmd_title() {
  case "$TERM" in
  xterm*) print -Pn "\e]2;%~\a" ;;
  esac
}

function prompt_preexec_title() {
  case "$TERM" in
  xterm*) print -Pn "\e]2;%~ $ $2\a" ;;
  esac
}

export precmd_functions=($precmd_functions prompt_precmd_title vcs_info prompt_kubectl_info prompt_python_info)
export preexec_functions=($preexec_functions prompt_preexec_title)

# Assemble the prompt
#
#   $ sam@hostname ~
#   $ ...
#   $ sam@hostname ~/directory master production
#   $ ...
#
# The %{ and %} characters are used to stop the prompt from counting invisible
# characters when calculating the length
PROMPT="%{$prompt_fg%}$ %n@%m %{$prompt_highlight_fg%}%~%{$reset_color%} \${vcs_info_msg_0_}\${prompt_python}\${prompt_telepresence}\${prompt_kubectl}
%{$prompt_fg%}$%{$reset_color%} "
