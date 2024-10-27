# syntax=docker/dockerfile:1
# Define Build Arguments
ARG FEDORA_VERSION=40
# Declare the BASE IMAGE
FROM docker.io/library/fedora:${FEDORA_VERSION} AS base
# Define Build Arguments
ARG CREATED
ARG FEDORA_VERSION=40
ARG REVISION
ARG TEXLIVE
ARG VERSION

# Set environment variables
ENV PIP_CACHE_DIR=/var/cache/buildkit/pip

# OCI image annotation
# See: https://snyk.io/de/blog/how-and-when-to-use-docker-labels-oci-container-annotations/
# and: https://github.com/opencontainers/image-spec/blob/main/annotations.md
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

# Install TeX Live
# Cache Mounts
# See: https://docs.docker.com/build/guide/mounts/
# and: https://docs.docker.com/reference/dockerfile/#run
# as well as: https://github.com/moby/buildkit/issues/1673
# We set the option `keepcache=True` to tell DNF to keep all downloaded packages in the cache even
# after a successful installation. This should speed up building the image, since the packages
# don't necessarily need to be re-downloaded.
RUN --mount=type=cache,id=latexworks-dnf,target=/var/cache/dnf,sharing=locked,mode=0755 \
    --mount=type=cache,id=latexworks-dnf-lists,target=/var/lib/dnf,sharing=locked,mode=0755 \
    dnf install --assumeyes --setopt=install_weak_deps=False --setopt=keepcache=True \
        "${TEXLIVE}" \
        latexmk \
        texlive-chktex \
        texlive-texcount \
        # Install inkscape for SVG support
        inkscape \
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

COPY --chmod=0755 --link './docker-entrypoint.sh' '/usr/local/bin/docker-entrypoint.sh'

ENTRYPOINT ["/usr/bin/bash", "-c", "docker-entrypoint.sh"]

# --------------------------------------------------------------------------- #

FROM latexworks AS devcontainer
# Define Build Arguments
ARG CREATED
ARG FEDORA_VERSION=40
ARG HADOLINT_VERSION=2.12.0
ARG LTEX_LS_VERSION=15.2.0
ARG PYENV_VERSION=2.3.24
ARG PYTHON_VERSION=3.10.6
ARG REVISION
ARG TEXLIVE
ARG VERSION
# User mapping - important for dev containers
ARG USERNAME=latexworks
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Set environment variables
ENV JAVA_HOME="/etc/alternatives/jre"
ENV PYENV_ROOT="/home/${USERNAME}/.pyenv"
ENV PYTHON_BUILD_CACHE_PATH=/var/cache/buildkit/python-build
ENV PYTHON_BUILD_HTTP_CLIENT=curl
# Update the PATH variable
ENV PATH="${PYENV_ROOT}/bin:${PATH}"
# Add pip user installed packages to PATH
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"

LABEL org.opencontainers.image.description="A Docker Image that provides a LaTeX TeX Live (${TEXLIVE}) installation based on Fedora ${FEDORA_VERSION} to be used as a Dev Container." \
      org.opencontainers.image.title="LatexWorks Dev Container"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# See `--> HERE` why we ignore rule SC2016
# hadolint ignore=SC2016
RUN --mount=type=cache,id=latexworks-devcontainer-dnf,target=/var/cache/dnf,sharing=locked,mode=0755 \
    --mount=type=cache,id=latexworks-devcontainer-dnf-lists,target=/var/lib/dnf,sharing=locked,mode=0755 \
# Install lefthook repository
    curl --fail --location --silent --tlsv1 'https://dl.cloudsmith.io/public/evilmartians/lefthook/setup.rpm.sh' | bash && \
# Install Git LFS repository
    curl --fail --silent 'https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh' | bash && \
    dnf groupinstall --assumeyes --setopt=install_weak_deps=False --setopt=keepcache=True \
        'Development Tools' \
        'Development Libraries' && \
    dnf install --assumeyes --setopt=install_weak_deps=False --setopt=keepcache=True \
        curl \
        git \
        git-lfs \
        java-17-openjdk \
        lefthook \
        man \
        man-pages \
        nano \
        pipx \
        procps-ng \
        ripgrep \
        shellcheck \
        sqlite \
        sqlite-devel \
        sqlite-libs \
        sudo \
        wget \
        which \
        zsh && \
