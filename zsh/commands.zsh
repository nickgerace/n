alias n='cd "$NICK_DOTFILES"'
alias cdn='cd "$NICK_DOTFILES"'
alias hxn='hx "$NICK_DOTFILES/zshrc"'
alias hxd='hx "$NICK_DOTFILES/"'
alias update='"$NICK_DOTFILES/bin/update.sh"'

alias ls='eza'
alias exa='eza'
alias neofetch='fastfetch'
alias ghostty-docs='ghostty +show-config --default --docs'
alias ghostty-keybinds='ghostty +list-keybinds'
alias ghostty-themes='ghostty +list-themes'
alias cargo-check-all='cargo check --all-targets --all-features'
alias trivy-scan='trivy image -s "HIGH,CRITICAL"'

alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
alias cm='container machine'
alias h='history'
alias history='fc -lf -20'
alias v='hx'
alias vi='hx'
alias vim='hx'
alias ping5='ping -c 5'
alias rmi='rm -i'

if (( $+commands[zoxide] )); then
  alias cd='z'
fi

function _n_boolean {
  [[ "$1" == true || "$1" == false ]]
}

function path-pretty-print {
  (( $# == 0 )) || { print -u2 'usage: path-pretty-print'; return 2; }
  print -l -- $path
}

function alias-search {
  (( $# == 1 )) || { print -u2 'usage: alias-search <pattern>'; return 2; }
  alias | rg -- "$1"
}

function find-file {
  (( $# == 1 )) || { print -u2 'usage: find-file <name-or-pattern>'; return 2; }
  find . -name "$1"
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
