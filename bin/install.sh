#!/usr/bin/env bash
set -eu

BOOTSTRAP_PLATFORM="false"
REPO="$HOME/src/n"
OS=$(uname -s)

LOG_FORMAT_BOLD=$(tput bold)
LOG_FORMAT_GREEN=$(tput setaf 2)
LOG_FORMAT_RED=$(tput setaf 1)
LOG_FORMAT_RESET=$(tput sgr0)

function log {
  echo "${LOG_FORMAT_BOLD}$1${LOG_FORMAT_RESET}"
}

function log-success {
  echo "${LOG_FORMAT_BOLD}${LOG_FORMAT_GREEN}$1${LOG_FORMAT_RESET}"
}

function log-error {
  echo "${LOG_FORMAT_BOLD}${LOG_FORMAT_RED}error: $1${LOG_FORMAT_RESET}" >&2
}

log "Welcome to @nickgerace's dotfiles setup and platform bootstrap script!"

if [ $EUID -eq 0 ]; then
  log-error "must run as non-root user"
  exit 1
fi

if [ "$OS" != "Darwin" ] && [ "$OS" != "Linux" ]; then
  log-error "unsupported platform found: $OS (only macOS and Linux are supported)"
  exit 1
fi

if [ "$OS" = "Darwin" ] && [ "$(uname -m)" = "arm64" ]; then
  while true; do
    read -r -n1 -p "Do you want to install packages in addition to setting up dotfiles? [y/N]: " yn
    case $yn in
    [yY])
      BOOTSTRAP_PLATFORM="true"
      echo ""
      break
      ;;
    "") break ;;
    *)
      echo ""
      break
      ;;
    esac
  done
fi

while true; do
  read -r -n1 -p "Confirm to begin [Y/n]: " yn
  case $yn in
  [yY])
    echo ""
    break
    ;;
  "")
    echo ""
    break
    ;;
  *) exit 0 ;;
  esac
done

function link {
  if [ ! -f "$1" ]; then
    log-error "file does not exist: $1"
    exit 1
  fi

  local DIRNAME
  DIRNAME=$(dirname "$2")

  if [ -d "$DIRNAME" ]; then
    if [ -f "$2" ] || [ -L "$2" ]; then
      rm "$2"
    fi
  elif [ "$HOME" != "$DIRNAME" ]; then
    mkdir -p "$DIRNAME"
  fi

  log "Linking: $1 --> $2"
  ln -s "$1" "$2"
}

function merge-json {
  if [ ! -f "$1" ]; then
    log-error "file does not exist: $1"
    exit 1
  fi

  if [ ! -f "$2" ]; then
    log "Skipping: $1 --> $2 (destination does not exist)"
    return
  fi

  if ! command -v jq >/dev/null; then
    log-error "jq is required to merge: $1"
    exit 1
  fi

  local TMP
  TMP=$(mktemp "$2.XXXXXX")

  log "Merging: $1 --> $2"
  if ! jq -s '
    def merge($a; $b):
      if ($a | type) == "object" and ($b | type) == "object" then
        reduce ($b | keys_unsorted[]) as $k ($a; .[$k] = merge($a[$k]; $b[$k]))
      elif ($a | type) == "array" and ($b | type) == "array" then
        $a + ($b - $a)
      elif $b == null then $a
      else $b end;
    merge(.[0]; .[1])
  ' "$2" "$1" >"$TMP"; then
    rm "$TMP"
    log-error "could not merge: $1 --> $2"
    exit 1
  fi
  mv "$TMP" "$2"
}

if [ "$BOOTSTRAP_PLATFORM" = "true" ]; then
  log "Checking if cargo is installed via rustup..."
  if ! command -v cargo; then
    log "Installing Rust via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

    log "Setting cargo env for this script..."
    . "$HOME/.cargo/env"

    log "Installing rust-analzyer via rustup..."
    rustup component add rust-analyzer
  fi

  log "Checking if homebrew is installed..."
  if ! command -v brew; then
    log-error "could not install packages: homebrew is not installed"
    exit 1
  fi

  log "Setting up brew taps..."
  brew tap philocalyst/tap

  log "Installing brew packages..."
  xargs brew install <"$REPO/pkgs/brew-base.lst"
fi

log "Setting up core dotfiles..."
link "$REPO/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
link "$REPO/gfold/config.toml" "$HOME/.config/gfold.toml"
link "$REPO/helix/config.toml" "$HOME/.config/helix/config.toml"
link "$REPO/helix/ignore" "$HOME/.config/helix/ignore"
link "$REPO/helix/languages.toml" "$HOME/.config/helix/languages.toml"
link "$REPO/jj/config.toml" "$HOME/.config/jj/config.toml"
link "$REPO/zshrc" "$HOME/.zshrc"

log "Setting up primary agent files..."
link "$REPO/AGENTS.md" "$HOME/.claude/CLAUDE.md"
link "$REPO/AGENTS.md" "$HOME/.codex/AGENTS.md"
link "$REPO/codex/rules/agents.rules" "$HOME/.codex/rules/agents.rules"
merge-json "$REPO/claude/rules.json" "$HOME/.claude/settings.json"

log "Setting up agent reference files..."
for file in "$REPO"/agents/*.md; do
  link "$file" "$HOME/.config/agents/${file##*/}"
done

if [ "$OS" = "Darwin" ]; then
  link "$REPO/ghostty/config.ghostty" "$HOME/.config/ghostty/config.ghostty"
elif [ "$OS" = "Linux" ]; then
  link "$REPO/experiments/framework/config.ghostty" "$HOME/.config/ghostty/config.ghostty"
fi

log-success "Success!"
