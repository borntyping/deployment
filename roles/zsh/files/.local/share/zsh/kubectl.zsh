#!/usr/bin/env zsh

if [[ -v 'commands[bat]' ]]; then
  _YAML_PAGER='bat --language=yaml'
elif [[ -v 'commands[batcat]' ]]; then
  _YAML_PAGER='batcat --language=yaml'
else
  _YAML_PAGER='cat'
fi

# Helm
# https://helm.sh/docs/helm/helm_completion_zsh/
if [[ -v "commands[helm]" ]]; then
  if [[ ! -f "${HOME}/.cache/zsh/functions/_helm" ]]; then
    helm completion zsh > "${HOME}/.cache/zsh/functions/_helm"
    echo "Generated helm completions, restart ${SHELL} to use"
  fi
fi

# kubectl
# https://kubernetes.io/docs/reference/kubectl/
if [[ -v "commands[kubectl]" ]]; then
  if [[ ! -f ${HOME}/.cache/zsh/functions/_kubectl ]]; then
    kubectl completion zsh > "${HOME}/.cache/zsh/functions/_kubectl"
    echo "Generated kubectl completions, restart ${SHELL} to use"
  fi

  function k() {
    kubectl "$@"
  }

  function kj() {
    kubectl --output="json" "$@"
  }

  function ky() {
    kubectl --output="yaml" "$@" | ${=_YAML_PAGER}
  }

  if [[ -v '_comps[kubectl]' ]]; then
    compdef k=kubectl
    compdef kj=kubectl
    compdef ky=kubectl
  fi
fi

# ArgoCD Rollouts
# https://argoproj.github.io/argo-rollouts/installation/#shell-auto-completion
if [[ -v "commands[kubectl-argo-rollouts]" ]]; then
  if [[ ! -f "${HOME}/.cache/zsh/functions/_kubectl"-argo-rollouts ]]; then
    kubectl-argo-rollouts completion zsh > "${HOME}/.cache/zsh/functions/_kubectl-argo-rollouts"
    echo "Generated kubectl-argo-rollouts completions, restart ${SHELL} to use"
  fi
fi

# kubectl + kubens
# https://github.com/ahmetb/kubectx
if [[ -v 'commands[kubectl-ctx]' ]]; then
  alias kubectx="kubectl-ctx"
fi
if [[ -v 'commands[kubectl-ns]' ]]; then
  alias kubens="kubectl-ns"
fi
