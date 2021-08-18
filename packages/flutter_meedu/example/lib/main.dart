import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/url_strategy.dart';

import 'my_app_with_navigator_2.dart';
import 'navigator_1/routes/pages.dart';
import 'navigator_1/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // router.setDefaultTransition(router.Transition.downToUp);
  if (kIsWeb) {
    setPathUrlStrategy();
  }
  runApp(MyApp2());
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: router.appKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      navigatorKey: router.navigatorKey,
      //  themeMode: controller.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // home: LoginPage(),
      navigatorObservers: [
        router.observer,
      ],
      initialRoute: Routes.MENU,
      routes: Pages.routes,
      // onGenerateRoute: (settings) {
      //   final name = settings.name;
      //   switch (name) {
      //     case '/':
      //       return MaterialPageRoute(
      //         builder: (_) => MenuPage(),
      //       );

      //     case Routes.COUNTER:
      //       return MaterialPageRoute(
      //         builder: (_) => CounterPage(),
      //       );
      //     default:
      //       return MaterialPageRoute(
      //         builder: (_) => Scaffold(
      //           appBar: AppBar(),
      //           body: Center(
      //             child: Text("Page not found"),
      //           ),
      //         ),
      //       );
      //   }
      // },
    );
  }
}

class AppThemeController extends SimpleNotifier {
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  ThemeMode get themeMode => _darkMode ? ThemeMode.dark : ThemeMode.light;

  void onToggleTheme(bool enabled) {
    _darkMode = enabled;
    notify();
  }
}
