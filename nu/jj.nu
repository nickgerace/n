source ~/.config/nushell/completions/jj.nu

alias git = jj

alias jjst = jj status
alias jjd = jj diff

alias jjl = jj bookmark list
alias jjl-all = jj bookmark list --all-remotes

def jj-email-update-repo [email: string] {
  jj config set --repo user.email $"($email)"
  jj metaedit --update-author
}
