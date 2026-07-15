typeset -U path PATH

for directory in \
  /home/linuxbrew/.linuxbrew/bin \
  /opt/homebrew/bin \
  /opt/homebrew/opt/curl/bin \
  /opt/homebrew/opt/gnu-sed/libexec/gnubin \
  /opt/homebrew/opt/make/libexec/gnubin \
  /usr/local/bin \
  "$HOME/.local/bin" \
  "$HOME/.npm-global/bin"; do
  if [[ -d "$directory" ]]; then
    path=("$directory" $path)
  fi
done

if [[ -d "$HOME/.cargo/bin" ]]; then
  path+=("$HOME/.cargo/bin")
fi

export EDITOR=hx
export VISUAL=hx

if (( $+commands[vivid] )); then
  export LS_COLORS="$(vivid generate rose-pine-dawn)"
fi

if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi
