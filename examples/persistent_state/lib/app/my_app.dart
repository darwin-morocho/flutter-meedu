import 'package:flutter/material.dart';

import 'ui/routes/app_routes.dart';
import 'ui/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello world',
      routes: appRoutes,
      initialRoute: Routes.CITY_PICKER,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
