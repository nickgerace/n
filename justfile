install:
    @bin/install.sh

update:
	@bin/update.sh

format:
    -shfmt -i 2 -w **/*.sh

list:
    @scripts/list-owned-repos.sh
