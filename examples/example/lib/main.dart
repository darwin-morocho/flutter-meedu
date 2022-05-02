import 'package:flutter/material.dart';
import 'app/inject_dependencies.dart';
import 'app/my_app.dart';
import 'package:flutter_meedu/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  router.setDefaultTransition(
    Transition.fadeIn,
  );
  runApp(const MyApp());
}
