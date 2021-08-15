import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:meedu_example/navigator_2/router_delegate.dart';

class MyApp2 extends StatelessWidget {
  MyApp2({Key? key}) : super(key: key);

  final _delegate = routerDelegate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: RouteParser(),
      routerDelegate: _delegate,
    );
  }
}
