#!/bin/zsh
#
# Prompt
#

autoload -U vcs_info                    # Version control information
autoload -U colors && colors            # Adds variables for printing colors
setopt PROMPT_SUBST                     # Allow substitution in PROMPT

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' stagedstr "%{$fg[green]%}!%{$reset_color%}"
zstyle ':vcs_info:*' unstagedstr "%{$fg[yellow]%}!%{$reset_color%}"
zstyle ':vcs_info:*' formats "%{$fg_bold[green]%}%s:%b%{$reset_color%}%c%u%m "
zstyle ':vcs_info:*' actionformats "%{$fg_bold[green]%}%s:%b%{$reset_color%}(%a)%c%u%m "
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-remote

# Add a marker to %u for untracked files
function +vi-git-untracked(){
    if git status --porcelain | fgrep '??' &> /dev/null; then
        hook_com[unstaged]+="%{$fg[red]%}!%{$reset_color%}"
    fi
}

# Show +N/-N when a local branch is ahead-of or behind remote HEAD.
function +vi-git-remote() {
    local ahead behind

    ahead=$(git rev-list "${hook_com[branch]}@{upstream}..HEAD" 2>/dev/null | wc -l)
    (( ahead )) && hook_com[misc]+=" %{$fg_bold[green]%}+${ahead}%{$reset_color%}"

    behind=$(git rev-list "HEAD..${hook_com[branch]}@{upstream}" 2>/dev/null | wc -l)
    (( behind )) && hook_com[misc]+=" %{$fg[red]%}-${behind}%{$reset_color%}"
}

# Display the current virtualenv when active
function _info_virtualenv() {
    virtualenv_info_msg_=""
    if [ -n "$VIRTUAL_ENV" ]; then
        virtualenv_info_msg_="%{$fg_bold[green]%}virtualenv:$(basename "$VIRTUAL_ENV")%{$reset_color%} "
    fi
}

# Display the currently selected knife-block configuration file
function _info_knife() {
    knife_info_msg_=""

    local ENVIRONMENT_FILE ENVIRONMENT COLOUR

    [[ ! -L "$HOME/.chef/knife.rb" ]] && return

    ENVIRONMENT_FILE=$(realpath "$HOME/.chef/knife.rb")
    ENVIRONMENT=$(basename $ENVIRONMENT_FILE | sed "s/knife-\(.*\).rb/\1/")
    COLOUR="$fg_bold[green]"

    # When the environment is `none`, skip showing knife information
    [[ "$ENVIRONMENT" == "none" ]] && return

    # Set colors based on the environment
    [[ "$ENVIRONMENT" == "production"  ]] && COLOUR="$fg[red]"
    [[ "$ENVIRONMENT" == "staging"     ]] && COLOUR="$fg[yellow]"
    [[ "$ENVIRONMENT" == "development" ]] && COLOUR="$fg[green]"
    [[ "$ENVIRONMENT" == "berksapi"    ]] && COLOUR="$fg[blue]"

    ENVIRONMENT="%{$COLOUR%}${ENVIRONMENT}%{$reset_color%}"
    knife_info_msg_="%{$fg_bold[green]%}knife:%{$reset_color%}${ENVIRONMENT} "
}

# Set terminal title and collect information before showing the prompt
function precmd() {
    case $TERM in
        xterm*) print -Pn "\e]2;%~\a";;
    esac
    vcs_info
    _info_virtualenv
    _info_knife
}

# Set terminal title before executing a command
function preexec() {
    case $TERM in
        xterm*) print -Pn "\e]2;%~ $ $2\a";;
    esac
}

# Assemble the prompt
#   sam@hostname ~ $
#   sam@hostname ~/directory git:master env:virtualenv knife:production $
#
# The %{ and %} characters are used to stop the prompt from counting invisible
# characters when calculating the length
PROMPT="%{$fg_bold[green]%}$ %n@%m %~%{$reset_color%} \
\${vcs_info_msg_0_}\${virtualenv_info_msg_}\${knife_info_msg_}
%{$fg_bold[blue]%}$%{$reset_color%} "
