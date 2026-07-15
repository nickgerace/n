autoload -Uz compinit
compinit

bindkey -v
bindkey '^R' history-incremental-search-backward

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history

PROMPT='%F{4}%~%f
%F{5}❯%f '

alias sz='source "$HOME/.zshrc"'
