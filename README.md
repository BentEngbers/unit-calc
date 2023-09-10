<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
# Unit-calc 
![format & analyse passing](https://github.com/BentEngbers/unit-calc/actions/workflows/push-checks.yaml/badge.svg?branch=master)
![100% code coverage](https://github.com/BentEngbers/unit-calc/actions/workflows/full-code-coverage.yaml/badge.svg?branch=master)

Perform calculations with numbers, while unit-calc takes care of the units.

# Development
## Dependencies 
There are a few dependencies that this project uses.
Recommended installation is through [Cargo](https://doc.rust-lang.org/stable/cargo/).
- [just](https://github.com/casey/just), to run certain commands 
- [grcov](https://github.com/mozilla/grcov), to aggregates code coverage information.
- [watchexec](https://github.com/watchexec/watchexec), to run commands when file changes.

## Available commands
view the [justfile](./justfile) for a list of available commands.