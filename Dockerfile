# syntax=docker/dockerfile:1
# Define Build Arguments
ARG CREATED
ARG FEDORA_VERSION=40
ARG REVISION
ARG TEXLIVE
ARG VERSION
# Declare the BASE IMAGE
FROM docker.io/library/fedora:${FEDORA_VERSION} AS base
# Ensure Build Arguments are still available
ARG CREATED
ARG FEDORA_VERSION=39
ARG REVISION
ARG TEXLIVE
ARG VERSION

# Set environment variables
ENV PIP_CACHE_DIR=/var/cache/buildkit/pip

# OCI image annotation
# See: https://snyk.io/de/blog/how-and-when-to-use-docker-labels-oci-container-annotations/
# and: https://github.com/opencontainers/image-spec/blob/main/annotations.md
# Deprecated but for backward compatibility
MAINTAINER "Robin Walter <hello@robinwalter.me>"
LABEL org.opencontainers.image.authors="Robin Walter <hello@robinwalter.me>" \
      org.opencontainers.image.base.name="docker.io/library/fedora:${FEDORA_VERSION}" \
      org.opencontainers.image.created="${CREATED}" \
      org.opencontainers.image.description="A Docker Image that provides a LaTeX TeX Live (${TEXLIVE}) installation based on Fedora ${FEDORA_VERSION}." \
      org.opencontainers.image.documentation="https://github.com/robinwalterfit/LatexWorks/wiki" \
      org.opencontainers.image.licenses="MIT OR Apache-2.0" \
      org.opencontainers.image.revision="${REVISION}" \
      org.opencontainers.image.source="https://github.com/robinwalterfit/LatexWorks.git" \
      org.opencontainers.image.title="LatexWorks" \
      org.opencontainers.image.url="https://github.com/robinwalterfit/LatexWorks" \
      org.opencontainers.image.vendor="Robin Walter" \
      org.opencontainers.image.version="${VERSION}"
# --------------------------------------------------------------------------- #
FROM base AS latexworks
# Ensure Build Arguments are still available
ARG CREATED
ARG FEDORA_VERSION=40
ARG REVISION
ARG TEXLIVE
ARG VERSION

MAINTAINER "Robin Walter <hello@robinwalter.me>"

# Install TeX Live
# Cache Mounts
# See: https://docs.docker.com/build/guide/mounts/
# and: https://docs.docker.com/reference/dockerfile/#run
# as well as: https://github.com/moby/buildkit/issues/1673
# We set the option `keepcache=True` to tell DNF to keep all downloaded packages in the cache even
# after a successfull installation. This should speed up building the image, since the packages
# don't necessarily need to be redownloaded.
RUN --mount=type=cache,id=latexworks-dnf,target=/var/cache/dnf,sharing=locked,mode=0755 \
    --mount=type=cache,id=latexworks-dnf-lists,target=/var/lib/dnf,sharing=locked,mode=0755 \
    dnf install --assumeyes --setopt=install_weak_deps=False --setopt=keepcache=True \
        "${TEXLIVE}" \
        latexmk \
        texlive-chktex \
        texlive-texcount \
        # Install additional useful tools
        bash \
        curl \
        git \
        pandoc \
        wget \
        # Install Python packages so LaTeX documents could be templated with Jinja2
        python3 \
        python3-jinja2 \
        python3-pip \
        python3-setuptools \
        python3-virtualenv \
        python3-wheel && \
# Create the cache directory for pip
    mkdir --parents "${PIP_CACHE_DIR}"

COPY --chmod=u=rwx,g=rx,o=rx --link ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/bin/bash", "-c", "docker-entrypoint.sh"]
# --------------------------------------------------------------------------- #
FROM latexworks AS devcontainer
# Ensure Build Arguments are still available
ARG CREATED
ARG FEDORA_VERSION=40
ARG HADOLINT_VERSION=2.12.0
ARG PYENV_VERSION=2.3.24
ENV PYTHON_BUILD_CACHE_PATH=/var/cache/buildkit/python-build
ENV PYTHON_BUILD_HTTP_CLIENT=curl
ARG PYTHON_VERSION=3.10.6
ARG REVISION
ARG TEXLIVE
ARG VERSION
# User mapping - important for devcontainers
ARG USERNAME=latexworks
ARG USER_UID=1000
ARG USER_GID=$USER_UID

