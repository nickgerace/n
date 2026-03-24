alias k = kubectl

alias kgp = kubectl get pods
alias kgpa = kubectl get pods -A
alias kgn = kubectl get nodes

def kubectl-dead-pods [] {
  kubectl get pods -A | rg -v 'Running|Completed'
}
