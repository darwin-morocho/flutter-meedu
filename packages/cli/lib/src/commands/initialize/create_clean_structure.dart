import 'dart:io';

import 'package:meedu_cli/src/utils/create_folder.dart';

import '../../utils/base_path.dart';
import 'generate_test_file.dart';

void createCleanStructure() {
  stderr.writeln("👊 creating clean architecture folder structure");
  if (Directory('${basePath}lib').existsSync()) {
    Directory('${basePath}lib').deleteSync(recursive: true);
  }

  final appDir = '${basePath}lib/app';
  final presentationDir = '$appDir/presentation';
  final modulesDir = '$presentationDir/modules';
  final routesDir = '$presentationDir/routes';

  createFolders(
    [
      '$appDir/data/data_source',
      '$appDir/data/helpers',
      '$appDir/data/repositories_impl',
      '$appDir/domain/models',
      '$appDir/domain/repositories',
      routesDir,
      modulesDir,
      '$presentationDir/global/widgets'
    ],
  );

  final routesFile = File('$routesDir/routes.dart');
  routesFile.writeAsStringSync("""
// ignore_for_file: constant_identifier_names
/// WARNING: generated code don't modify directly
abstract class Routes {
  static const HOME = '/home';
}
    """);
  routesFile.createSync(recursive: true);

  /// create appRoutes Map
  final appRoutesFile = File('$routesDir/app_routes.dart');
  appRoutesFile.writeAsStringSync("""
import 'package:flutter/widgets.dart' show BuildContext, Widget;
import 'routes.dart';
import '../modules/home/view/home_view.dart';

/// WARNING: generated code don't modify directly
Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.HOME: (_) => const HomeView(),
  };
}
    """);
  appRoutesFile.createSync(recursive: true);

  /// create home page demo
  createFolders(
    [
      '$modulesDir/home/controller',
      '$modulesDir/home/utils',
      '$modulesDir/home/view/widgets',
    ],
  );

  final homePageFile = File('$modulesDir/home/view/home_view.dart');
  homePageFile.writeAsStringSync("""
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

import '../controller/home_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
        onPressed: homeProvider.read.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
  """);

  homePageFile.createSync(recursive: true);

  final homeControllerFile = File(
    '$modulesDir/home/controller/home_controller.dart',
  );
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

  final homeProviderFile = File(
    '$modulesDir/home/controller/home_provider.dart',
  );
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
import 'package:flutter_meedu/ui.dart';

import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

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
  generateTestFile();
}