MAINTAINER "Robin Walter <hello@robinwalter.me>"
LABEL org.opencontainers.image.description="A Docker Image that provides a LaTeX TeX Live (${TEXLIVE}) installation based on Fedora ${FEDORA_VERSION} to be used as a Devcontainer." \
      org.opencontainers.image.title="LatexWorks Devcontainer"

# See `--> HERE` why we ignore rule SC2016
# hadolint ignore=SC2016
RUN --mount=type=cache,id=latexworks-devcontainer-dnf,target=/var/cache/dnf,sharing=locked,mode=0755 \
    --mount=type=cache,id=latexworks-devcontainer-dnf-lists,target=/var/lib/dnf,sharing=locked,mode=0755 \
    dnf groupinstall --assumeyes --setopt=install_weak_deps=False --setopt=keepcache=True \
        "Development Tools" \
        "Development Libraries" && \
    dnf install --assumeyes --setopt=install_weak_deps=False --setopt=keepcache=True \
        curl \
        git \
        man \
        man-pages \
        nano \
        procps-ng \
        shellcheck \
        sqlite \
        sqlite-devel \
        sqlite-libs \
        sudo \
        wget \
        zsh && \
# Add non-root user
    # Check if group exists or create it if not
    if ! getent group "${USER_GID}" >/dev/null 2>&1; then \
        groupadd --gid "${USER_GID}" "${USERNAME}"; \
    fi && \
    # Check if user exists or create it if not
    if ! id "${USER_UID}" >/dev/null 2>&1; then \
        useradd --create-home --gid "${USER_GID}" --groups "wheel" --home-dir "/home/${USERNAME}" --shell "/usr/bin/zsh" --uid "${USER_UID}" "${USERNAME}"; \
    else \
        usermod --append --gid "${USER_GID}" --groups "wheel" --home "/home/${USERNAME}" --login "${USERNAME}" --move-home --shell "/usr/bin/zsh" "${USERNAME}" && \
        # Make sure the ownership of the home directory is correct
        chown --recursive "${USER_UID}:${USER_GID}" "/home/${USERNAME}"; \
    fi && \
    echo "${USERNAME} ALL=(root) NOPASSWD: ALL" > "/etc/sudoers.d/${USERNAME}" && \
    chmod 0440 "/etc/sudoers.d/${USERNAME}" && \
# Create the cache and workspace directories
    mkdir --parents "${PYTHON_BUILD_CACHE_PATH}}" && \
    mkdir --parents "/workspace" && \
    chown --recursive "${USER_UID}:${USER_GID}" "${PIP_CACHE_DIR}" && \
    chown --recursive "${USER_UID}:${USER_GID}" "${PYTHON_BUILD_CACHE_PATH}}" && \
    chown --recursive "${USER_UID}:${USER_GID}" "/workspace" && \
# Download and install Python via pyenv
    mkdir --parents "/home/${USERNAME}" && \
    git clone --depth 1 --branch "v${PYENV_VERSION}" 'https://github.com/pyenv/pyenv.git' "/home/${USERNAME}/.pyenv" && \
    # --> HERE: We don't want to expand the variable here
    echo 'eval "$(pyenv init --path)"' >> "/home/${USERNAME}/.zshrc" && \
    chown --recursive "${USER_UID}:${USER_GID}" "/home/${USERNAME}/.pyenv"
ENV PYENV_ROOT="/home/${USERNAME}/.pyenv"
ENV PATH="${PYENV_ROOT}/bin:${PATH}"

# Install hadolint
WORKDIR /tmp
RUN --mount=type=tmpfs,target=/tmp \
    curl --location --remote-name "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-$(if test "$(uname -m)" = 'x86_64'; then printf 'x86_64'; else printf 'arm64'; fi)" && \
    mv hadolint-Linux-* /usr/local/bin/hadolint && \
    chmod +x /usr/local/bin/hadolint

WORKDIR /

USER $USERNAME

# Install required Python version via pyenv
RUN --mount=type=cache,id=latexworks-devcontainer-pyenv,target=$PYTHON_BUILD_CACHE_PATH,sharing=shared,mode=0755,uid=$USER_UID,gid=$USER_GID \
    eval "$(pyenv init --path)" && \
    env PYTHON_CONFIGURE_OPTS='--enable-optimizations --with-lto' \
        PYTHON_CFLAGS='-march=native -mtune=native' && \
    pyenv install "${PYTHON_VERSION}" && \
    pyenv global "${PYTHON_VERSION}" && \
    pyenv rehash

# Add pip user installed packages to PATH
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"

WORKDIR /workspace
