alias git = jj

alias jjst = jj status

def jjd [--glob-only-rs-files, --exclude-rs-files, --include-cargo-lock, file?: string] {
  if $glob_only_rs_files and $include_cargo_lock {
    error make {msg: "--glob-only-rs-files and --include-cargo-lock are mutually exclusive"}
  }

  mut parts = []
  if $file != null {
    $parts = ($parts | append $file)
  }
  if $glob_only_rs_files {
    $parts = ($parts | append 'glob:"**/*.rs"')
  }
  
  let args = if ($parts | is-empty) {
    'all()'
  } else {
    $parts | str join ' | '
  }
  let args = if $include_cargo_lock or not ((jj root | str trim | path join Cargo.lock) | path exists) {
    $args
  } else {
    $"($args) ~ Cargo.lock"
  }
  let args = if $exclude_rs_files {
    $"($args) ~ glob:\"**/*.rs\""
  } else {
    $args
  }

  jj diff -- $args
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
