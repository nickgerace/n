# The "use" files created from "env.nu" (must come before the first source call)
use ~/.config/nushell/mise.nu

# The "source" files created from "env.nu"
source ~/.config/nushell/jj.nu
source ~/.config/nushell/just.nu
source ~/.config/nushell/zoxide.nu

# Loaded theme from the install script
source ~/.config/nushell/theme.toml

alias hxn = config nu
alias hxd = hx ~/src/dotfiles/
alias update = ^~/src/dotfiles/bin/update.sh

# Load the remaining nushell files in the repository
source brew.nu
source diff.nu
source docker.nu
source eza.nu
source fastfetch.nu
source ghostty.nu
source jj.nu
source kubernetes.nu
source rust.nu
source trivy.nu

# Unsupported integrations that were supported in zsh:
# - brew
# - fnm
# - fzf

$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/opt/curl/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/opt/make/libexec/gnubin')

