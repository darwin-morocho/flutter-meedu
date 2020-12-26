import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/state.dart';
import 'package:meedu/state.dart';
import 'package:meedu_example/pages/home/home_page.dart';
import 'package:meedu_example/pages/login/login_page.dart';

void main() {
  router.setDefaultTransition(router.Transition.upToDown);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: SimpleBuilder<AppThemeController>(
        builder: (_) => MaterialApp(
          title: 'Flutter Demo',
          navigatorKey: router.navigatorKey,
          themeMode: _.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: HomePage(),
          routes: {
            '/login': (_) => LoginPage(),
          },
        ),
      ),
      providers: [
        Provider<AppThemeController>(
          create: (_) => AppThemeController(),
        )
      ],
    );
  }
}

class AppThemeController extends SimpleController {
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  ThemeMode get themeMode => _darkMode ? ThemeMode.dark : ThemeMode.light;

  void onToggleTheme(bool enabled) {
    _darkMode = enabled;
    update();
  }
}
