import 'package:meedu/meedu.dart';
import 'package:meedu_example/pages/home/home_controller.dart';
import 'package:meedu_example/pages/home/home_state.dart';

final homeProvider = StateProvider<HomeController, HomeState>(
  (ref) {
    print("👀 arguments ${ref.arguments}");
    return HomeController();
  },
);
