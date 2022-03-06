import 'package:flutter/material.dart';
import 'package:persistent_state/app/inject_dependencies.dart';
import 'app/my_app.dart';

void main() async {
  await injectDependencies();
  runApp(const MyApp());
}
