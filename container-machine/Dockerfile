FROM ubuntu:26.04

ENV container=container
ENV HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
ENV HOMEBREW_CELLAR=/home/linuxbrew/.linuxbrew/Cellar
ENV HOMEBREW_REPOSITORY=/home/linuxbrew/.linuxbrew/Homebrew
ENV RUSTUP_HOME=/opt/rustup
ENV CARGO_HOME=/opt/cargo
ENV PATH=/opt/cargo/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        ca-certificates \
        curl \
        dbus \
        file \
        git \
        iproute2 \
        iputils-ping \
        man \
        net-tools \
        openssh-server \
        procps \
        sudo \
        systemd \
        vim-tiny \
        wget \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN useradd --create-home --shell /bin/bash linuxbrew

USER linuxbrew

RUN HOME=/home/linuxbrew USER=linuxbrew NONINTERACTIVE=1 \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    HOME=/home/linuxbrew USER=linuxbrew brew install \
        helix \
        jj

USER root

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
    sh -s -- -y --no-modify-path --profile minimal \
    --component clippy,rustfmt,rust-analyzer && \
    chmod -R a+rwX "$RUSTUP_HOME" "$CARGO_HOME" "$HOMEBREW_PREFIX"

RUN chmod a+x /home/linuxbrew && \
    printf '%s\n' \
        'export CARGO_HOME=/opt/cargo' \
        'export HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew' \
        'export RUSTUP_HOME=/opt/rustup' \
        'export PATH="$CARGO_HOME/bin:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"' \
        >/etc/profile.d/container-machine.sh

RUN >/etc/machine-id
RUN >/var/lib/dbus/machine-id

RUN systemctl set-default multi-user.target
RUN systemctl mask \
    console-getty.service \
    dev-hugepages.mount \
    sys-fs-fuse-connections.mount \
    systemd-tmpfiles-setup.service \
    systemd-update-utmp.service

RUN sed -i -e 's/^AcceptEnv LANG LC_\*$/#AcceptEnv LANG LC_*/' /etc/ssh/sshd_config
