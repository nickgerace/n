alias d = docker
alias dps = docker ps
alias dpsa = docker ps -a
alias dimg = docker images
alias dpss = docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}"

def docker-run-distro [distro: string] {
  let distros = {
    alpine:     { docker run -it --rm alpine:latest }
    archlinux:  { docker run -it --rm archlinux:latest }
    debian:     { docker run -it --rm debian:stable-slim }
    fedora:     { docker run -it --rm fedora:latest }
    linuxbrew:  { docker run -it --rm --entrypoint /bin/bash linuxbrew/linuxbrew:latest }
    nixos:      { docker run -it --rm nixos/nix:latest }
    tumbleweed: { docker run -it --rm opensuse/tumbleweed:latest }
    ubuntu:     { docker run -it --rm ubuntu:rolling }
  }

  if $distro in $distros {
    do ($distros | get $distro)
  } else {
    $distros | columns
  }
}

def docker-prune-containers [] {
    docker stop (docker ps -aq)
    docker rm (docker ps -aq)

    docker volume prune -f
    docker volume rm (docker volume ls -q)
}

def docker-prune-everything [] {
    docker stop (docker ps -aq)
    docker rm (docker ps -aq)

    docker rmi (docker images -q)
    docker system prune -a -f

    docker volume prune -f
    docker volume rm (docker volume ls -q)
}
