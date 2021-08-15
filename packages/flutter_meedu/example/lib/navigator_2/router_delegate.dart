import 'package:flutter/material.dart';
import 'package:flutter_meedu/router2.dart';
import 'package:meedu_example/navigator_1/pages/counter_page.dart';

import 'pages/home_page_2.dart';

MyRouterDelegate get routerDelegate => MyRouterDelegate(
      onNotFoundPage: (info) => MaterialPage(
        child: Scaffold(
          body: Center(
            child: Text("page not found"),
          ),
        ),
      ),
      // initialRoute: '/counter',
      initialRoute: '/counter',
      routes: {
        '/': (info) => MaterialPage(
              child: HomePage2(),
            ),
        '/user/:userId/product/:id': (info) => MaterialPage(
              child: Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Column(
                    children: [
                      Text(
                        info.pathParameters.toString(),
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
                body: Builder(
                  builder: (context) => Center(
                    child: ElevatedButton(
                      child: Text("Porp with result"),
                      onPressed: () {
                        Navigator.pop(
                          context,
                          DateTime.now(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
      },
    );
