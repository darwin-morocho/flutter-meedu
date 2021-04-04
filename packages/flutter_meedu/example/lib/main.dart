import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/state.dart';
import 'package:meedu/state.dart';
import 'package:meedu_example/pages/modal_with_tags_example.dart';
import 'package:meedu_example/pages/rx/rx_example.dart';

import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';
import 'pages/simple_provider_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          // home: ModalAndTagsExamplePage(),
          home: CounterPage(),
          // home: RxExample(),
          // routes: {
          //   '/login': (_) => LoginPage(),
          // },
        ),
      ),
      providers: [
        MultiProviderItem<AppThemeController>(
          create: (_) => AppThemeController(),
        )
      ],
    );
  }
}

class AppThemeController extends SimpleNotifier {
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  ThemeMode get themeMode => _darkMode ? ThemeMode.dark : ThemeMode.light;

  void onToggleTheme(bool enabled) {
    _darkMode = enabled;
    update();
  }
}
