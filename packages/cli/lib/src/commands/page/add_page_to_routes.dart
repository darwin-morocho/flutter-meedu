import 'dart:io';

import 'package:process_run/shell_run.dart';

import '../../utils/base_path.dart';

Future<void> addPageToRoutes(String pageName, String fileName) async {
  final appDir = '${basePath}lib/app';
  final appRoutesFile = File('$appDir/ui/routes/app_routes.dart');
  final routesFile = File('$appDir/ui/routes/routes.dart');
  if (appRoutesFile.existsSync() && routesFile.existsSync()) {
    /// read the routes.dart file
    final routesCode = routesFile.readAsStringSync();
    if (routesCode.contains("class Routes")) {
      final lastIndex = routesCode.lastIndexOf("}");
      if (lastIndex != -1) {
        final fisrtPart = routesCode.substring(0, lastIndex);
        final secondPart = routesCode.substring(lastIndex, routesCode.length);
        final constName = fileName.toUpperCase();
        final newCode = fisrtPart +
            "static const $constName = '/${fileName.replaceAll("_", "-")}';" +
            secondPart;
        routesFile.writeAsStringSync(newCode);

        /// add the page to the app_routes.dart file

        final appRoutesCode = appRoutesFile.readAsStringSync();
        if (appRoutesCode.contains("get appRoutes")) {
          late int lastAppRoutesIndex;
          if (appRoutesCode.contains("return {")) {
            lastAppRoutesIndex = appRoutesCode.lastIndexOf("};");
          } else {
            lastAppRoutesIndex = appRoutesCode.lastIndexOf("}");
          }

          if (lastAppRoutesIndex != -1) {
            final fisrtPart = appRoutesCode.substring(0, lastAppRoutesIndex);
            final secondPart = appRoutesCode.substring(
                lastAppRoutesIndex, appRoutesCode.length);
            final newCode = """
import '../pages/$fileName/${fileName}_page.dart';
$fisrtPart
    Routes.$constName: (_) => const ${pageName}Page(),
$secondPart
        """;
            appRoutesFile.writeAsStringSync(newCode);
          }

          await Shell().run("flutter format $appDir/ui/routes");
        }
      }
    }
  }
}
