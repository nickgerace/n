alias jjst='jj status'
alias jj-fetch='jj git fetch --all-remotes'

function jjd {
  local glob_only_rs_files=false
  local exclude_rs_files=false
  local include_cargo_lock=false
  local file=''
  while (( $# > 0 )); do
    case "$1" in
      --glob-only-rs-files) glob_only_rs_files=true ;;
      --exclude-rs-files) exclude_rs_files=true ;;
      --include-cargo-lock) include_cargo_lock=true ;;
      --help|-h)
        print 'usage: jjd [--glob-only-rs-files] [--exclude-rs-files] [--include-cargo-lock] [file]'
        return 0
        ;;
      --*)
        print -u2 "jjd: unknown option: $1"
        return 2
        ;;
      *)
        if [[ -n "$file" ]]; then
          print -u2 'usage: jjd [--glob-only-rs-files] [--exclude-rs-files] [--include-cargo-lock] [file]'
          return 2
        fi
        file="$1"
        ;;
    esac
    shift
  done
  if [[ "$glob_only_rs_files" == true && "$include_cargo_lock" == true ]]; then
    print -u2 'jjd: --glob-only-rs-files and --include-cargo-lock are mutually exclusive'
    return 2
  fi
  local fileset='all()'
  if [[ -n "$file" && "$glob_only_rs_files" == true ]]; then
    fileset="$file | glob:\"**/*.rs\""
  elif [[ -n "$file" ]]; then
    fileset="$file"
  elif [[ "$glob_only_rs_files" == true ]]; then
    fileset='glob:"**/*.rs"'
  fi
  local root
  root="$(jj root)" || return
  if [[ "$include_cargo_lock" != true && -e "$root/Cargo.lock" ]]; then
    fileset="$fileset ~ Cargo.lock"
  fi
  if [[ "$exclude_rs_files" == true ]]; then
    fileset="$fileset ~ glob:\"**/*.rs\""
  fi
  jj diff -- "$fileset"
}

function jjl {
  if (( $# > 1 )) || { (( $# == 1 )) && ! _n_boolean "$1"; }; then
    print -u2 'usage: jjl [true|false]'
    return 2
  fi
  if [[ "${1:-false}" == true ]]; then
    jj bookmark list --all-remotes
  else
    jj bookmark list
  fi
}

function jj-email-update-repo {
  if (( $# != 1 )); then
    print -u2 'usage: jj-email-update-repo <email>'
    return 2
  fi
  jj config set --repo user.email "$1" && jj metaedit --update-author
}

function jj-show-trunk {
  if (( $# > 1 )) || [[ "${1:-25}" != <-> ]]; then
    print -u2 'usage: jj-show-trunk [count]'
    return 2
  fi
  jj log -r "ancestors(trunk(), ${1:-25})"
}

function jj-rebase {
  if (( $# != 2 )); then
    print -u2 'usage: jj-rebase <branch> <main>'
    return 2
  fi
  jj rebase -b "$1" -d "$2"
}

function jjfold {
  if (( $# != 0 )); then
    print -u2 'usage: jjfold'
    return 2
  fi
  local directory
  for directory in "$HOME/src"/*(/); do
    print "$directory"
    (cd "$directory" && jj status)
    print '---'
  done
}

function jj-change-history {
  if (( $# != 1 )); then
    print -u2 'usage: jj-change-history <rev>'
    return 2
  fi
  jj evolog -r "$1" -p --git
}

