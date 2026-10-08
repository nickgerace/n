function tofu-clean {
  local -a plans=(${(0)"$(fd --hidden --no-ignore --case-sensitive --type f --extension tfplan --print0)"})
  local reply
  (( ${#plans} )) || return 0
  printf '%s\n' "${plans[@]}"
  read -r "reply?Delete all ${#plans} .tfplan files? [y/N] " || return 0
  [[ "$reply" == [yY] ]] || return 0
  command rm -v -- "${plans[@]}"
}
