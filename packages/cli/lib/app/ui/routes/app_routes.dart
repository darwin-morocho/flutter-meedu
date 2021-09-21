import 'package:flutter/widgets.dart' show BuildContext, Widget;
import 'routes.dart';
import '../pages/home/home_page.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.HOME: (_) => const HomePage(),
  };
}
    