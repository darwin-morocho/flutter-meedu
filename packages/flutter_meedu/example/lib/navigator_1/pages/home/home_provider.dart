import 'package:flutter_meedu/meedu.dart';

import 'home_controller.dart';
import 'home_state.dart';

final homeProvider = StateProvider<HomeController, HomeState>(
  (ref) {
    // print("👀 ${StackTrace.current}");
    return HomeController();
  },
);
