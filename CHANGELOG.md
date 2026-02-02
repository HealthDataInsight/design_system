# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Updated NHSUK to 10.3.1

### Added

- Added action link.
- Added `back_link` to fixed elements 

## [0.11.0] - 2026-01-16

### Changed

- `ds_alert` and `ds_notice` now accept block content for complex HTML, in addition to plain text strings
- String parameters to `ds_alert` and `ds_notice` are now treated as plain text (no HTML processing)

## [0.10.0] - 2026-01-07

### Added

- Added details component.

## [0.9.5] - 2025-12-15

## Fixed

- Check that the consuming app is using importmap before configuring it

## [0.9.4] - 2025-12-09

## Fixed

- Load the Branded concern before each request (in development)

## [0.9.3] - 2025-10-13

## Fixed

- Reverting the ignoring of all.rb autoloading via Zeitwerk.

## [0.9.2] - 2025-10-08

## Fixed

- Adding a stub class for all.rb to make zeitwerk happy

## [0.9.1] - 2025-10-08

### Fixed

- Fixed Zeitwerk on_file_autoloaded issue for all.rb (by adding it to ignore list)

## [0.9.0] - 2025-10-06

### Changed

- Updated the inclusive language workflow, rubocop fixes and YAML linting
- Changed NHSUK search bar visibility depending on setting of @searchbar_url

### Added

- Added rake task to deploy_to_rubygems
- Added searchbar to govuk header , adapting logic from nhsuk search bar

## [0.8.1] - 2025-09-04

### Fixed

- Built the missing static JavaScript asset
- Made the build (rake) task less brittle

## [0.8.0] - 2025-09-04

### Added

- Added the ability to manage footer links and copyright notice

### Fixed

- Cleaned up require calls with Zeitwerk
- DRYed up use of the CssHelper and moved it under the DesignSystem namespace
- Moved GOVUK test helpers under the DesignSystem namespace for reuse in plugins

## [0.7.0] - 2025-08-22

### Added

- Added a registry for specific design system (known as brand) adapters
- Builders for buttons, breadcrumbs, callouts, headings, links, pagination, etc
- Components for summary lists, tabs and tables
- Added Cypress for end-to-end testing
- Added FormBuilders to with Rails signatures (where possible)
- Supports multiple layouts

[unreleased]: https://github.com/HealthDataInsight/design_system/compare/v0.11.0...HEAD
[0.11.0]: https://github.com/HealthDataInsight/design_system/compare/v0.10.0...v0.11.0
[0.10.0]: https://github.com/HealthDataInsight/design_system/compare/v0.9.5...v0.10.0
[0.9.5]: https://github.com/HealthDataInsight/design_system/compare/v0.9.4...v0.9.5
[0.9.4]: https://github.com/HealthDataInsight/design_system/compare/v0.9.3...v0.9.4
[0.9.3]: https://github.com/HealthDataInsight/design_system/compare/v0.9.2...v0.9.3
[0.9.2]: https://github.com/HealthDataInsight/design_system/compare/v0.9.1...v0.9.2
[0.9.1]: https://github.com/HealthDataInsight/design_system/compare/v0.9.0...v0.9.1
[0.9.0]: https://github.com/HealthDataInsight/design_system/compare/v0.8.1...v0.9.0
[0.8.1]: https://github.com/HealthDataInsight/design_system/compare/v0.8.0...v0.8.1
[0.8.0]: https://github.com/HealthDataInsight/design_system/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/HealthDataInsight/design_system/releases/tag/v0.7.0
