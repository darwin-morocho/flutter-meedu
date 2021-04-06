import 'package:flutter/material.dart';
import 'package:meedu_example/pages/home/home_page.dart';
import 'package:meedu_example/pages/login/login_page.dart';
import 'package:meedu_example/pages/splash/splash_page.dart';

import 'routes.dart';

abstract class Pages {
  static const INITIAL = Routes.SPLASH;
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.SPLASH: (_) => SplashPage(),
    Routes.LOGIN: (_) => LoginPage(),
    Routes.HOME: (_) => HomePage(),
  };
}
