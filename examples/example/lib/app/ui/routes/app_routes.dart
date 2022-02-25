import '../pages/splash/splash_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/login/login_page.dart';
import '../pages/counter/counter_page.dart';
import 'package:flutter/widgets.dart' show BuildContext, Widget;
import 'routes.dart';
import '../pages/home/home_page.dart';

/// WARNING: generated code don't modify directly
Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.HOME: (_) => const HomePage(),
    Routes.COUNTER: (_) => const CounterPage(),
    Routes.LOGIN: (_) => const LoginPage(),
    Routes.PROFILE: (_) => const ProfilePage(),
    Routes.SPLASH: (_) => const SplashPage(),
  };
}
