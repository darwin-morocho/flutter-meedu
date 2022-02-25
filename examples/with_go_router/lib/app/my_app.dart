import 'package:flutter/material.dart';

import 'ui/routes/app_routes.dart';

class MyApp extends StatelessWidget with AppRoutesMixin {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hello world',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
