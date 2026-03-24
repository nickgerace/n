alias k = kubectl

alias kgn = kubectl get nodes

def kgpa [watch?: bool = false] {
  if $watch {
    ^watch 'kubectl get pods -A'
  } else {
    kubectl get pods -A
  }
}

def kubectl-dead-pods [watch?: bool = false] {
  if $watch {
    ^watch 'kubectl get pods -A | rg -v "Running|Completed"'
  } else {
    kubectl get pods -A | rg -v 'Running|Completed'
  }
}
