import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_menu/cli_menu.dart';
import 'package:meedu_cli/src/commands/page/create_page_template.dart';
import 'package:meedu_cli/src/utils/is_old_structure.dart';

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
  List<String> get aliases => ['-p', '-m'];

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

      final folder = isOldStructure()
          ? "${basePath}lib/app/ui/pages/$fileName/view"
          : "${basePath}lib/app/presentation/modules/$fileName/view";
      final pageFileName = "${fileName}_view.dart";

      bool isOverride = false;

      if (File("$folder/$pageFileName").existsSync()) {
        stdout.writeln(
            "\nWARNING: This page already exists. Do you want to override it?");
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
        await createSimpleNotifierTemplate(name, fileName);
      } else if (notifier == 1) {
        await createStateNotifierTemplate(name, fileName);
      } else {
        await createPageTemplate(
          pageName: name,
          fileName: fileName,
        );
      }
      if (!isOverride) {
        await addPageToRoutes(name, fileName);
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
