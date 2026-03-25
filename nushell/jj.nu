alias git = jj

alias jjst = jj status
alias jjd = jj diff

alias jjl = jj bookmark list
alias jjl-all = jj bookmark list --all-remotes

def jj-email-update-repo [email: string] {
  jj config set --repo user.email $"($email)"
  jj metaedit --update-author
}

alias jj-fetch = jj git fetch --all-remotes

def jj-rebase [branch: string, main: string] {
  jj rebase -b $branch -d $main
}

def jjfold [] {
  ls ~/src | where type == dir | each { |d| print $d.name; cd $d.name; print (jj status); print "---" } | ignore
}
