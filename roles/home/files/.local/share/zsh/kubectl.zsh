#!/usr/bin/env zsh

if [[ -v 'commands[kubectl]' ]]; then
    # shellcheck disable=SC1090
    source <(kubectl completion zsh)

    function k() {
        kubectl "$@"
    }

    function kj() {
        kubectl --output="json" "$@"
    }

    function ky() {
        kubectl --output="yaml" "$@" | bat --language="yaml"
    }
fi

if [[ -v 'commands[kubectl-ctx]' ]]; then
    alias kubectx="kubectl-ctx"
fi

if [[ -v 'commands[kubectl-ns]' ]]; then
    alias kubens="kubectl-ns"
fi

if [[ -v '_comps[kubectl]' ]]; then
    compdef k=kubectl
    compdef kj=kubectl
    compdef ky=kubectl
fi
