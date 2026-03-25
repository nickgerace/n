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
source jj.nu
source kubernetes.nu
source rust.nu
