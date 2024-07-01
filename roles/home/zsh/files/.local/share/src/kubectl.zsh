#!/usr/bin/env zsh
# shellcheck disable=SC2034

if [[ -v 'commands[bat]' ]]; then
  _TEXT_PAGER='bat'
  _YAML_PAGER='bat --language=yaml'
elif [[ -v 'commands[batcat]' ]]; then
  _TEXT_PAGER='batcat'
  _YAML_PAGER='batcat --language=yaml'
else
  _TEXT_PAGER='cat'
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

  function kb() {
    kubectl "$@" | ${=_TEXT_PAGER}
  }

  function kj() {
    kubectl --output="json" "$@"
  }

  function ky() {
    kubectl --output="yaml" "$@" | ${=_YAML_PAGER}
  }

  function kubectl_post_compinit() {
    if [[ -v '_comps[kubectl]' ]]; then
      compdef k=kubectl
      compdef kb=kubectl
      compdef kj=kubectl
      compdef ky=kubectl
    fi
  }
fi

# Kustomize
# https://kubectl.docs.kubernetes.io/installation/kustomize/
if [[ -v "commands[kustomize]" ]]; then
  if [[ ! -f "${HOME}/.cache/zsh/functions/_kustomize" ]]; then
    kustomize completion zsh > "${HOME}/.cache/zsh/functions/_kustomize"
    echo "Generated kustomize completions, restart ${SHELL} to use"
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
