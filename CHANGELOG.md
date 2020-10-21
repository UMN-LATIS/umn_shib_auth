# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.4.0]

### [Changed]
- Updated to Ruby 2.6.5
  - Updated associated gems to latest versions
- Removed binstubs from gem executables
  - Per [the guides on building gems](https://guides.rubygems.org/make-your-own-gem/#adding-an-executable), executables for a gem should be
  tied to the gem, not general binstubs.  This was generating errors in
  projects that used this gem because of the conflict in executables.

## [2.3.0]

### [Fixed]
- Fix errors with shib attributes that aren't valid Ruby variable names
  - https://github.umn.edu/asrweb/umn_shib_auth/pull/31

### [Added]
- Allow any shib attribute
  - https://github.umn.edu/asrweb/umn_shib_auth/pull/26

## [2.2.0]
## [2.1.1]
## [2.1.0]
## [2.0.5]
## [2.0.4]
## [2.0.3]
## [2.0.2]
## [2.0.1]

[Unreleased]: https://github.umn.edu/asrweb/umn_shib_auth/compare/v2.4.0...master
[2.4.0]: https://github.umn.edu/asrweb/umn_shib_auth/compare/2.3.0...v2.4.0
[2.3.0]: https://github.umn.edu/asrweb/umn_shib_auth/compare/2.2.0...v2.3.0
[2.2.0]: https://github.umn.edu/asrweb/umn_shib_auth/compare/2.1.1...2.2.0
[2.1.1]: https://github.umn.edu/asrweb/umn_shib_auth/compare/2.1.0...2.1.1
[2.1.0]: https://github.umn.edu/asrweb/umn_shib_auth/compare/2.0.5...2.1.0
[2.0.5]: https://github.umn.edu/asrweb/umn_shib_auth/compare/2.0.4...2.0.5
[2.0.4]: https://github.umn.edu/asrweb/umn_shib_auth/compare/2.0.3...2.0.4
[2.0.3]: https://github.umn.edu/asrweb/umn_shib_auth/compare/2.0.2...2.0.3
[2.0.2]: https://github.umn.edu/asrweb/umn_shib_auth/compare/2.0.1...2.0.2
[2.0.1]: https://github.umn.edu/asrweb/umn_shib_auth/compare/15036ff565f75b98a1475e166934367864d9ed4c...2.0.1
