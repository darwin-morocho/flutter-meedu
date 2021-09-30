A CLI for **flutter_meedu**

> For linux and macOS (not tested on Windows yet, you can try it if you wish) users you can use this CLI to create flutter projects using flutter_meedu, define a clean architecture and create your pages.

## Install
```shell
dart pub global activate meedu_cli
```

or

```shell
flutter pub global activate meedu_cli
```


## Commands
```dart
// To create a flutter project in the current directory
meedu create

// or
meedu -c

// To initialize flutter_meedu in an empty flutter project
meedu init

// or
meedu -i


// To create a new page with the controller and provider following
// the clean architecture proposed by meedu
meedu page

// or 
meedu -p
```
