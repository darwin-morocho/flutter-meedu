import 'package:flutter/material.dart';

import 'ui/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hello world',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: routerProvider.read(),
    );
  }
}
