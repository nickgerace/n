alias git = jj

alias jjst = jj status

def jjd [--rust, file?: string] {
  if $rust and $file != null {
    jj diff $file -- 'glob:**/*.rs'
  } else if $rust {
    jj diff -- 'glob:**/*.rs'
  } else if $file != null {
    jj diff $file
  } else {
    jj diff
  }
}

def jjl [all?: bool = false] {
  if $all {
    jj bookmark list --all-remotes
  } else {
    jj bookmark list
  }
}

def jj-email-update-repo [email: string] {
  jj config set --repo user.email $"($email)"
  jj metaedit --update-author
}

alias jj-fetch = jj git fetch --all-remotes

def jj-show-trunk [n: int = 25] {
  jj log -r $"ancestors\(trunk\(\), ($n)\)"
}

def jj-rebase [branch: string, main: string] {
  jj rebase -b $branch -d $main
}

def jjfold [] {
  ls ~/src | where type == dir | each { |d| print $d.name; cd $d.name; print (jj status); print "---" } | ignore
}

def jj-change-history [rev: string] {
  jj evolog -r $rev -p --git
}
