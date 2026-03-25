def diff-pretty [left: string, right: string] {
  diff -u $left $right | bat --language diff
}