# Add non-root user
    # Check if group exists or create it if not
    if ! getent group "${USER_GID}" >/dev/null 2>&1; then \
        groupadd --gid "${USER_GID}" "${USERNAME}"; \
    fi && \
    # Check if user exists or create it if not
    if ! id "${USER_UID}" >/dev/null 2>&1; then \
        useradd --create-home --gid "${USER_GID}" --groups 'wheel' --home-dir "/home/${USERNAME}" --shell '/usr/bin/zsh' --uid "${USER_UID}" "${USERNAME}"; \
    else \
        usermod --append --gid "${USER_GID}" --groups 'wheel' --home "/home/${USERNAME}" --login "${USERNAME}" --move-home --shell '/usr/bin/zsh' "${USERNAME}" && \
        # Make sure the ownership of the home directory is correct
        chown --recursive "${USER_UID}:${USER_GID}" "/home/${USERNAME}"; \
    fi && \
    echo "${USERNAME} ALL=(root) NOPASSWD: ALL" > "/etc/sudoers.d/${USERNAME}" && \
    chmod u=r,g=r,o= "/etc/sudoers.d/${USERNAME}" && \
# Create the cache and workspace directories
    mkdir --parents "${PYTHON_BUILD_CACHE_PATH}}" && \
    mkdir --parents '/workspace' && \
    chown --recursive "${USER_UID}:${USER_GID}" "${PIP_CACHE_DIR}" && \
    chown --recursive "${USER_UID}:${USER_GID}" "${PYTHON_BUILD_CACHE_PATH}}" && \
    chown --recursive "${USER_UID}:${USER_GID}" '/workspace' && \
# Download and install Python via pyenv
    mkdir --parents "/home/${USERNAME}" && \
    git clone --depth 1 --branch "v${PYENV_VERSION}" 'https://github.com/pyenv/pyenv.git' "/home/${USERNAME}/.pyenv" && \
    # --> HERE: We don't want to expand the variable here
    echo 'eval "$(pyenv init --path)"' >> "/home/${USERNAME}/.zshrc" && \
    chown --recursive "${USER_UID}:${USER_GID}" "/home/${USERNAME}/.pyenv"

# Install hadolint
WORKDIR /tmp
RUN --mount=type=tmpfs,target=/tmp \
    curl --fail --location --remote-name "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-$(if test "$(uname -m)" = 'x86_64'; then printf 'x86_64'; else printf 'arm64'; fi)" && \
    mv hadolint-Linux-* '/usr/local/bin/hadolint' && \
    chmod +x '/usr/local/bin/hadolint' && \
# Install LTeX Language Server
    curl --fail --location --remote-name "https://github.com/valentjn/ltex-ls/releases/download/${LTEX_LS_VERSION}/ltex-ls-${LTEX_LS_VERSION}.tar.gz" && \
    tar --extract --file "ltex-ls-${LTEX_LS_VERSION}.tar.gz" && \
    mv "ltex-ls-${LTEX_LS_VERSION}" '/usr/local/bin/ltex-ls'

WORKDIR /

USER $USERNAME

# Install required Python version via pyenv
RUN --mount=type=cache,id=latexworks-devcontainer-pyenv,target=$PYTHON_BUILD_CACHE_PATH,sharing=shared,mode=0755,uid=$USER_UID,gid=$USER_GID \
    eval "$(pyenv init --path)" && \
    env PYTHON_CONFIGURE_OPTS='--enable-optimizations --with-lto' \
        PYTHON_CFLAGS='-march=native -mtune=native' && \
    pyenv install "${PYTHON_VERSION}" && \
    pyenv global "${PYTHON_VERSION}" && \
    pyenv rehash && \
# Install Poetry (https://python-poetry.org/)
    pipx ensurepath && \
    pipx install poetry && \
# Configure Poetry
    poetry config installer.modern-installation true && \
    poetry config installer.parallel true && \
    poetry config solver.lazy-wheel true && \
    poetry config virtualenvs.create true && \
    poetry config virtualenvs.in-project true && \
    poetry config virtualenvs.prefer-active-python true

WORKDIR /workspace
