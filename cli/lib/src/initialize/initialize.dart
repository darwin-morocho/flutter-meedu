import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_menu/cli_menu.dart';
import 'package:meedu_cli/src/utils.dart';

import 'create_clean_structure.dart';

class InitializeCommand extends Command<void> {
  InitializeCommand() {}

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
        '❌ pubspec.yaml not found! Make sure you are in the root directory of your app',
      );
      return;
    }

    if (pubspec["dependencies"] == null) {
      stderr.writeln(
        '❌ dependencies bloc not found in your pubspec.yaml',
      );
      return;
    }

    final flutter = pubspec['dependencies']?["flutter"];
    if (flutter == null) {
      stderr.writeln(
        '❌ no flutter project detected',
      );
    }

    final dependency = pubspec["dependencies"]['flutter_meedu'];

    if (dependency == null) {
      final added = await addDependency();
      if (!added) {
        stderr.writeln(
          '❌ flutter_meedu could not be added. Check your internet connection and try again.',
        );
        return;
      }
    }

    stderr.writeln(
      '\n\nCreate clean architecture folder structure? ',
    );
    final menu = Menu(['Yes', 'No']);
    final result = menu.choose();

    if (result.value == "Yes") {
      createCleanStructure();
    }
  }
}
