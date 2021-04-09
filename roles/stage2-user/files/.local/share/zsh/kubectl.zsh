#
# Kubernetes completion
# https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion
#

source <(kubectl completion zsh)

alias k='kubectl'

function kj() {
  kubectl --output="json" "$@"
}

function ky() {
  kubectl --output="yaml" "$@" | bat --language="yaml"
}

compdef k="kubectl"
compdef kj="kubectl"
compdef ky="kubectl"
