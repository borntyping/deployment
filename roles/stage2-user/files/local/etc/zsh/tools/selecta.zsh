#
# Add a keybinding for selecta.
# https://github.com/vindolin/selecta
#

function selecta_widget {
  selecta --remove-bash-prefix --revert-order --remove-duplicates --show-hits <(fc -l)
}

zle -N selecta selecta_widget
bindkey '^y' selecta
