import 'package:flutter/material.dart';
import 'package:meedu/router.dart' as router;
import 'modules/home/home_page.dart';
import 'modules/numbers/numbers_page.dart';

void main() {
  router.setDefaultTransition(router.Transition.fadeIn);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: router.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        NumbersPage.routeName: (_) => NumbersPage(),
      },
    );
  }
}
