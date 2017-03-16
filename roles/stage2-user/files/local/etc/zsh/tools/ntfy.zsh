#!/bin/zsh
#
# https://github.com/dschep/ntfy
#

export AUTO_NTFY_DONE_LONGER_THAN=-L60

which ntfy >/dev/null && eval "$(ntfy shell-integration)"
