import 'dart:io';

import '../../utils/base_path.dart';
import '../../utils/pubspec.dart';

void createCleanStructure() {
  stderr.writeln("👊 creating clean architecture folder structure");
  if (Directory('${basePath}lib').existsSync()) {
    Directory('${basePath}lib').deleteSync(recursive: true);
  }

  final appDir = '${basePath}lib/app';

  Directory(appDir).createSync(recursive: true);
  Directory('$appDir/data/data_source').createSync(recursive: true);
  Directory('$appDir/data/helpers').createSync(recursive: true);
  Directory('$appDir/data/repositories_impl').createSync(recursive: true);
  Directory('$appDir/domain/models').createSync(recursive: true);
  Directory('$appDir/domain/repositories').createSync(recursive: true);
  Directory('$appDir/ui/routes').createSync(recursive: true);
  Directory('$appDir/ui/pages').createSync(recursive: true);
  Directory('$appDir/ui/global_widgets').createSync(recursive: true);

  final routesFile = File('$appDir/ui/routes/routes.dart');
  routesFile.writeAsStringSync("""
// ignore_for_file: constant_identifier_names
/// WARNING: generated code don't modify directly
abstract class Routes {
  static const HOME = '/home';
}
    """);
  routesFile.createSync(recursive: true);

  /// create appRoutes Map
  final appRoutesFile = File('$appDir/ui/routes/app_routes.dart');
  appRoutesFile.writeAsStringSync("""
import 'package:flutter/widgets.dart' show BuildContext, Widget;
import 'routes.dart';
import '../pages/home/home_page.dart';

/// WARNING: generated code don't modify directly
Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.HOME: (_) => const HomePage(),
  };
}
    """);
  appRoutesFile.createSync(recursive: true);

  /// create home page demo
  Directory('$appDir/ui/pages/home/controller').createSync(recursive: true);
  Directory('$appDir/ui/pages/home/utils').createSync(recursive: true);
  Directory('$appDir/ui/pages/home/widgets').createSync(recursive: true);
  Directory('$appDir/ui/pages/home/widgets').createSync(recursive: true);

  final homePageFile = File('$appDir/ui/pages/home/home_page.dart');
  homePageFile.writeAsStringSync("""
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';

import 'controller/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (_, ref, __) {
            final controller = ref.watch(homeProvider);
            return Text("\${controller.counter}");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: homeProvider.read.increment,
      ),
    );
  }
}
  """);

  homePageFile.createSync(recursive: true);

  final homeControllerFile =
      File('$appDir/ui/pages/home/controller/home_controller.dart');
  homeControllerFile.writeAsStringSync("""
import 'package:flutter_meedu/meedu.dart';

class HomeController extends SimpleNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notify();
  }
}
  """);

  homeControllerFile.createSync(recursive: true);

  homePageFile.createSync(recursive: true);

  final homeProviderFile =
      File('$appDir/ui/pages/home/controller/home_provider.dart');
  homeProviderFile.writeAsStringSync("""
import 'package:flutter_meedu/meedu.dart';
import 'home_controller.dart';

final homeProvider = SimpleProvider(
  (_) => HomeController(),
);
  """);

  homeProviderFile.createSync(recursive: true);

  final mainFile = File('${basePath}lib/main.dart');
  mainFile.writeAsStringSync("""
import 'package:flutter/material.dart';
import 'app/my_app.dart';

void main() {
  runApp(const MyApp());
}
  """);

  mainFile.createSync(recursive: true);

  final myAppFile = File('$appDir/my_app.dart');
  myAppFile.writeAsStringSync("""
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;

import 'ui/routes/app_routes.dart';
import 'ui/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: router.appKey,
      title: 'Hello world',
      navigatorKey: router.navigatorKey,
      navigatorObservers: [
        router.observer,
      ],
      routes: appRoutes,
      initialRoute: Routes.HOME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
  """);

  myAppFile.createSync(recursive: true);
  _generateTestFile();
}

void _generateTestFile() {
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
