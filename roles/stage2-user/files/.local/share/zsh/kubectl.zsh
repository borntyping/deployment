#!/usr/bin/env zsh

function k() {
    kubectl "$@"
}

function kj() {
    kubectl --output="json" "$@"
}

function ky() {
    kubectl --output="yaml" "$@" | bat --language="yaml"
}

if [[ "$+commands[kubectl-ctx]" -eq 1 ]]; then
    alias kubectx="kubectl-ctx"
fi

if [[ "$+commands[kubectl-ns]" -eq 1 ]]; then
    alias kubens="kubectl-ns"
fi

# shellcheck disable=SC1090
source <(kubectl completion zsh)
compdef k=kubectl
compdef kj=kubectl
compdef ky=kubectl
