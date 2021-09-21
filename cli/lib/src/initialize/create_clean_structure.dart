import 'dart:io';

void createCleanStructure() {
  stderr.writeln("👊 creating clean architecture folder structure");
  Directory('lib/app').createSync(recursive: true);
  Directory('lib/app/data/data_source').createSync(recursive: true);
  Directory('lib/app/data/helpers').createSync(recursive: true);
  Directory('lib/app/data/repositories_impl').createSync(recursive: true);
  Directory('lib/app/domain/models').createSync(recursive: true);
  Directory('lib/app/domain/repositories').createSync(recursive: true);
  Directory('lib/app/ui/routes').createSync(recursive: true);
  Directory('lib/app/ui/pages').createSync(recursive: true);
  Directory('lib/app/ui/global_widgets').createSync(recursive: true);

  final routesFile = File('lib/app/ui/routes/routes.dart');
  routesFile.writeAsStringSync("""
// ignore_for_file: constant_identifier_names

abstract class Routes {
  static const HOME = '/home';
}
    """);
  routesFile.createSync(recursive: true);

  /// create appRoutes Map
  final appRoutesFile = File('lib/app/ui/routes/app_routes.dart');
  appRoutesFile.writeAsStringSync("""
import 'package:flutter/widgets.dart' show BuildContext, Widget;
import 'routes.dart';
import '../pages/home/home_page.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.HOME: (_) => const HomePage(),
  };
}
    """);
  appRoutesFile.createSync(recursive: true);

  /// create home page demo
  Directory('lib/app/ui/pages/home/controller').createSync(recursive: true);
  Directory('lib/app/ui/pages/home/utils').createSync(recursive: true);
  Directory('lib/app/ui/pages/home/widgets').createSync(recursive: true);
  Directory('lib/app/ui/pages/home/widgets').createSync(recursive: true);

  final homePageFile = File('lib/app/ui/pages/home/home_page.dart');
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
        onPressed: homeProvider.read.increment,
      ),
    );
  }
}
  """);

  homePageFile.createSync(recursive: true);

  final homeControllerFile = File('lib/app/ui/pages/home/controller/home_controller.dart');
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

  final homeProviderFile = File('lib/app/ui/pages/home/controller/home_provider.dart');
  homeProviderFile.writeAsStringSync("""
import 'package:flutter_meedu/meedu.dart';
import 'home_controller.dart';

final homeProvider = SimpleProvider(
  (_) => HomeController(),
);
  """);

  homeProviderFile.createSync(recursive: true);
}
