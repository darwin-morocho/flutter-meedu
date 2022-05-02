import 'dart:io';

import 'package:meedu_cli/src/utils/base_path.dart';

Future<String> createPageTemplate({
  required String pageName,
  required String fileName,
  String? providerFileName,
}) async {
  final folder = "${basePath}lib/app/ui/pages/$fileName";
  final pageFileName = "${fileName}_page.dart";

  final addProviderCode = providerFileName != null;

  final pageCode = """
import 'package:flutter/material.dart';
${addProviderCode ? "import 'package:flutter_meedu/ui.dart';" : ""}
${addProviderCode ? "import 'controller/$providerFileName';" : ""}

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

  Directory(folder).createSync(recursive: true);
  if (addProviderCode) {
    Directory("$folder/controller").createSync(recursive: true);
  }
  Directory("$folder/widgets").createSync(recursive: true);
  Directory("$folder/utils").createSync(recursive: true);
  pageFile.writeAsStringSync(pageCode);
  pageFile.createSync(recursive: true);

  return folder;
}
