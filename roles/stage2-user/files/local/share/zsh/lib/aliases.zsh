#!/bin/zsh

alias ls='ls --color=auto'              # Use colors for ls output
alias grep='grep --color=auto'          # Use colors for grep output
alias -g ...='../..'                    # Allow ... to mean ../.. anywhere

alias gd='git diff'
alias gs='git status'
alias gc='git commit -v'                # Show diff in commit editor
alias gca='git commit -v -a'            # Show diff in commit editor, commit all

alias dct='ds-cookbook-test'
alias dke='knife block use'

alias blink1-red='blink1-tool --id all --rgb 250,0,0'
alias blink1-orange='blink1-tool --id all --rgb 200,150,0'
alias blink1-green='blink1-tool --id all --rgb 0,150,0'

alias ansible-zshrc='ansible-run -t zshrc; source ~/.zshrc'

alias rac='rubocop --auto-correct'

# Send an alert with the status of the previous command
function alert() {
    local SUCCESS=$?
    local COMMAND="$(echo $history[$HISTCMD] | sed "s/; alert//")"
    local ICONS="/usr/share/icons/Mint-X/status/16"

    paplay "/usr/share/sounds/pop.wav"

    if [[ $SUCCESS == 0 ]]; then
        notify-send -i "${ICONS}/dialog-information.png" \
            "Command finished: ${COMMAND}"
    else
        notify-send -i "${ICONS}/dialog-error.png" \
            "Command failed: ${COMMAND}"
    fi
}
