import 'package:flutter/material.dart';
import 'package:flutter_meedu/router2.dart';
import 'package:meedu_example/navigator_1/pages/counter_page.dart';
import 'package:meedu_example/navigator_2/pages/home_page_2.dart';
import 'package:meedu_example/navigator_2/router_delegate.dart';
import 'package:routemaster/routemaster.dart';

class MyApp2 extends StatelessWidget {
  MyApp2({Key? key}) : super(key: key);

  final _delegate = routerDelegate;

  // final routes = RouteMap(
  //   routes: {
  //     '/': (_) => MaterialPage(
  //           child: HomePage2(),
  //         ),
  //     '/counter': (_) => MaterialPage(
  //           child: CounterPage(),
  //         ),
  //   },
  // );

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   routeInformationParser: RoutemasterParser(),
    //   routerDelegate: RoutemasterDelegate(
    //     routesBuilder: (context) => routes,
    //   ),
    // );

    return MaterialApp.router(
      routeInformationParser: const RouteParser(),
      routerDelegate: _delegate,
    );
  }
}
