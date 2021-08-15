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
        onNotFoundPage: (info) => MaterialPage(
          child: Scaffold(
            body: Center(
              child: Text("page not found"),
            ),
          ),
        ),
        routes: {
          '/': (info) => MaterialPage(
                child: Scaffold(
                  body: Center(
                    child: Column(
                      children: [
                        Text(
                          info.uri.queryParameters.toString(),
                        ),
                        TextButton(
                          child: Text("counter"),
                          onPressed: () {
                            router2.push('/counter');
                          },
                        ),
                        TextButton(
                          child: Text("go to product"),
                          onPressed: () {
                            router2.push(
                              '/user/Darwin Morocho/product/2',
                              queryParameters: {
                                'darkMode': 'true',
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          '/user/:userId/product/:id': (info) => MaterialPage(
                child: Scaffold(
                  appBar: AppBar(),
                  body: Center(
                    child: Column(
                      children: [
                        Text(
                          info.parameters.toString(),
                        ),
                      ],
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
