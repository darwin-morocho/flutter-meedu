import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_menu/cli_menu.dart';
import 'package:meedu_cli/src/utils/add_dependency.dart';
import 'package:meedu_cli/src/utils/pubspec.dart';
import 'package:meedu_cli/src/utils/validate_flutter_project.dart';
import 'package:process_run/shell_run.dart';

import 'create_clean_structure.dart';

class InitializeCommand extends Command<void> {
  static String? projectName;

  InitializeCommand();

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
    try {
      validateFlutterProject();

      final meedu = pubspec["dependencies"]['flutter_meedu'];

      if (meedu == null) {
        final added = await addDependency("flutter_meedu");
        if (!added) {
          throw Exception(
            '❌  flutter_meedu could not be added. Check your internet connection and try again.',
          );
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
            throw Exception(
              '❌  equatable could not be added. Check your internet connection and try again.',
            );
          }
        } else if (result.value == 'freezed') {
          bool added = await addDependency('freezed_annotation');
          if (!added) {
            throw Exception(
              '❌  freezed_annotation could not be added. Check your internet connection and try again.',
            );
          }

          added = await addDependency('freezed', isDev: true);
          if (!added) {
            throw Exception(
              '❌  freezed could not be added. Check your internet connection and try again.',
            );
          }

          if (buildRunner == null) {
            added = await addDependency('build_runner', isDev: true);
            if (!added) {
              throw Exception(
                '❌  build_runner could not be added. Check your internet connection and try again.',
              );
            }
          }
        }
      }

      final processResult = await Shell().run(
        '${projectName != null ? "cd $projectName && " : ""}flutter pub get',
      );
      final exitCode = processResult.first.exitCode;
      if (exitCode != 0) {
        throw Exception(
          '''
❌  "flutter pub get" finished with exit code $exitCode.
If the problem is due to conflics with some packages versions you will need to 
manually fix them in your "pubspec.yaml" and next run this command again.
  ''',
        );
      }

      if (projectName == null) {
        stderr.writeln(
          r'''

      ⚠️  WARNING: you are trying to run the "init" command
      in an existing flutter project this will generate your lib folder again
      and all files inside lib will be deleted.

      ''',
        );
      }

      stderr.writeln(
        r'''

🧐 Create clean architecture folder structure?
      ''',
      );
      final menu = Menu(['Yes', 'No']);
      final result = menu.choose();

      if (result.value == "Yes") {
        createCleanStructure();
      }

      stdout.writeln("""

😃 success. Now you need to go to your pubspec.yaml
and ensure that you are using dart >= 2.13.0

for example:

environment:
  sdk: '>=2.13.0 <3.0.0'
      """);
    } on Exception catch (e) {
      stderr.writeln(e.toString());
    }
  }
}
