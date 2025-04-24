# syntax=docker/dockerfile:1
# Define Build Arguments
ARG FEDORA_VERSION=40 \
    BASEIMAGE="docker.io/library/fedora:${FEDORA_VERSION:-40}"
# Declare the BASE IMAGE
# hadolint ignore=DL3006
FROM "${BASEIMAGE}" AS base
# Define Build Arguments
ARG CREATED \
    FEDORA_VERSION=40 \
    REVISION \
    TEXLIVE \
    VERSION \
    BASEIMAGE="docker.io/library/fedora:${FEDORA_VERSION:-40}"

# Set environment variables
ENV PIP_CACHE_DIR=/var/cache/buildkit/pip

# OCI image annotation
# See: https://snyk.io/de/blog/how-and-when-to-use-docker-labels-oci-container-annotations/
# and: https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.authors="Robin Walter <hello@robinwalter.me>" \
      org.opencontainers.image.base.name="${BASEIMAGE}" \
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
        python3-devel \
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
ARG COCOGITTO_VERSION='6.3.0' \
    CREATED='n/a' \
    FEDORA_VERSION=40 \
    HADOLINT_VERSION=2.12.0 \
    LTEX_LS_VERSION=15.2.0 \
    REVISION='n/a' \
    TARGETPLATFORM \
    TEXLIVE \
    VERSION='devcontainer' \
# User mapping - important for dev containers
    USERNAME=latexworks \
    USER_UID=1000 \
    USER_GID=$USER_UID \
    BASEIMAGE="docker.io/library/fedora:${FEDORA_VERSION:-40}"

# Set environment variables
ENV JAVA_HOME="/etc/alternatives/jre" \
# Add uv and pip user installed packages to PATH
    PATH="/home/${USERNAME}/.local/bin:${PATH}"

LABEL org.opencontainers.image.description="A Docker Image that provides a LaTeX TeX Live (${TEXLIVE}) installation based on Fedora ${FEDORA_VERSION} to be used as a Dev Container." \
      org.opencontainers.image.title="LatexWorks Dev Container"

RUN --mount=type=cache,id=latexworks-devcontainer-dnf,target=/var/cache/dnf,sharing=locked,mode=0755 \
    --mount=type=cache,id=latexworks-devcontainer-dnf-lists,target=/var/lib/dnf,sharing=locked,mode=0755 \
    --mount=type=tmpfs,target=/tmp \
    --mount=type=tmpfs,target=/var/tmp \
# Install lefthook repository
    bash -c \
        "$(curl --fail --location --proto '=https' --show-error --silent --tlsv1.2 'https://dl.cloudsmith.io/public/evilmartians/lefthook/setup.rpm.sh')" && \
# Install Git LFS repository
    bash -c \
        "$(curl --fail --location --proto '=https' --show-error --silent --tlsv1.2 'https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh')" && \
    dnf groupinstall --assumeyes --setopt=install_weak_deps=False --setopt=keepcache=True \
        'Development Tools' \
        'Development Libraries' && \
    dnf install --assumeyes --setopt=install_weak_deps=False --setopt=keepcache=True \
        clang \
        gcc \
        git-lfs \
        java-17-openjdk \
        lefthook \
        man \
        man-pages \
        nano \
        oniguruma \
        oniguruma-devel \
        pipx \
        procps-ng \
        ripgrep \
        shellcheck \
        sudo \
        zsh && \
# Add non-root user
    # Check if group exists or create it if not
    if ! getent group "${USER_GID}" >/dev/null 2>&1; then \
        groupadd --gid "${USER_GID}" "${USERNAME}"; \
    fi && \
    # Check if user exists or create it if not
    if ! id "${USER_UID}" >/dev/null 2>&1; then \
        useradd \
            --comment '' \
            --create-home \
            --gid "${USER_GID}" \
            --groups 'wheel' \
            --home-dir "/home/${USERNAME}" \
            --shell '/usr/bin/zsh' \
            --uid "${USER_UID}" \
            "${USERNAME}"; \
    else \
        usermod \
            --append \
            --comment \
            --gid "${USER_GID}" \
            --groups 'wheel' \
            --home "/home/${USERNAME}" \
            --login "${USERNAME}" \
            --move-home \
            --shell '/usr/bin/zsh' \
            "${USERNAME}" && \
        # Make sure the ownership of the home directory is correct
        chown --recursive "${USER_UID}:${USER_GID}" "/home/${USERNAME}"; \
    fi && \
    echo "${USERNAME} ALL=(root) NOPASSWD: ALL" > "/etc/sudoers.d/${USERNAME}" && \
    chmod u=r,g=r,o= "/etc/sudoers.d/${USERNAME}" && \
