#
# Sets up ZSH and my oh-my-zsh configuration
#

package 'zsh'

git 'oh-my-zsh' do
    destination File.join(node[:dotfiles][:home], '.oh-my-zsh')
    repository 'git@github.com:borntyping/oh-my-zsh.git'
    user node[:dotfiles][:user]
    group node[:dotfiles][:user]
    action :sync
end

user node[:dotfiles][:user] do
  shell '/usr/bin/zsh'
  action :modify
end

dotfile '.zshenv'
dotfile '.zshrc'
