import 'dart:io';

import 'package:meedu_cli/src/commands/page/create_page_template.dart';

import 'page.dart' show StringExtension;

Future<void> createSimpleNotifierTemplate(
    String pageName, String fileName) async {
  final controllerName = "${pageName}Controller";
  final controllerFileName = "${fileName}_controller.dart";
  final providerFileName = "${fileName}_provider.dart";

  final controllerCode = """
import 'package:flutter_meedu/meedu.dart';

class $controllerName extends SimpleNotifier {
}
  """;

  final providerCode = """
import 'package:flutter_meedu/meedu.dart';
import '$controllerFileName';

final ${pageName.firstLowerCase()}Provider = SimpleProvider(
  (_) => $controllerName(),
);
  """;

  final folder = await createPageTemplate(
    pageName: pageName,
    fileName: fileName,
    providerFileName: providerFileName,
  );

  final providerFile = File(
    '$folder/controller/$providerFileName',
  );

  final controllerFile = File(
    '$folder/controller/$controllerFileName',
  );

  controllerFile.writeAsStringSync(controllerCode);
  providerFile.writeAsStringSync(providerCode);

  controllerFile.createSync(recursive: true);
  providerFile.createSync(recursive: true);
}
