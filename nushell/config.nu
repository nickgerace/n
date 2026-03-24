# This must come before the first "source" call.
use ~/.config/nushell/mise.nu

$env.config.show_banner = false

$env.EDITOR = "hx"
$env.VISUAL = "hx"
$env.config.buffer_editor = "hx"

alias hxn = config nu
alias hxd = hx ~/src/dotfiles/

$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '~/.local/bin')

alias update = ^~/src/dotfiles/bin/update.sh

$env.LS_COLORS = (vivid generate rose-pine-dawn)

source ~/.config/nushell/theme.toml

source brew.nu
source completions.nu
source jj.nu
source kubernetes.nu
source rust.nu
