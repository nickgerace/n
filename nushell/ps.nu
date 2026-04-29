def ps-me [] {
  ps | where ppid != 1 | sort-by ppid
}
