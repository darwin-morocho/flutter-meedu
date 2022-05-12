import 'package:flutter/material.dart';
import 'app/core/my_http_client.dart';
import 'app/inject_dependencies.dart';
import 'app/my_app.dart';
import 'package:flutter_meedu/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final client = MyHttpClient(
    baseUrl: 'https://reqres.in/',
  );
  injectRepositories(client);
  injectDependencies();
  router.setDefaultTransition(
    Transition.fadeIn,
  );
  runApp(
    const MyApp(),
  );
}
