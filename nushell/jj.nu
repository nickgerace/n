alias git = jj

alias jjst = jj status

def jjd [language?: string] {
  if $language == null {
    jj diff
  } else if $language == "rust" {
    jj diff -- 'glob:**/*.rs'
  } else {
    'language option(s): rust'
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

def jj-rebase [branch: string, main: string] {
  jj rebase -b $branch -d $main
}

def jjfold [] {
  ls ~/src | where type == dir | each { |d| print $d.name; cd $d.name; print (jj status); print "---" } | ignore
}
