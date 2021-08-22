import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meedu/router2.dart';
import 'package:meedu_example/navigator_1/pages/counter_page.dart';
import 'package:meedu_example/navigator_2/pages/home_nested_page.dart';

import 'pages/home_page_2.dart';

MyRouterDelegate get routerDelegate => MyRouterDelegate(
      onBackButton: (route, data) async {
        return BackButtonResponse(
          allowPop: false,
          result: null,
        );
      },
      onNotFoundPage: (info) => MaterialPage(
        child: Scaffold(
          body: Center(
            child: Text("page not found"),
          ),
        ),
      ),
      routes: {
        // '/': (routeData) => MyPage(
        //       routeData: routeData,
        //       title: 'HOME',
        //       child: HomePage2(),
        //     ),
        '/': (routeData) => MyPage(
              routeData: routeData,
              title: 'HOME',
              child: HomeNestedPage(),
            ),
        '/user/:userId/product/:id': (routeData) => MyPage(
              routeData: routeData,
              title: 'PRODUCT ${routeData.pathParameters['id']}',
              child: Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Column(
                    children: [
                      Text(
                        routeData.pathParameters.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        '/counter': (routeData) => MyPage(
              routeData: routeData,
              title: 'Counter',
              child: CounterPage(),
            ),
        '/test': (routeData) => MyPage(
              title: 'Test',
              routeData: routeData,
              child: Scaffold(
                appBar: AppBar(),
                body: Builder(
                  builder: (context) => Center(
                    child: ElevatedButton(
                      child: Text("Pop with result"),
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

class MyPage extends MaterialPage {
  MyPage(
      {required RouteData routeData,
      required Widget child,
      Color color = Colors.white,
      String? title})
      : super(
          key: ValueKey(routeData.id),
          name: routeData.fullPath,
          child: child,
        );
}
