import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_menu/cli_menu.dart';

import '../../utils/base_path.dart';
import '../../utils/validate_flutter_project.dart';
import '../../utils/validator.dart';
import '../create/create.dart';
import '../page/simple_notifier_template.dart';
import 'add_page_to_routes.dart';
import 'state_notifier_template.dart';

class PageCommand extends Command {
  @override
  String get description =>
      'Creates a new page using a SimpleNotifier or a StateNotifier,'
      ' also create the provider attached to the controller.';

  @override
  String get name => 'page';

  @override
  List<String> get aliases => ['-p'];

  @override
  Future<void> run() async {
    try {
      validateFlutterProject();
      stdout
          .write("🔤 Page name (use spaces for names with multiples worlds): ");

      String name = getInput() ?? "";
      if (name.contains("-")) {
        throw Exception(
            "Invalid name, '-' and special characters are not allowed.");
      }
      if (name.trim().isEmpty) {
        throw Exception("Invalid name");
      }

      if (containsSpecialCharacter(name)) {
        throw Exception("Special Character are not allowed");
      }

      final splits = name.split(" ");
      name = "";
      String fileName = "";
      for (final e in splits) {
        fileName += "_${e.toLowerCase()}";
        name += e.capitalize();
      }
      fileName = fileName.substring(1, fileName.length);

      final folder = "${basePath}lib/app/ui/pages/$fileName";
      final pageFileName = "${fileName}_page.dart";

      bool isOverride = false;

      if (File("$folder/$pageFileName").existsSync()) {
        stdout.writeln(
            "\n⚠️  This page already exists. Do you want to override it?");
        final menu = Menu(['Yes', 'No']);
        if (menu.choose().index == 1) {
          return;
        }
        isOverride = true;
      }

      stdout.writeln("\n✅ Create a controller and a provider using");
      final menu = Menu(['SimpleNotifier', 'StateNotifier', 'none']);
      final notifier = menu.choose().index;

      /// if the developer want to use a StateNotifier
      if (notifier == 0) {
        createSimpleNotifierTemplate(name, fileName);
      } else if (notifier == 1) {
        await createStateNotifierTemplate(name, fileName);
      }
      if (!isOverride) {
        addPageToRoutes(name, fileName);
      }
    } catch (e) {
      stdout.writeln("❌ $e");
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String firstLowerCase() {
    return "${this[0].toLowerCase()}${substring(1)}";
  }
}
