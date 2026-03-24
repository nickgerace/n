alias k = kubectl

alias kgp = kubectl get pods
alias kgpa = kubectl get pods -A
alias kgn = kubectl get nodes

alias k-get-pods-not-running = kubectl get pods -A --field-selector status.phase!=Running

