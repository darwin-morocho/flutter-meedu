import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/state.dart';
import 'package:meedu_example/pages/counter_page.dart';
import 'package:meedu_example/pages/login_page.dart';

import 'routes/pages.dart';
import 'routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  router.setDefaultTransition(router.Transition.fadeIn);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
