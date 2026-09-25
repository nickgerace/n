alias k="kubectl"

function _k {
  local context="$words[2]"
  if (( CURRENT == 2 )); then
    words=(kubectl --context "$context")
    CURRENT=3
  else
    words=(kubectl --context "$context" "${(@)words[3,-1]}")
    (( CURRENT++ ))
  fi
  _kubectl
}

if (( $+functions[_kubectl] )); then
  compdef _k k
fi

function kgn {
  (( $# >= 1 )) || { print -u2 'usage: kgn <context> [arguments...]'; return 2; }
  k "$1" get nodes "${@:2}"
}

function kgp {
  (( $# >= 1 )) || { print -u2 'usage: kgp <context> [arguments...]'; return 2; }
  k "$1" get pods "${@:2}"
}

function kgns {
  (( $# >= 1 )) || { print -u2 'usage: kgns <context> [arguments...]'; return 2; }
  k "$1" get namespaces "${@:2}"
}

function kge {
  (( $# >= 1 )) || { print -u2 'usage: kge <context> [arguments...]'; return 2; }
  k "$1" get events -A --sort-by=.metadata.creationTimestamp "${@:2}"
}

function kgpa {
  setopt local_options pipefail
  if (( $# < 1 || $# > 2 )) || { (( $# == 2 )) && ! _n_boolean "$2"; }; then
    print -u2 'usage: kgpa <context> [true|false]'
    return 2
  fi
  # TODO(nick): fix this to make it actually usable.
  if [[ "${2:-false}" == true ]]; then
    k "$1" get pods -A | awk 'NR == 1 || ($1 != "kube-system" && $1 != "gmp-system" && $1 != "gke-managed-cim")'
  else
    k "$1" get pods -A
  fi
}

function kubectl-dead-pods {
  setopt local_options pipefail
  if (( $# < 1 || $# > 2 )) || { (( $# == 2 )) && ! _n_boolean "$2"; }; then
    print -u2 'usage: kubectl-dead-pods <context> [true|false]'
    return 2
  fi
  if [[ "${2:-false}" == true ]]; then
    watch -x zsh -c 'kubectl get pods --context "$1" -A | rg -v "Running|Completed"' zsh "$1"
  else
    k "$1" get pods -A | rg -v 'Running|Completed'
  fi
}

function kubectl-exec {
  if (( $# != 3 )); then
    print -u2 'usage: kubectl-exec <context> <namespace> <pod>'
    return 2
  fi
  k "$1" exec "$3" -n "$2" -it -- /bin/bash
}

function kubectl-exec-windows {
  if (( $# != 3 )); then
    print -u2 'usage: kubectl-exec-windows <context> <namespace> <pod>'
    return 2
  fi
  k "$1" exec "$3" -n "$2" -it -- powershell.exe
}

function kubectl-all-images {
  setopt local_options pipefail
  if (( $# != 1 )); then
    print -u2 'usage: kubectl-all-images <context>'
    return 2
  fi
  k "$1" get pods -A -o 'jsonpath={..image}' | tr -s '[:space:]' '\n' | sort | uniq -c
}

function kubectl-get-pods-names-only {
  if (( $# < 1 || $# > 2 )); then
    print -u2 'usage: kubectl-get-pods-names-only <context> [namespace]'
    return 2
  fi
  if (( $# == 2 )); then
    k "$1" get pods -n "$2" --no-headers -o 'custom-columns=:metadata.name'
  else
    k "$1" get pods -A --no-headers -o 'custom-columns=:metadata.namespace,:metadata.name'
  fi
}

function ks {
  if (( $# < 1 )) || [[ -z "$1" || "$1" == -* ]]; then
    print -u2 'usage: ks <context> [k9s arguments...]'
    return 2
  fi
  k9s --context "$1" "${@:2}"
}

alias ktx='kubectx'
alias kns='kubens'
alias kcl='k3d cluster list'
alias kcd='k3d cluster delete'

function kcc {
  if (( $# > 1 )); then
    print -u2 'usage: kcc [cluster-name]'
    return 2
  fi
  k3d cluster create "${1:-$(uuidgen | tr '[:upper:]' '[:lower:]' | cut -c1-7)}"
}
