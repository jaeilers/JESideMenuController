# Changelog

All important changes in this project are tracked in this document.  
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Documenting changes in CHANGELOG file.
- Increased code coverage.
- Feature to enable/disable scolling
- Added functionality to adjust the side menu configuration. (spacing, iPad menu width, drop shadow image, tintColor etc.)
- Added Dark Mode support

### Changed
- Improved example application.
- Switched from Travis-CI to github actions.
- Require minimum target iOS 15
- Updated example project
- Added @MainActor annotation and Sendable conformance

### Fixed
- Rewording of description and fix typos in README.
- Fixed a bug where the slide-in edge gesture recognizer would block the recognition of `UINavigationControllers` back swipe.

## [1.0.0] - 2019-07-26
### Added
- Initial release of JESideMenuController.

[Unreleased]: https://github.com/jaeilers/JESideMenuController/compare/1.0.0...HEAD
[1.0.0]: https://github.com/jaeilers/JESideMenuController/releases/tag/1.0.0
