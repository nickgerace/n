def brew-list-packages [alphabetical?: bool = false] {
  if $alphabetical {
    brew list --installed-on-request
  } else {
    brew list --installed-on-request -t
  }
}
