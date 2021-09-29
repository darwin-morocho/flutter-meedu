import 'dart:io';
import 'package:meedu_cli/src/utils/base_path.dart';
import 'package:meedu_cli/src/utils/pubspec.dart';
import 'package:process_run/shell_run.dart';

import 'page.dart' show StringExtension;

Future<void> createStateNotifierTemplate(
    String pageName, String fileName) async {
  final dependencies = pubspec["dependencies"];
  final devDependencies = pubspec["dev_dependencies"];

  final equatable = dependencies['equatable'];
  final freezed = dependencies['freezed'] ?? devDependencies['freezed'];

  final controllerName = "${pageName}Controller";
  final stateName = "${pageName}State";
  final folder = "${basePath}lib/app/ui/pages/$fileName";
  final controllerFileName = "${fileName}_controller.dart";
  final stateFileName = "${fileName}_state.dart";
  final providerFileName = "${fileName}_provider.dart";
  final pageFileName = "${fileName}_page.dart";

  final controllerCode = """
import 'package:flutter_meedu/meedu.dart';
import '$stateFileName';

class $controllerName extends StateNotifier<$stateName> {
  $controllerName():super($stateName.initialState);
}
  """;

  late String stateCode;

  if (equatable == null && freezed == null) {
    stateCode = """
class $stateName {
  static $stateName get initialState => $stateName();
}
""";
  } else if (freezed != null) {
    stateCode = """
import 'package:freezed_annotation/freezed_annotation.dart';
part '${stateFileName.replaceAll(".dart", "")}.freezed.dart';
@freezed
class $stateName with _\$$stateName {
  const $stateName._();
  const factory $stateName() = _$stateName;
  static $stateName get initialState => const $stateName();
}
""";
  } else {
    stateCode = """
import 'package:equatable/equatable.dart';
class $stateName extends Equatable {
  static $stateName get initialState => $stateName();

  @override
  List<Object?> get props => [];
}
""";
  }

  final providerCode = """
import 'package:flutter_meedu/meedu.dart';
import '$controllerFileName';
import '$stateFileName';

final ${pageName.firstLowerCase()}Provider = StateProvider<$controllerName,$stateName>(
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

  final stateFile = File(
    '$folder/controller/$stateFileName',
  );

  Directory(folder).createSync(recursive: true);
  Directory("$folder/controller").createSync(recursive: true);
  Directory("$folder/widgets").createSync(recursive: true);
  Directory("$folder/utils").createSync(recursive: true);

  pageFile.writeAsStringSync(pageCode);
  controllerFile.writeAsStringSync(controllerCode);
  providerFile.writeAsStringSync(providerCode);
  stateFile.writeAsStringSync(stateCode);

  pageFile.createSync(recursive: true);
  controllerFile.createSync(recursive: true);
  providerFile.createSync(recursive: true);
  stateFile.createSync(recursive: true);

  if (freezed != null) {
    await Shell()
        .run("flutter pub run build_runner build --delete-conflicting-outputs");
  }
}
