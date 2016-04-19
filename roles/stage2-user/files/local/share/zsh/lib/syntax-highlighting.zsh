#!/bin/zsh

source "$HOME/.local/share/zsh/plugins/syntax-highlighting/zsh-syntax-highlighting.zsh"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[comment]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('rm -r *' 'fg=white,bold,bg=yellow')
ZSH_HIGHLIGHT_PATTERNS+=('knife block use p*' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('knife block use s*' 'fg=white,bold,bg=yellow')
ZSH_HIGHLIGHT_PATTERNS+=('knife block use n*' 'fg=white,bold,bg=green')
