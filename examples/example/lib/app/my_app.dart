import 'package:flutter/material.dart';

import 'ui/routes/app_routes.dart';
import 'ui/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    this.routes,
    this.initialRoute,
  }) : super(key: key);

  final Map<String, Widget Function(BuildContext)>? routes;
  final String? initialRoute;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'Hello world',
        routes: routes ?? appRoutes,
        initialRoute: initialRoute ?? Routes.SPLASH,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
