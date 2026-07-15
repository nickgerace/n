alias n='cd "$NICK_DOTFILES"'
alias cdn='cd "$NICK_DOTFILES"'
alias hxn='hx "$NICK_DOTFILES/.zshrc"'
alias hxd='hx "$NICK_DOTFILES/"'
alias update='"$NICK_DOTFILES/bin/update.sh"'

alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimg='docker images'
alias dpss='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}"'

alias exa='eza'
alias neofetch='fastfetch'
alias ghostty-docs='ghostty +show-config --default --docs'
alias ghostty-keybinds='ghostty +list-keybinds'
alias ghostty-themes='ghostty +list-themes'
alias jjst='jj status'
alias jj-fetch='jj git fetch --all-remotes'
alias k='kubectl'
alias kgn='kubectl get nodes'
alias cargo-check-all='cargo check --all-targets --all-features'
alias trivy-scan='trivy image -s "HIGH,CRITICAL"'

if (( $+functions[_kubectl] )); then
  compdef _kubectl k
fi

if (( $+commands[zoxide] )); then
  alias cd='z'
fi

function _n_boolean {
  [[ "$1" == true || "$1" == false ]]
}

function brew-list-packages {
  if (( $# > 1 )) || { (( $# == 1 )) && ! _n_boolean "$1"; }; then
    print -u2 'usage: brew-list-packages [true|false]'
    return 2
  fi
  if [[ "${1:-false}" == true ]]; then
    brew list --installed-on-request
  else
    brew list --installed-on-request -t
  fi
}

function diff-pretty {
  if (( $# != 2 )); then
    print -u2 'usage: diff-pretty <left> <right>'
    return 2
  fi
  diff -u "$1" "$2" | bat --language diff
}

function docker-run-distro {
  if (( $# != 1 )); then
    print -u2 'usage: docker-run-distro <alpine|archlinux|debian|fedora|linuxbrew|nixos|tumbleweed|ubuntu>'
    return 2
  fi
  case "$1" in
    alpine) docker run -it --rm alpine:latest ;;
    archlinux) docker run -it --rm archlinux:latest ;;
    debian) docker run -it --rm debian:stable-slim ;;
    fedora) docker run -it --rm fedora:latest ;;
    linuxbrew) docker run -it --rm --entrypoint /bin/bash linuxbrew/linuxbrew:latest ;;
    nixos) docker run -it --rm nixos/nix:latest ;;
    tumbleweed) docker run -it --rm opensuse/tumbleweed:latest ;;
    ubuntu) docker run -it --rm ubuntu:rolling ;;
    *)
      print -u2 'usage: docker-run-distro <alpine|archlinux|debian|fedora|linuxbrew|nixos|tumbleweed|ubuntu>'
      return 2
      ;;
  esac
}

function docker-prune-containers {
  (( $# == 0 )) || { print -u2 'usage: docker-prune-containers'; return 2; }
  docker stop $(docker ps -aq) || true
  docker rm $(docker ps -aq) || true
  docker volume prune -f || true
  docker volume rm $(docker volume ls -q) || true
}

function docker-prune-everything {
  (( $# == 0 )) || { print -u2 'usage: docker-prune-everything'; return 2; }
  docker stop $(docker ps -aq) || true
  docker rm $(docker ps -aq) || true
  docker rmi $(docker images -q) || true
  docker system prune -a -f || true
  docker volume prune -f || true
  docker volume rm $(docker volume ls -q) || true
}

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

function kgpa {
  if (( $# > 1 )) || { (( $# == 1 )) && ! _n_boolean "$1"; }; then
    print -u2 'usage: kgpa [true|false]'
    return 2
  fi
  if [[ "${1:-false}" == true ]]; then
    watch 'kubectl get pods -A'
  else
    kubectl get pods -A
  fi
}

function kubectl-dead-pods {
  if (( $# > 1 )) || { (( $# == 1 )) && ! _n_boolean "$1"; }; then
    print -u2 'usage: kubectl-dead-pods [true|false]'
    return 2
  fi
  if [[ "${1:-false}" == true ]]; then
    watch 'kubectl get pods -A | rg -v "Running|Completed"'
  else
    kubectl get pods -A | rg -v 'Running|Completed'
  fi
}

function ps-me {
  if (( $# != 0 )); then
    print -u2 'usage: ps-me'
    return 2
  fi
  ps -e -o pid=,ppid=,user=,state=,command= | awk '$2 != 1' | sort -n -k2
}

function shfmt-write {
  if (( $# != 1 )); then
    print -u2 'usage: shfmt-write <path>'
    return 2
  fi
  shfmt -l -i 2 -w "$1"
}
