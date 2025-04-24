# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
but was slightly modified to better match the format of [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

- - -

## [v1.1.0](https://github.com/robinwalterfit/LatexWorks/compare/7b6b3f83b12da077bfd3781988454656a89a8a14...v1.1.0) - 2024-10-27

### Added

#### General changes

- install `ripgrep` in `devcontainer` stage - ([f214729](https://github.com/robinwalterfit/LatexWorks/commit/f214729163c7f862fa9af9331437ef3edcff1cd8)), by [@robinwalterfit](https://github.com/robinwalterfit)

- - -

## [v1.0.0](https://github.com/robinwalterfit/LatexWorks/compare/a2952c8b759c5472fefcbb5e1711a2ddd2217cc2...v1.0.0) - 2024-09-14

### Added

#### General changes

- add `lefthook`, `git-lfs` and make sure `java` is installed correctly - ([f927015](https://github.com/robinwalterfit/LatexWorks/commit/f927015aca2433cf57b6bcaeb85ceef80af5567c)), by [@robinwalterfit](https://github.com/robinwalterfit)

### Changed

#### General changes

- implement `mega-linter` suggestions and remove `MAINTAINER` instructions - ([fe9b787](https://github.com/robinwalterfit/LatexWorks/commit/fe9b7872318e9fbe92e1e3398c1d240c7883d39b)), by [@robinwalterfit](https://github.com/robinwalterfit)

- - -

## [v0.4.0](https://github.com/robinwalterfit/LatexWorks/compare/699e9f152ec68fc95a5eb769f986ea1e5c96e1ab...v0.4.0) - 2024-05-23

### Added

#### docker

- add the python package manager poetry to the devcontainer stage - ([699e9f1](https://github.com/robinwalterfit/LatexWorks/commit/699e9f152ec68fc95a5eb769f986ea1e5c96e1ab)), by [@robinwalterfit](https://github.com/robinwalterfit)

- - -

## [v0.3.0](https://github.com/robinwalterfit/LatexWorks/compare/dba51e020fa7859803e35c73fd9e5e71f0d21bc3...v0.3.0) - 2024-05-04

### Added

#### docker

- install LTeX language server for spell checking of LaTeX files with LanguageTool - ([dba51e0](https://github.com/robinwalterfit/LatexWorks/commit/dba51e020fa7859803e35c73fd9e5e71f0d21bc3)), by [@robinwalterfit](https://github.com/robinwalterfit)

- - -

## [v0.2.0](https://github.com/robinwalterfit/LatexWorks/compare/bbea778622b9ea6ea2ed13707ae500ab3b39af32...v0.2.0) - 2024-04-29

### Added

#### docker

- add additional stage for the use with devcontainers - ([fb4212e](https://github.com/robinwalterfit/LatexWorks/commit/fb4212ed583ef46234b136b75ab4eec2854a4f99)), by [@robinwalterfit](https://github.com/robinwalterfit)

### Changed

#### docker

- bump default Fedora version to 40 - ([4d84f52](https://github.com/robinwalterfit/LatexWorks/commit/4d84f52032c841aa65fd0b69ef5dce03e82792f8)), by [@robinwalterfit](https://github.com/robinwalterfit)
- move environment variables and labels to the base image to not repeat ourselves - ([bbea778](https://github.com/robinwalterfit/LatexWorks/commit/bbea778622b9ea6ea2ed13707ae500ab3b39af32)), by [@robinwalterfit](https://github.com/robinwalterfit)

- - -

## [v0.1.1](https://github.com/robinwalterfit/LatexWorks/compare/66c87a0ae8f02de1960ebae3f717c9c829854b7f...v0.1.1) - 2024-04-08

### Changed

#### docker

- speed up image builds by configuring DNF to keep cache after installation - ([66c87a0](https://github.com/robinwalterfit/LatexWorks/commit/66c87a0ae8f02de1960ebae3f717c9c829854b7f)), by [@robinwalterfit](https://github.com/robinwalterfit)

- - -

## [v0.1.0](https://github.com/robinwalterfit/LatexWorks/compare/f8138724055c3523b884df132ec488608b55fa7b...v0.1.0) - 2024-04-01

### Changed

#### README

- add container usage instructions - ([cd296bb](https://github.com/robinwalterfit/LatexWorks/commit/cd296bb0a051e3fa2e2decf3b6f5c6668475376a)), by [@robinwalterfit](https://github.com/robinwalterfit)
- add missing newline escape `\` in build command - ([86ebf63](https://github.com/robinwalterfit/LatexWorks/commit/86ebf63021bc0e514e9756aa530b584bfe1e519f)), by [@robinwalterfit](https://github.com/robinwalterfit)
- add missing assets for the `README.md` - ([b64dff6](https://github.com/robinwalterfit/LatexWorks/commit/b64dff66a7d173b359dda56d0a0b454bbf660341)), by [@robinwalterfit](https://github.com/robinwalterfit)
