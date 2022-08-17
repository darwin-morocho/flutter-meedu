import 'dart:io';

import '../../utils/base_path.dart';
import '../../utils/pubspec.dart';

void generateTestFile() {
  if (!Directory('${basePath}test').existsSync()) {
    Directory('${basePath}test').createSync(recursive: true);
  }

  final projectName = pubspec['name'];
  if (projectName == null) {
    return;
  }
  final file = File('${basePath}test/widget_test.dart');
  file.writeAsStringSync("""
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:$projectName/app/my_app.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
  """);
  file.createSync(recursive: true);

  final gitignoreFile = File("$basePath/.gitignore");
  if (gitignoreFile.existsSync()) {
    final gitignoreCode = gitignoreFile.readAsStringSync();
    gitignoreFile.writeAsStringSync("""
$gitignoreCode
*.freezed.dart
    """);
  }
  stderr.writeln("😎 clean architecture structure generated");
}
