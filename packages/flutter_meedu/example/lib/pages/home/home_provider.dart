import 'package:flutter_meedu/meedu.dart';
import 'package:meedu_example/pages/home/home_controller.dart';
import 'package:meedu_example/pages/home/home_state.dart';

final homeProvider = StateProvider<HomeController, HomeState>(
  (ref) {
    // print("👀 ${StackTrace.current}");
    return HomeController();
  },
);
