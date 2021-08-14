import 'package:flutter/material.dart';
import 'package:meedu_example/navigator_1/pages/counter_page.dart';
import 'package:flutter_meedu/router2.dart';

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: RouteParser(),
      routerDelegate: MyRouterDelegate(
        routes: {
          '/': (info) => MaterialPage(
                child: Scaffold(
                  body: Center(
                    child: TextButton(
                      child: Text("counter"),
                      onPressed: () {
                        router2.push('/counter');
                      },
                    ),
                  ),
                ),
              ),
          '/counter': (info) => MaterialPage(
                child: CounterPage(),
              ),
          '/test': (info) => MaterialPage(
                child: Scaffold(
                  appBar: AppBar(),
                ),
              ),
        },
      ),
    );
  }
}
