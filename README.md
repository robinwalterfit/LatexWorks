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
  <a href="https://commitizen-tools.github.io/commitizen/">
    <img alt="Commitizen friendly" src="https://img.shields.io/badge/commitizen-friendly-brightgreen.svg?style=flat-square" />
  </a>
  <a href="https://conventionalcommits.org">
    <img alt="Conventional Commits" src="https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg?style=flat-square" />
  </a>
  <img alt="License MIT or Apache-2.0" src="https://img.shields.io/badge/License-MIT%20or%20Apache%202-green.svg?logo=opensourceinitiative&amp;logoColor=FFFFFF&amp;style=flat-square" />
  <a href="./.github/CODE_OF_CONDUCT.md">
    <img alt="Contributor Covenant" src="https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg?style=flat-square" />
  </a>
  <a href="https://github.com/pre-commit/pre-commit">
    <img alt="pre-commit" src="https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&amp;logoColor=white&amp;style=flat-square" />
  </a>
  <a href="https://github.com/robinwalterfit/LatexWorks">
    <img alt="website" src="https://img.shields.io/badge/website-LatexWorks-green.svg?style=flat-square" />
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
  - [Devcontainer](#devcontainer)
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
sudo dnf install 'tex(beamer.cls)'
sudo dnf install 'tex(hyperref.sty)'
```

### Prerequisites

To make use of these images you (of course) need Docker installed on your
machine. You can find instructions on [how to install Docker for your platform](https://docs.docker.com/engine/install/)
according the instructions from this link.

Docker is also necessary if you want to extend these images. Otherwise you
won't be able to build the new images.

### Installation

Currently, these images aren't deployed anywhere ([see Deployment for more information](#deployment)).
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
curl -OL https://raw.githubusercontent.com/robinwalterfit/LatexWorks/main/Dockerfile
curl -OL https://raw.githubusercontent.com/robinwalterfit/LatexWorks/main/docker-entrypoint.sh
```

#### Git Submodule

An alternative way would be to add this repository as a `git` submodule. This
way it will be easier to upgrade when a new release of this repository was
published and you will keep in mind where to look for more information.

```bash
git submodule add https://github.com/robinwalterfit/LatexWorks.git
```

This will install the repository under a new subdirectory `LatexWorks`. You can
then `cd` into this directory and run the command from [Build the Project](#build-the-project).

### Usage

The image provides a custom entrypoint. In order to use the image, all you have
to do is running `docker run`. Most likely you will want to use `latexmk` to
compile your document. However, you must provide some arguments to the run
command otherwise the compilation won't work. The only necessary arguments are
the volume mount to mount your document sources into the container and the
workspace directory. You should also provide information about your local user,
otherwise the compiled document will belong to `root`.

Run the following command from the root of your project directory:

```bash
docker run -e PUID=$(id -u) -e PGID=$(id -g) --rm -v "${PWD}:/workspace" -w "/workspace" robinwalterfit/latexworks:<scheme>-<fedora-version>-<project-version> latexmk [options] [file ...]
# Or: use docker `--user` argument
docker run --rm --user $(id -u) -v "${PWD}:/workspace" -w "/workspace" robinwalterfit/latexworks:<scheme>-<fedora-version>-<project-version> latexmk [options] [file ...]
```

This will mount your project directory to `/workspace` and tell docker use this
directory as the workspace folder. The `--rm` flag tells docker to remove the
container as soon as it has finished execution. The environment variables
`PUID` and `PGID` will make sure to drop privileges as well as the `--user`
option and that all commands in the container use the same user id as your
local user.

If you make use of `latexmkrc` files, then you should make sure they can be
found by `latexmk`. Either add a `.latexmkrc` file to the root of your project
or provide them as an option to the command. But remember: all files not part
of project must be mounted into the container!

**[⬆️ Back to Top](#latexworks)**

## Development

In order to extend the functionallity of the images you must follow the
[prerequisites](#prerequisites) to install Docker.

It is recommended to use [Visual Studio Code](https://code.visualstudio.com/)
as editor. The repository recommends different VSCode extensions, however, none
of them is required. It is up to you what extensions you use.

There is only one Dockerfile that is used for all images.

### Build the Project

Currently, no fancy build tool is used. All build commands must be invoked by
hand. All commands follow this scheme:

```bash
docker buildx build \
    --build-arg CREATED=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
    --build-arg FEDORA_VERSION=40 \  # Optional
    --build-arg REVISION=$(git log -n 1 --format=%H) \
    --build-arg TEXLIVE=texlive-scheme-<scheme> \
    --build-arg VERSION=<project-version> \
    --target latexworks \  # Comes before the `devcontainer` stage, so make sure to add this target!
    -t <user/org>/latexworks:<scheme>-<fedora-version>-<project-version> \
    [-t ... ] \  # Additional tags may be provided
    .  # Context: CWD
```

There are some placeholders used in this command. Let's break this down:

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

### Deployment

Currently none of these images will be deployed to any public registry. Main
reason for this is the size of the images. Even the `minimal` scheme image has
a size of ~2GB. This will definitely exceed [GitHub's Packages Quota](https://docs.github.com/en/billing/managing-billing-for-github-packages/about-billing-for-github-packages).

However, this doesn't mean you can't use this project. It simply implies a
simple `docker pull ...` won't be enough. [See the installation instructions](#installation)
for more information on how to use $\LaTeX$Works.

### Customization

If a specific package is needed, that is not available in e.g. `small`, but
using a bigger image with a different scheme is not desirable, then the
installation should be done in the container. This however, is not persistent.
To make it persistent, a new image should be created that uses the `small`
image as its base image.

**[⬆️ Back to Top](#latexworks)**

### Devcontainer

The standard image isn't optimized for the usage as a Devcontainer. This is why
an additional stage called `devcontainer` was introduced. The `devcontainer`
stage uses the `latexworks` stage as its base layer. This way a devcontainer
will inherit all functionality from the $\LaTeX$Works image, but also include
everything necessary to create a devcontainer. One very important thing is the
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
    -t <user/org>/latexworks-devcontainer:<scheme>-<fedora-version>-<project-version> \
    [-t ... ] \  # Additional tags may be provided
    .  # Context: CWD
```

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
  - Collection of `.gitattributes` templates: [https://github.com/gitattributes/gitattributes](https://github.com/gitattributes/gitattributes)
  - Commitizen: [https://commitizen-tools.github.io/commitizen/](https://commitizen-tools.github.io/commitizen/)
  - Commitlint: [https://commitlint.js.org/](https://commitlint.js.org/)
  - Conventional Commits: [https://www.conventionalcommits.org/en/v1.0.0/](https://www.conventionalcommits.org/en/v1.0.0/)
  - Docker: [https://www.docker.com/](https://www.docker.com/)
  - EditorConfig: [https://editorconfig.org/](https://editorconfig.org/)
  - `.gitignore` Generator: [https://gitignore.io](https://gitignore.io)
  - hadolint: [https://hadolint.github.io/hadolint/](https://hadolint.github.io/hadolint/)
  - pre-commit: [https://pre-commit.com/](https://pre-commit.com/)
  - README-Template.md: [https://gist.github.com/PurpleBooth/109311bb0361f32d87a2](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
  - Visual Studio Code: [https://code.visualstudio.com/](https://code.visualstudio.com/)

**[⬆️ Back to Top](#latexworks)**

## Licenses

Code: &copy; 2024 - Present - Robin Walter &lt;hello@robinwalter.me&gt;.

MIT or Apache-2.0 where applicable.

**[⬆️ Back to Top](#latexworks)**
