#!/bin/zsh
#
# Aliases
#

# Color basic commands.
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ls helpers
alias ll='ls -l'
alias la='ls -la'

# Short git helpers.
alias gd='git diff'
alias gs='git status'
alias gc='git commit'
alias gca='git commit -a'
alias cola='git-cola &'
alias gg='gitg &'

# Run ansible and reload ZSH.
alias ansible-zshrc='ansible-run -t zshrc; source ~/.zshrc'
alias ansible-ssh='ansible-run -t ssh'

# Bundler/Chef aliases
alias ce='chef exec'
alias cb='chef exec bundle exec'
alias be='bundle exec'

# I always get this wrong...
alias httpie='http'

# Molecule is hard to spell
alias mc='molecule'
alias mcc='mc converge; mc verify'
