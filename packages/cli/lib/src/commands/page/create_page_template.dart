import 'dart:io';

import 'package:meedu_cli/src/utils/base_path.dart';
import 'package:meedu_cli/src/utils/is_old_structure.dart';

Future<String> createPageTemplate({
  required String pageName,
  required String fileName,
  String? providerFileName,
}) async {
  final folder = isOldStructure()
      ? "${basePath}lib/app/ui/pages/$fileName"
      : "${basePath}lib/app/presentation/modules/$fileName";
  final pageFileName = "/view/${fileName}_view.dart";

  final addProviderCode = providerFileName != null;

  final pageCode = """
import 'package:flutter/material.dart';
${addProviderCode ? "import 'package:flutter_meedu/ui.dart';" : ""}
${addProviderCode ? "import '../controller/$providerFileName';" : ""}

class ${pageName}View extends StatelessWidget {
  const ${pageName}View({Key? key}) : super(key: key);

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
  Directory("$folder/view/widgets").createSync(recursive: true);
  Directory("$folder/utils").createSync(recursive: true);
  pageFile.writeAsStringSync(pageCode);
  pageFile.createSync(recursive: true);

  return folder;
}
