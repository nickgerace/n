alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimg='docker images'
alias dpss='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}"'

function docker-run-distro {
  if (( $# != 1 )); then
    print -u2 'usage: docker-run-distro <alpine|archlinux|debian|fedora|linuxbrew|nixos|tumbleweed|ubuntu>'
    return 2
  fi
  case "$1" in
    alpine) docker run -it --rm alpine:latest ;;
    archlinux) docker run -it --rm archlinux:latest ;;
    debian) docker run -it --rm debian:stable-slim ;;
    fedora) docker run -it --rm fedora:latest ;;
    linuxbrew) docker run -it --rm --entrypoint /bin/bash linuxbrew/linuxbrew:latest ;;
    nixos) docker run -it --rm nixos/nix:latest ;;
    tumbleweed) docker run -it --rm opensuse/tumbleweed:latest ;;
    ubuntu) docker run -it --rm ubuntu:rolling ;;
    *)
      print -u2 'usage: docker-run-distro <alpine|archlinux|debian|fedora|linuxbrew|nixos|tumbleweed|ubuntu>'
      return 2
      ;;
  esac
}

function docker-prune-containers {
  (( $# == 0 )) || { print -u2 'usage: docker-prune-containers'; return 2; }
  docker stop $(docker ps -aq) || true
  docker rm $(docker ps -aq) || true
  docker volume prune -f || true
  docker volume rm $(docker volume ls -q) || true
}

function docker-prune-everything {
  (( $# == 0 )) || { print -u2 'usage: docker-prune-everything'; return 2; }
  docker stop $(docker ps -aq) || true
  docker rm $(docker ps -aq) || true
  docker rmi $(docker images -q) || true
  docker system prune -a -f || true
  docker volume prune -f || true
  docker volume rm $(docker volume ls -q) || true
}
