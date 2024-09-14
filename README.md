<h1 align="center" id="latexworks">LatexWorks</h1>
<p align="center">
  <i>Docker Images that provide LaTeX TeXLive based on Fedora.</i>
  <br/>
  <img width="100" src="./assets/docker-color.svg" style="padding: 0 24px;" />
  <img width="90" src="./assets/fedora-color.svg" style="padding: 0 24px;" />
  <img width="100" src="./assets/latex-color.svg" style="padding: 0 24px;" />
  <br/>
  <b><a href="./wiki/Quickstart">Getting Started</a></b> | <b><a href="https://github.com/robinwalterfit/LatexWorks">GitHub</a></b>
  <br/><br/>
  <a href="https://conventionalcommits.org">
    <img alt="Conventional Commits" src="https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg?style=flat-square" />
  </a>
  <img alt="License MIT or Apache-2.0" src="https://img.shields.io/badge/License-MIT%20or%20Apache%202-green.svg?logo=opensourceinitiative&amp;logoColor=FFFFFF&amp;style=flat-square" />
  <a href="./.github/CODE_OF_CONDUCT.md">
    <img alt="Contributor Covenant" src="https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg?style=flat-square" />
  </a>
  <a href="https://docker.com">
    <img alt="Docker" src="https://img.shields.io/badge/Docker-2496ED?logo=docker&amp;logoColor=white&amp;style=flat-square">
  </a>
  <a href="https://github.com/evilmartians/lefthook">
    <img alt="lefthook" src="https://img.shields.io/badge/lefthook-enabled-brightgreen?logo=data:image/svg+xml;base64,PHN2ZyB3aWR0aD0nNDAwJyBoZWlnaHQ9JzI3MicgeG1sbnM9J2h0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnJz48cGF0aCBmaWxsPScjRkYxRTFFJyBkPSdNMjU4IDI2Mi42TDE0OSAyMTBsLTcyLjQgMjIuM0w1IDE5Ny44bDc2LjctOTguNC0xMy4xLTI0LjVMMTEwLjggMzZsNjUuNC0yLjdMMjUxLjkgNSAzODYuNyAxNTAgMzIzIDI0Ni42eicvPjxwYXRoIGQ9J004My4yIDE2Ni44YzI4LjYgOC42IDU4LjUuNiA4OS45LTI0LjFsMTQ3IDk1LjItMzAgMTguNWgtNDlsLTc3LjUtMzguMi03MC44IDE4LTgwLjQtMzYuNkw2OS43IDE3MGwxMy41LTMuMnptNTItMTEyLjdjMTAuMy0yLjcgMzEuNyAyMi4zIDMyLjcgMjguNCAzLjggMjEuMiA1LjQgMzUuNS0yMC43IDU2LjRhNjkuOCA2OS44IDAgMCAxLTU2LjUgMTUuN2w1LjItMjMuM0w3NyA5My43YTk2LjYgOTYuNiAwIDAgMSA1OC4xLTM5LjZ6JyBmaWxsPScjQkYwMDAwJy8+PHBhdGggZD0nTTkwLjUgMjQzLjZsLTEuNy41TC4zIDIwNC4zbDItNC41YzE0LjEtMzIuNiAzNS02MS4yIDYyLjMtODUuOGEzNjAuNiAzNjAuNiAwIDAgMSAxMS44LTEwLjJsLTQuNi04LjctNS42LTEwLjUtMS44LTMuNS0xLjItMi4zIDEuMS0yLjNjMTIuMy0yNSAzMS41LTM5IDYyLjgtNDcuNSAxOS4xLTUgMzUuMS00LjcgNDggMS40QTI4Ny42IDI4Ny42IDAgMCAxIDI1MS4zLjdsMS0uMiAxNDQuNSAxNTUtMS42IDNhMzE4NCAzMTg0IDAgMCAxLTM3LjQgNzIuNmMtMTcuMyAzMi42LTQ2IDQ0LjQtODMuMyAzOS0yOC00LTU4LjUtMTctOTUtMzcuOGwtMTEtNi4xYy0xNi45IDIuNS00MyA4LjMtNzguMSAxNy40ek03MS4yIDEyMS41YTIzNy4yIDIzNy4yIDAgMCAwLTU3LjcgNzcuN2w2MS4yIDI3LjZhNTE3LjUgNTE3LjUgMCAwIDEgNjIuNS0xOC4zIDI3MjQ0LjggMjcyNDQuOCAwIDAgMC02My42LTM1LjZsLTQuNi0yLjYgMjMuMy0zNi41LTExLjEtMjFhMzUxLjIgMzUxLjIgMCAwIDAtMTAgOC43em0zNy4yIDQ4LjZoLjFjMzcuOC02LjcgNjcuNC0zNi43IDc4LTU1LjdhMjE0LjIgMjE0LjIgMCAwIDAgNS44LTkuMkwyNDQuMSAxM2EyNzQuOCAyNzQuOCAwIDAgMC03NC44IDMyLjRsLTEwLjgtNWEzNzcuMyAzNzcuMyAwIDAgMSA1LjQtMy40IDY4LjIgNjguMiAwIDAgMC0zNC4zIDEuOEMxMDIgNDYuMSA4NS40IDU4IDc0LjQgNzguN2wuNyAxLjIgNS41IDEwLjUgMTkuNiAzN2E1MC40IDUwLjQgMCAwIDAgMTkgLjJjOS42LTEuNCAxOC40LTUgMjUuNS0xMC43IDE0LjEtMTEuNCAyMS42LTIwIDIyLjItMjcuNi43LTktNS4yLTIxLjEtMjEuNy00NC4xIDIzLjMgMTUuNiAzOS4yIDQwLjYgMjYuNCA1OC42di4xYTU3IDU3IDAgMCAxLTQuMyA1LjZjLTQuMiA0LjgtOS4zIDkuNS0xNi4zIDE1LjJhNjMuNCA2My40IDAgMCAxLTMwLjMgMTIuOCA2NiA2NiAwIDAgMS0xOS4xLjNsLTE4LjUgMjlhMjgwNzQuNyAyODA3NC43IDAgMCAxIDQ5LjUgMjcuNnYtLjJjNTEtMi43IDg0LTMzLjYgMTE1LjktODQuMy0yNC40IDUxLjgtNTQuNiA4NS0xMDEuMiA5Mi44IDkuOCA1LjQgMTguNiAxMC40IDI2LjYgMTUgNTAtMy4zIDgwLjItMzAuNyAxMTEuOC04MC45LTI0LjEgNTEuMi01MS45IDgxLjQtOTcgODkuMmE1NTAuNyA1NTAuNyAwIDAgMCAxNC43IDggNzUgNzUgMCAwIDEtLjUtLjUgMjIyLjMgMjIyLjMgMCAwIDAgNS41IDMgNDEwIDQxMCAwIDAgMCA4LjMgNGM0OS44LTMuMiA3Ny42LTI3LjEgMTA5LjItNzcuMy0yMy4yIDQ5LjMtNDggNzYuNS04OS43IDg1IDMwLjUgOSA1NS4yIDMuNSA4MC0xMiA4LjUtNS41IDI4LjktMzQuNSA2MS04Ny4yTDI1My42IDE2LjQgMjAxIDExMC4yYTE3Mi45IDE3Mi45IDAgMCAxLTMwLjEgMzguNCA5NCA5NCAwIDAgMS02Mi40IDIxLjV6JyBmaWxsPScjM0MwMDAwJy8+PC9zdmc+&amp;style=flat-square" />
  </a>
  <a href="https://taskfile.dev/">
    <img alt="Taskfile" src="https://img.shields.io/badge/Taskfile-29BEB0?logo=task&amp;logoColor=white&amp;style=flat-square">
  </a>
  <a href="https://github.com/robinwalterfit/LatexWorks/actions?query=workflow%3AMegaLinter+branch%3Amain">
    <img alt="MegaLinter" src="https://img.shields.io/github/actions/workflow/status/robinwalterfit/LatexWorks/mega-linter.yml?branch=main&amp;event=push&amp;style=flat-square&amp;logo=github&amp;logoColor=white">
  </a>
