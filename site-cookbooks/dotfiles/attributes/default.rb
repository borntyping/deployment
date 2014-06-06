#
# Default attributes for use when configuring dotfiles
#

default[:dotfiles][:user] = 'sam'
default[:dotfiles][:group] = node[:dotfiles][:user]
default[:dotfiles][:home] = "/home/#{node[:dotfiles][:user]}"
