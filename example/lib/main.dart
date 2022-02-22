import 'package:flutter/material.dart';
import 'app/inject_dependencies.dart';
import 'app/my_app.dart';
import 'package:flutter_meedu/router.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  router.setDefaultTransition(
    router.Transition.fadeIn,
  );
  runApp(const MyApp());
}