</p>

<details>
  <summary><b>Table of Contents</b></summary>
  <p>

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
    - [Download and Copy](#download-and-copy)
    - [Git Submodule](#git-submodule)
  - [Usage](#usage)
- [Development](#development)
  - [Build the Project](#build-the-project)
  - [Deployment](#deployment)
  - [Customization](#customization)
  - [Dev Container](#dev-container)
- [Contributing](#contributing)
- [Links](#links)
- [Licenses](#licenses)

</details>

## Getting Started

This project builds Docker Images that provide [$\LaTeX$](https://www.latex-project.org/) [TeX Live](http://www.tug.org/texlive/)
with different predefined packages. All images differentiate in the scheme that
was installed from the fedora `rpm` repository.

Fedora is used as the base image, because it provides a recent TeX Live
distribution without extra configuration necessary and the management and
installation of $\LaTeX$ packages can be done via `dnf`, just like any other
package installation.

If you want to install additional $\LaTeX$ packages with `dnf`, you can do this
with the following command. This for example will install the `beamer` class
and `hyperref` package.

```bash
sudo dnf install --assumeyes 'tex(beamer.cls)'
sudo dnf install --assumeyes 'tex(hyperref.sty)'
```

### Prerequisites

To make use of these images you (of course) need Docker installed on your
machine. You can find instructions on [how to install Docker for your platform](https://docs.docker.com/engine/install/)
according the instructions from this link.

Docker is also necessary if you want to extend these images. Otherwise you
will not be able to build the new images.

### Installation

Currently, these images are not deployed anywhere ([see Deployment for more information](#deployment)).
This means you have to build an image yourself. Some guidance on how to achieve
this will follow:

#### Download and Copy

The most obvious way would be to just download the `Dockerfile` and run the
command from [Build the Project](#build-the-project). Keep in mind you have to
download the `docker-entrypoint.sh` file as well. Otherwise you have to modify
the `Dockerfile`.

Either use the download buttons from the GitHub web application or use e.g.
`curl`.

```bash
curl --fail --location --remote-name 'https://raw.githubusercontent.com/robinwalterfit/LatexWorks/main/Dockerfile'
curl --fail --location --remote-name 'https://raw.githubusercontent.com/robinwalterfit/LatexWorks/main/docker-entrypoint.sh'
```

#### Git Submodule

An alternative way would be to add this repository as a `git` submodule. This
way it will be easier to upgrade when a new release of this repository was
published and you will keep in mind where to look for more information.

```bash
git submodule add --branch main https://github.com/robinwalterfit/LatexWorks.git
```

This will install the repository under a new subdirectory `LatexWorks`. You can
then `cd` into this directory and run the command from [Build the Project](#build-the-project).

### Usage

The image provides a custom entrypoint. In order to use the image, all you have
to do is running `docker run`. Most likely you will want to use `latexmk` to
compile your document. However, you must provide some arguments to the run
command otherwise the compilation will not work. The only necessary arguments are
the volume mount to mount your document sources into the container and the
workspace directory. You should also provide information about your local user,
otherwise the compiled document will belong to `root`.

Run the following command from the root of your project directory:

```bash
docker run --env PUID="$(id -u)" --env PGID="$(id -g)" --interactive --rm --tty --volume "${PWD}:/workspace" --workdir '/workspace' robinwalterfit/latexworks:<scheme>-<fedora-version>-<project-version> latexmk [options] [file ...]
# Or: use docker `--user` argument
docker run --interactive --rm --tty --user "$(id -u)" --volume "${PWD}:/workspace" --workdir '/workspace' robinwalterfit/latexworks:<scheme>-<fedora-version>-<project-version> latexmk [options] [file ...]
```

This will mount your project directory to `/workspace` and tell docker to use
this directory as the workspace folder. The `--rm` flag tells docker to remove
the container as soon as it has finished execution. The environment variables
`PUID` and `PGID` will make sure to drop privileges as well as the `--user`
option and that all commands in the container use the same user id as your
local user. The flags `--interactive` and `--tty` are for interactive mode and
to allocate a pseudo-TTY respectively. This is done, because `latexmk` works
interactively by default. If you do not want to run interactively, you should
use `-interaction=nonstopmode` option of `latexmk`.

If you make use of `latexmkrc` files, then you should make sure they can be
found by `latexmk`. Either add a `.latexmkrc` file to the root of your project
or provide them as an option to the command. But remember: all files not part
of the project must be mounted into the container!

**[⬆️ Back to Top](#latexworks)**

## Development

In order to extend the functionallity of the images you must follow the
[prerequisites](#prerequisites) to install Docker.

It is recommended to use [Visual Studio Code](https://code.visualstudio.com/)
as editor. The repository recommends different VSCode extensions, however, none
of them are required. It is up to you what extensions you use.

There is only one Dockerfile that is used for all images.

### Build the Project

All build commands follow this scheme:

```bash
docker buildx build \
    --build-arg CREATED=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
    --build-arg FEDORA_VERSION=40 \  # Optional
    --build-arg REVISION=$(git log -n 1 --format=%H) \
    --build-arg TEXLIVE=texlive-scheme-<scheme> \
    --build-arg VERSION=<project-version> \
    --target latexworks \  # Comes before the `devcontainer` stage, so make sure to add this target!
    --tag <user/org>/latexworks:<scheme>-<fedora-version>-<project-version> \
    [--tag ... ] \  # Additional tags may be provided
    .  # Context: CWD
```

There are some placeholders used in this command. Let us break this down:

- `<scheme>`: The TeX Live distribution provides different installation
  schemes. The following schemes are available:
  - `basic`: This is the basic TeX Live scheme: it is a small set of files
    sufficient to typeset plain TeX or LaTeX documents in PostScript or PDF,
    using the Computer Modern fonts. This scheme corresponds to
    collection-basic and collection-latex.
  - `context`: This is the TeX Live scheme for installing ConTeXt.
  - `full`: This is the full TeX Live scheme: it installs everything available.
  - `gust`: This is the GUST TeX Live scheme: it is a set of files sufficient
    to typeset Polish plain TeX, LaTeX and ConTeXt documents in PostScript or
    PDF.
  - `medium`: This is the medium TeX Live collection: it contains plain TeX,
    LaTeX, many recommended packages, and support for most European languages.
  - `minimal`: This is the minimal TeX Live scheme, with support for only plain
    TeX. (No LaTeX macros.)  LuaTeX is included because Lua scripts are used in
    TeX Live infrastructure. This scheme corresponds exactly to
    collection-basic.
  - `small`: This is a small TeX Live scheme, corresponding to MacTeX's
    BasicTeX variant. It adds XeTeX, MetaPost, various hyphenations, and some
    recommended packages to scheme-basic.
  - `tetex`: TeX Live scheme nearly equivalent to the teTeX distribution that
    was maintained by Thomas Esser.
- `<user/org>`: The user or organization identifier.
- `<fedora-version>`: The Fedora version of the base image. E.g. at the time of
  writing the most recent stable version available was `40`.
- `<project-version>`: This project itself uses [SemVer](https://semver.org/)
  as versioning scheme. This version should be added to the tag since there
  could be new releases while the Fedora and TeX Live versions stay the same.

**NOTE**: The images should be used as-is. No additional packages should be
installed directly. Checkout [customization](#customization) for more
information on how to install additional packages in smaller images.

However, [`task`](https://taskfile.dev/) can be used to build the images, too.
There are many different tasks that can be found in [`Taskfile.yml`](./Taskfile.yml).
To build a LatexWorks image just invoke one of the available tasks.

### Deployment

Currently none of these images will be deployed to any public registry. Main
reason for this is the size of the images. Even the `minimal` scheme image has
a size of ~2GB. This will definitely exceed [GitHub's Packages Quota](https://docs.github.com/en/billing/managing-billing-for-github-packages/about-billing-for-github-packages).

However, this does not mean you cannot use this project. It simply implies a
simple `docker pull ...` will not be enough. [See the installation instructions](#installation)
for more information on how to use $\LaTeX$Works.

### Customization

If a specific package is needed, that is not available in e.g. `small`, but
using a bigger image with a different scheme is not desirable, then the
installation should be done in the container. This however, is not persistent.
To make it persistent, a new image should be created that uses the `small`
image as its base image.

**[⬆️ Back to Top](#latexworks)**

### Dev Container

The standard image is not optimized for the usage as a Dev Container. This is why
an additional stage called `devcontainer` was introduced. The `devcontainer`
stage uses the `latexworks` stage as its base layer. This way a dev container
will inherit all functionality from the $\LaTeX$Works image, but also include
everything necessary to create a dev container. One very important thing is the
user mapping. Make note of the additional build arguments. Also make sure to
put your code into `/workspace` inside the container.

```bash
docker buildx build \
    --build-arg CREATED=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
    --build-arg FEDORA_VERSION=40 \  # Optional
    --build-arg HADOLINT_VERSION=2.12.0 \  # Optional
    --build-arg LTEX_LS_VERSION=15.2.0 \  # Optional
    --build-arg PYENV_VERSION=2.3.24 \  # Optional
    --build-arg PYTHON_VERSION=3.10.6 \  # Optional
    --build-arg REVISION=$(git log -n 1 --format=%H) \
    --build-arg TEXLIVE=texlive-scheme-<scheme> \
    --build-arg USER_GID="$(id -g)" \
    --build-arg USER_UID="$(id -u)" \
    --build-arg USERNAME="$(id -un)" \
    --build-arg VERSION=<project-version> \
    --target devcontainer \  # Could be omitted
    --tag <user/org>/latexworks-devcontainer:<scheme>-<fedora-version>-<project-version> \
    [--tag ... ] \  # Additional tags may be provided
    .  # Context: CWD
```

There are tasks available to build a dev container image, too.

**[⬆️ Back to Top](#latexworks)**

## Contributing

You want to contribute to $\LaTeX$Works? Great! Please make sure to read
[CONTRIBUTING.md](./CONTRIBUTING.md) first.

**[⬆️ Back to Top](#latexworks)**

## Links

- Project Repository: [https://github.com/robinwalterfit/LatexWorks](https://github.com/robinwalterfit/LatexWorks)
- Issues / Feature Requests: [https://github.com/robinwalterfit/LatexWorks/issues](https://github.com/robinwalterfit/LatexWorks/issues)
- Wiki: [https://github.com/robinwalterfit/LatexWorks/wiki](https://github.com/robinwalterfit/LatexWorks/wiki)
- Additional links:
  - Codeowners Docs: [https://github.blog/2017-07-06-introducing-code-owners/](https://github.blog/2017-07-06-introducing-code-owners/)
  - Collection of `.gitattributes` templates: [https://github.com/gitattributes/gitattributes](https://github.com/gitattributes/gitattributes)
  - Continue: [https://www.continue.dev/](https://www.continue.dev/)
  - Contributor Covenant Code of Conduct: [https://www.contributor-covenant.org](https://www.contributor-covenant.org)
  - Conventional Commits: [https://www.conventionalcommits.org/en/v1.0.0/](https://www.conventionalcommits.org/en/v1.0.0/)
  - Docker: [https://www.docker.com/](https://www.docker.com/)
  - EditorConfig: [https://editorconfig.org/](https://editorconfig.org/)
  - `.gitignore` Generator: [https://gitignore.io](https://gitignore.io)
  - hadolint: [https://hadolint.github.io/hadolint/](https://hadolint.github.io/hadolint/)
  - Lefthook: [https://github.com/evilmartians/lefthook](https://github.com/evilmartians/lefthook)
  - MegaLinter: [https://megalinter.io](https://megalinter.io)
  - README-Template.md: [https://gist.github.com/PurpleBooth/109311bb0361f32d87a2](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
  - Taskfile: [https://taskfile.dev/](https://taskfile.dev/)
  - Visual Studio Code: [https://code.visualstudio.com/](https://code.visualstudio.com/)

**[⬆️ Back to Top](#latexworks)**

## Licenses

Code: &copy; 2024 - Present - Robin Walter &lt;hello@robinwalter.me&gt;.

MIT or Apache-2.0 where applicable.

**[⬆️ Back to Top](#latexworks)**
