import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_menu/cli_menu.dart';
import 'package:meedu_cli/src/utils.dart';
import 'package:process_run/shell_run.dart';

import 'create_clean_structure.dart';

class InitializeCommand extends Command<void> {
  final bool showQuestionBeforeContinue;

  InitializeCommand(this.showQuestionBeforeContinue);

  @override
  String get description => """
  Install the lastest version of flutter_meedu and initialize a MaterialApp
  """;

  @override
  String get name => 'init';

  @override
  List<String> get aliases => ['-i'];

  @override
  Future<void> run() async {
    /// check if pubspec.yaml exists
    if (!pubspecFile.existsSync()) {
      stderr.writeln(
        '❌  pubspec.yaml not found! Make sure you are in the root directory of your app',
      );
      return;
    }

    if (pubspec["dependencies"] == null) {
      stderr.writeln(
        '❌  dependencies bloc not found in your pubspec.yaml',
      );
      return;
    }

    if (pubspec["dev_dependencies"] == null) {
      stderr.writeln(
        '❌  dev_dependencies bloc not found in your pubspec.yaml',
      );
      return;
    }

    final flutter = pubspec['dependencies']["flutter"];
    if (flutter == null) {
      stderr.writeln(
        '❌  no flutter project detected',
      );
    }

    final meedu = pubspec["dependencies"]['flutter_meedu'];

    if (meedu == null) {
      final added = await addDependency("flutter_meedu");
      if (!added) {
        stderr.writeln(
          '❌  flutter_meedu could not be added. Check your internet connection and try again.',
        );
        return;
      }
    }

    final dependencies = pubspec["dependencies"];
    final devDependencies = pubspec["dev_dependencies"];

    final equatable = dependencies['equatable'];
    final freezed = dependencies['freezed'] ?? devDependencies['freezed'];

    final buildRunner = dependencies['build_runner'] ?? devDependencies['build_runner'];

    if (equatable == null && freezed == null) {
      stderr.writeln(
        '\n\nWhat package do you want to use for your models and immutable states?',
      );
      final menu = Menu(['equatable', 'freezed', 'none']);
      final result = menu.choose();

      if (result.value == 'equatable') {
        final added = await addDependency('equatable');
        if (!added) {
          stderr.writeln(
            '❌  equatable could not be added. Check your internet connection and try again.',
          );
        }
      } else if (result.value == 'freezed') {
        bool added = await addDependency('freezed_annotation');
        if (!added) {
          stderr.writeln(
            '❌  freezed_annotation could not be added. Check your internet connection and try again.',
          );
        }

        added = await addDependency('freezed', isDev: true);
        if (!added) {
          stderr.writeln(
            '❌  freezed could not be added. Check your internet connection and try again.',
          );
        }

        if (buildRunner == null) {
          added = await addDependency('build_runner', isDev: true);
          if (!added) {
            stderr.writeln(
              '❌  build_runner could not be added. Check your internet connection and try again.',
            );
          }
        }
      }
    }

    final processResult = await Shell(verbose: true).run('flutter pub get');
    final exitCode = processResult.first.exitCode;
    if (exitCode != 0) {
      stderr.writeln(
        r'''
❌  "flutter pub get" finished with exit code $exitCode.
If the problem is due to conflics with some packages versions you will need to 
manually fix them in your "pubspec.yaml" and next run this command again.
  ''',
      );
      return;
    }

    stderr.writeln(
      r'''

      ⚠️  WARNING: you are trying to run the "init" command
      in an existing flutter project this will generate your lib folder again
      and all files inside lib will be deleted.

      Create clean architecture folder structure?
      ''',
    );
    final menu = Menu(['Yes', 'No']);
    final result = menu.choose();

    if (result.value == "Yes") {
      createCleanStructure();
    }
  }
}
