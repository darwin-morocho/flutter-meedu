import 'dart:io';

import '../../utils/base_path.dart';
import 'page.dart' show StringExtension;

void createSimpleNotifierTemplate(String pageName, String fileName) {
  final controllerName = "${pageName}Controller";
  final folder = "${basePath}lib/app/ui/pages/$fileName";
  final controllerFileName = "${fileName}_controller.dart";
  final providerFileName = "${fileName}_provider.dart";
  final pageFileName = "${fileName}_page.dart";

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

  final pageCode = """
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';

import 'controller/$providerFileName';

class ${pageName}Page extends StatelessWidget {
  const ${pageName}Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
  """;
  final pageFile = File(
    '$folder/$pageFileName',
  );

  final providerFile = File(
    '$folder/controller/$providerFileName',
  );

  final controllerFile = File(
    '$folder/controller/$controllerFileName',
  );

  Directory(folder).createSync(recursive: true);
  Directory("$folder/controller").createSync(recursive: true);
  Directory("$folder/widgets").createSync(recursive: true);
  Directory("$folder/utils").createSync(recursive: true);

  pageFile.writeAsStringSync(pageCode);
  controllerFile.writeAsStringSync(controllerCode);
  providerFile.writeAsStringSync(providerCode);

  pageFile.createSync(recursive: true);
  controllerFile.createSync(recursive: true);
  providerFile.createSync(recursive: true);
}
