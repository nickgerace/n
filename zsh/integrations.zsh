if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

if (( $+commands[fnm] )); then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

if (( $+commands[fzf] )); then
  source <(fzf --zsh)
fi

if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

if (( $+commands[jj] )); then
  source <(jj util completion zsh)
fi

if (( $+commands[just] )); then
  source <(just --completions zsh)
fi

if (( $+commands[kubectl] )); then
  source <(kubectl completion zsh)
fi

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi
