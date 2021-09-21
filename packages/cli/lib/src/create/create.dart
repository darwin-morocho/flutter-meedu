import 'dart:convert';
import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:cli_menu/cli_menu.dart';
import 'package:meedu_cli/src/initialize/initialize.dart';
import 'package:process_run/shell_run.dart';

class CreateCommand extends Command {
  @override
  String get description =>
      'creates a new flutter project using flutter_meedu as a default state management';

  @override
  String get name => 'create';

  @override
  List<String> get aliases => ['-c'];

  @override
  Future<void> run() async {
    try {
      stdout.write("🔤 Project name: ");
      final projectName = getInput() ?? "";
      if (projectName.contains(" ") && projectName.trim().isNotEmpty) {
        throw Exception("Invalid project name, white spaces are not allowed.");
      }
      if (projectName.trim().isEmpty) {
        throw Exception("Invalid project name");
      }

      stdout.write("\n🔤 organization (default: com.example): ");
      String organization = (getInput() ?? "com.example").trim();
      if (organization.isEmpty) {
        organization = "com.example";
      }

      stdout.writeln("\n✅ Language for Android");
      final menu = Menu(['kotlin', 'java']);
      final androidLanguage = menu.choose().value;

      stdout.writeln("\n✅ Language for iOS");
      final iosMenu = Menu(['swift', 'objc']);
      final iosLanguage = iosMenu.choose().value;

      final command =
          "flutter create --org $organization -a $androidLanguage -i $iosLanguage $projectName";

      final processResult = await Shell().run(command);
      final exitCode = processResult.first.exitCode;
      if (exitCode != 0) {
        throw Exception('"$command" finished with exit code $exitCode.');
      }
      await Shell().run("cd $projectName");
      InitializeCommand(false).run();
    } catch (e) {
      stdout.writeln("❌ $e");
    }
  }
}

String? getInput() {
  return stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);
}
