#!/usr/bin/env zsh

autoload -U vcs_info                    # Version control information
autoload -U colors && colors            # Adds variables for printing colors
setopt PROMPT_SUBST                     # Allow substitution in PROMPT

prompt_fg="$fg[magenta]"
prompt_highlight_fg="$fg[blue]"

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' stagedstr "%{$fg[green]%}+%{$reset_color%}"
zstyle ':vcs_info:*' unstagedstr "%{$fg[yellow]%}+%{$reset_color%}"
zstyle ':vcs_info:*' formats "%{$prompt_fg%}%b%{$reset_color%}%c%u%m "
zstyle ':vcs_info:*' actionformats "%{$prompt_fg%}%b%{$reset_color%}%c%u%m|%a "
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-remote

function +vi-git-clean(){
    if [[ $(git status --porcelain | wc -c) -eq 0 ]]; then
        backend_misc[clean]+="%{$fg[red]%}CLEAN%{$reset_color%}"
    else
        backend_misc[clean]+="%{$fg[red]%}NOT CLEAN%{$reset_color%}"
    fi
}

# Add a marker to %u for untracked files
function +vi-git-untracked(){
    if git status --porcelain | fgrep '??' &> /dev/null; then
        hook_com[unstaged]+="%{$fg[red]%}+%{$reset_color%}"
    fi
}

# Show +N/-N when a local branch is ahead-of or behind remote HEAD.
function +vi-git-remote() {
    local ahead behind

    ahead=$(git rev-list "${hook_com[branch]}@{upstream}..HEAD" 2>/dev/null | wc -l)
    (( ahead )) && hook_com[misc]+=" %{$fg[green]%}↑${ahead}%{$reset_color%}"

    behind=$(git rev-list "HEAD..${hook_com[branch]}@{upstream}" 2>/dev/null | wc -l)
    (( behind )) && hook_com[misc]+=" %{$fg[red]%}↓${behind}%{$reset_color%}"
}

# Display the current virtualenv when active
function zsh_python_info() {
    zsh_python_info_msg=""
    if [[ -n "$PIPENV_ACTIVE" ]]; then
        zsh_python_info_msg="%{$prompt_fg%}pipenv%{$reset_color%} "
    elif [[ -n "$VIRTUAL_ENV" ]]; then
        zsh_python_info_msg="%{$prompt_fg%}virtualenv:$(basename "$VIRTUAL_ENV")%{$reset_color%} "
    fi
}

# Display the current kubectl context
function zsh_telepresence_info() {
    zsh_telepresence_info_msg=""
    if [[ -n "$TELEPRESENCE_POD" ]]; then
        zsh_python_info_msg="%{$prompt_fg%}telepresence%{$reset_color%} "
    fi
}

# Display the current kubectl context
function zsh_kubectl_info() {
    zsh_kubectl_info_msg=""

    local CONTEXT COLOUR
    COLOUR="$prompt_fg"
    CONTEXT="$(kubectl config current-context 2>/dev/null)"

    if [[ -n "$CONTEXT" ]]; then
        # Set foreground based on the environment.
        [[ "$CONTEXT" == *"production"*  ]] && COLOUR="$fg[red]"
        [[ "$CONTEXT" == *"staging"*     ]] && COLOUR="$fg[yellow]"
        [[ "$CONTEXT" == *"integration"* ]] && COLOUR="$fg[yellow]"
        [[ "$CONTEXT" == *"infra"*       ]] && COLOUR="$fg[red]"
        zsh_kubectl_info_msg="%{$COLOUR%}${CONTEXT}%{$reset_color%} "
    fi
}

function zsh_precmd_title() {
    case "$TERM" in
        xterm*) print -Pn "\e]2;%~\a";;
    esac
}

function zsh_preexec_title() {
    case "$TERM" in
        xterm*) print -Pn "\e]2;%~ $ $2\a";;
    esac
}

export precmd_functions=(zsh_precmd_title vcs_info zsh_kubectl_info zsh_python_info zsh_telepresence_info _direnv_hook)
export preexec_functions=(zsh_preexec_title)


# Assemble the prompt
#
#   $ sam@hostname ~
#   $ ...
#   $ sam@hostname ~/directory master production
#   $ ...
#
# The %{ and %} characters are used to stop the prompt from counting invisible
# characters when calculating the length
PROMPT="%{$prompt_fg%}$ %n@%m %{$prompt_highlight_fg%}%~%{$reset_color%} \
\${vcs_info_msg_0_}\
\${zsh_python_info_msg}\
\${zsh_telepresence_info_msg}\
\${zsh_kubectl_info_msg}\

%{$prompt_fg%}$%{$reset_color%} "
