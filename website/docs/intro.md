---
sidebar_position: 1
---

# What is meedu?

Is a **powerful** State Management, Dependency Injection, Reactive programming for Flutter apps.

<p align="center">
  <a href="https://pub.dev/packages/flutter_meedu"><img alt="pub version" src="https://img.shields.io/pub/v/flutter_meedu?label=flutter_meedu"/></a>

  <img style={{marginLeft:10}} alt="last commit" src="https://img.shields.io/github/last-commit/darwin-morocho/flutter-meedu"/>
   <a style={{marginLeft:10}} href="https://codecov.io/gh/darwin-morocho/flutter-meedu">
  <img src="https://codecov.io/gh/darwin-morocho/flutter-meedu/branch/master/graph/badge.svg?token=VM29N1NHWJ"/>
  </a>
   <a style={{marginLeft:10}} href="https://discord.gg/rV4bPsdefj">
  <img src="https://img.shields.io/static/v1?label=Discord&message=Server&color=1565c0"/>
  </a>
  <img style={{marginLeft:10}} alt="license" src="https://img.shields.io/github/license/darwin-morocho/flutter-meedu"/>
  <img style={{marginLeft:10}} alt="stars" src="https://img.shields.io/github/stars/darwin-morocho/flutter-meedu?style=social"/>
</p>


:::info INFO
You can join to the discord server [here](https://discord.gg/rV4bPsdefj)
:::


## Features
- A State Management for simple and complex states.

  flutter_meedu helps you to manage the state of your flutter app without boilerplate, code generators or InheritedWidget.

- A simple API for persistent state.

- 100% compatible with any other navigator's package.

- Simple dependecy injection.

- Reactive programming.

- Easy to test.

## Install

Add the following to your `pubspec.yaml`

```yaml
environment:
  sdk: ">=3.3.0 <4.0.0"
  flutter: ">=3.10.0"

dependencies:
  flutter_meedu: ^9.2.0

dev_dependencies:
  meedu_lints: ^0.1.1 # <--- ADD THIS
``` 

Now in your `analysis_options.yaml` enable the custom lints
```yaml
analyzer:
  plugins:
    - custom_lint
```

<!-- :::note
Check the next advanced example using flutter_meedu.

Features:
- Internationalization.
- Dark Mode.
- Clean Architecture.
- Navigator 2 with go_router.
- Nested navigation.
- Deeplinks support.
- Integration with the movie db API.

https://github.com/darwin-morocho/flutter-w2w/tree/meedu
::: -->
