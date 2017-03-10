#!/bin/zsh
#
# Send an alert with the status of the previous command
#
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
