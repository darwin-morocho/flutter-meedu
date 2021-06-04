import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:meedu_example/pages/home/home_page.dart';
import 'package:meedu_example/pages/menu_page.dart';
import 'package:meedu_example/pages/rx_page.dart';
import 'package:meedu_example/pages/simple_tag/simple_tag_page.dart';
import 'package:meedu_example/pages/splash/splash_page.dart';
import 'package:meedu_example/pages/state_tag/state_tag_page.dart';
import 'package:meedu_example/pages/tabs_page/controller.dart';
import 'package:meedu_example/pages/tabs_page/tabs_page.dart';
import 'package:meedu_example/pages/video/video_page.dart';
import 'package:meedu_example/pages/counter_page.dart';
import 'package:meedu_example/pages/login_page.dart';

import 'routes.dart';

abstract class Pages {
  static const INITIAL = Routes.MENU;
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.SPLASH: (_) => SplashPage(),
    Routes.RX: (_) => RxPage(),
    Routes.LOGIN: (_) => LoginPage(),
    Routes.HOME: (_) => HomePage(),
    Routes.TABS: (_) {
      return PageWithArguments(
        onReady: (RouteSettings settings) {
          final arguments = settings.arguments;
          tabsProvider.setArguments(arguments);
        },
        builder: (_) => TabsPage(),
      );
    },
    Routes.VIDEO: (_) => VideoPage(),
    Routes.MENU: (_) => MenuPage(),
    Routes.SIMPLE_TAG: (_) => SimpleTagPage(),
    Routes.STATE_TAG: (_) => StateTagPage(),
    Routes.COUNTER: (_) => CounterPage(),
  };
}