# Create the cache and workspace directories
    mkdir --parents '/workspace' && \
    chown --recursive "${USER_UID}:${USER_GID}" "${PIP_CACHE_DIR}" && \
    chown --recursive "${USER_UID}:${USER_GID}" '/workspace' && \
# Install cocogitto
    cocogitto_dir='' && \
    cocogitto_url='' && \
    if [ "${TARGETPLATFORM}" = 'linux/arm64' ] || [ "${TARGETPLATFORM}" = 'linux/arm64/v8' ]; then \
        cocogitto_dir='aarch64-unknown-linux-gnu' && \
        cocogitto_url="https://github.com/cocogitto/cocogitto/releases/download/${COCOGITTO_VERSION}/cocogitto-${COCOGITTO_VERSION}-${cocogitto_dir}.tar.gz"; \
    elif [ "${TARGETPLATFORM}" = 'linux/arm/v7' ]; then \
        cocogitto_dir='armv7-unknown-linux-musleabihf' && \
        cocogitto_url="https://github.com/cocogitto/cocogitto/releases/download/${COCOGITTO_VERSION}/cocogitto-${COCOGITTO_VERSION}-${cocogitto_dir}.tar.gz"; \
    elif [ "${TARGETPLATFORM}" = 'linux/amd64' ]; then \
        cocogitto_dir='x86_64-unknown-linux-musl' && \
        cocogitto_url="https://github.com/cocogitto/cocogitto/releases/download/${COCOGITTO_VERSION}/cocogitto-${COCOGITTO_VERSION}-${cocogitto_dir}.tar.gz"; \
    else \
        echo "Target platform '${TARGETPLATFORM}' is not supported by cocogitto" && \
        exit 1; \
    fi && \
    bash -c "tar --directory '/usr/local/bin' --extract --file=- --gzip < <(curl --fail --location --proto '=https' --show-error --silent --tlsv1.2 ${cocogitto_url})" && \
    chown --recursive 'root:root' "/usr/local/bin/${cocogitto_dir}" && \
    mv "/usr/local/bin/${cocogitto_dir}/cog" '/usr/local/bin/cog' && \
    rm --force --recursive "/usr/local/bin/${cocogitto_dir}" && \
# Install Taskfile
    bash -c \
        "$(curl --fail --location --proto '=https' --show-error --silent --tlsv1.2 https://taskfile.dev/install.sh)" \
        -- \
        -d \
        -b '/usr/local/bin' && \
# Install hadolint
    hadolint_url='' && \
    if [ "${TARGETPLATFORM}" = 'linux/arm64' ] || [ "${TARGETPLATFORM}" = 'linux/arm64/v8' ]; then \
        hadolint_url="https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-arm64"; \
    elif [ "${TARGETPLATFORM}" = 'linux/amd64' ]; then \
        hadolint_url="https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64"; \
    else \
        echo "Target platform '${TARGETPLATFORM}' is not supported by cocogitto" && \
        exit 1; \
    fi && \
    curl --fail --location --proto '=https' --remote-name --show-error --silent --tlsv1.2 "${hadolint_url}" && \
    mv hadolint-Linux-* '/usr/local/bin/hadolint' && \
    chmod +x '/usr/local/bin/hadolint' && \
# Install LTeX Language Server
    ltex_url="https://github.com/valentjn/ltex-ls/releases/download/${LTEX_LS_VERSION}/ltex-ls-${LTEX_LS_VERSION}.tar.gz" && \
    bash -c "tar --directory '/usr/local/bin' --extract --file=- --gzip < <(curl --fail --location --proto '=https' --show-error --silent --tlsv1.2 ${ltex_url})" && \
    mv "/usr/local/bin/ltex-ls-${LTEX_LS_VERSION}" '/usr/local/bin/ltex-ls'

USER "$USERNAME"

# Install Python package and version manager uv
RUN --mount=type=tmpfs,target=/tmp \
    --mount=type=tmpfs,target=/var/tmp \
# Ensure directories for user-only binaries exist
    mkdir --parents "/home/${USERNAME}/.local/bin" && \
    bash -c "$(curl --fail --location --proto '=https' --show-error --silent --tlsv1.2 'https://astral.sh/uv/install.sh')" -- --no-modify-path

WORKDIR /workspace
