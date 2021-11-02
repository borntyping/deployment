#
# Kubernetes completion
# https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion
#

function kj() { kubectl --output="json" "$@"; }
function ky() { kubectl --output="yaml" "$@" | bat --language="yaml"; }

alias k=kubectl
compdef k=kubectl
compdef kj=kubectl
compdef ky=kubectl
