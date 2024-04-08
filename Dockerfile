# syntax=docker/dockerfile:1
# Define Build Arguments
ARG CREATED
ARG FEDORA_VERSION=39
ARG REVISION
ARG TEXLIVE
ARG VERSION
# Declare the BASE IMAGES - we probably won't use a multi-stage build, but it's a good practice anyway
FROM docker.io/library/fedora:${FEDORA_VERSION} AS base
# --------------------------------------------------------------------------- #
FROM base
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
