import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:meedu_example/pages/provider_page_example.dart';
import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';

void main() {
  router.setDefaultTransition(router.Transition.upToDown);
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
      home: ProviderPageExample(),
      onGenerateRoute: (RouteSettings settings) {
        Widget page;

        switch (settings.name) {
          case "/login":
            page = LoginPage();
            break;

          default:
            page = Scaffold(
              body: Center(
                child: Text("page '${settings.name}' not found"),
              ),
            );
        }

        return router.getRoute(
          page,
          arguments: settings.arguments,
          backGestureEnabled: true,
        );
      },
    );
  }
}
