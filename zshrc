export NICK_SRC="$HOME/src"
export NICK_DOTFILES="$NICK_SRC/n"

source "$NICK_DOTFILES/zsh/environment.zsh"
source "$NICK_DOTFILES/zsh/shell.zsh"
source "$NICK_DOTFILES/zsh/integrations.zsh"

for file in "$NICK_DOTFILES"/zsh/*.zsh(N); do
  case "$file:t" in
    environment.zsh|shell.zsh|integrations.zsh) continue ;;
  esac
  source "$file"
done
