import 'package:flutter/material.dart';

import 'modules/home/home_page.dart';
import 'modules/numbers/numbers_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
