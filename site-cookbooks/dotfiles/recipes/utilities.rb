#
# Adds dotfiles for tools installed by system::utilities
#

include_recipe 'system::utilities'

dotfile '.nanorc'
dotfile '.htoprc'
dotfile '.tmux.conf'
