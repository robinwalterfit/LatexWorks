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
- [Development](#development)
  - [Build the Project](#build-the-project)
  - [Deployment](#deployment)
  - [Customization](#customization)
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

TODO(hello@robinwalter.me): Add installation instructions as soon as the first image version is published.

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
    --build-arg TEXLIVE=texlive-scheme-<scheme>-<texlive-version> \
    --build-arg REVISION=$(git log -n 1 --format=%H) \
    -t <user/org>/latexworks:<scheme>-<fedora-version>.<texlive-version>-<project-version>
    [-t ...]  # Additional tags may be provided
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
- `<texlive-version>`: The Tex Live distribution version. E.g. at the time of
  writing the most recent version available for Fedora was `2023-69`.
- `<user/org>`: The user or organization identifier.
- `<fedora-version>`: The Fedora version of the base image. E.g. at the time of
  writing the most recent stable version available was `39`.
- `<project-version>`: This project itself uses [SemVer](https://semver.org/)
  as versioning scheme. This version should be added to the tag since there
  could be new releases while the Fedora and TeX Live versions stay the same.

**NOTE**: The images should be used as-is. No additional packages should be
installed directly. Checkout [customization](#customization) for more
information on how to install additional packages in smaller images.

### Deployment

TODO(hello@robinwalter.me): Add deployment instructions as soon as the first image version is published.

### Customization

If a specific package is needed, that is not available in e.g. `small`, but
using a bigger image with a different scheme is not desirable, then the
installation should be done in the container. This however, is not persistent.
To make it persistent, a new image should be created that uses the `small`
image as its base image.

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
