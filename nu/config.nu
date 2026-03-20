$env.config.show_banner = false

$env.EDITOR = "hx"
$env.VISUAL = "hx"
$env.config.buffer_editor = "hx"

alias hxn = config nu
alias hxd = hx ~/src/dotfiles/

$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '~/.local/bin')
$env.PATH = ($env.PATH | append "~/.cargo/bin")

alias update = ^~/src/dotfiles/bin/update.sh

$env.LS_COLORS = (vivid generate catppuccin-latte)

source "~/.cargo/env.nu"

source jj.nu
source catppuccin_latte.nu

source ~/.config/nushell/completions/zoxide.nu
source ~/.config/nushell/completions/just.nu
