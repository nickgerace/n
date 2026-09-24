install:
    @bin/install.sh

update:
	@bin/update.sh

check:
    @bin/check.zsh

format:
    -shfmt -i 2 -w **/*.sh
    -if command -v alejandra; then alejandra **/*.nix; fi

list:
    @scripts/list-owned-repos.sh
