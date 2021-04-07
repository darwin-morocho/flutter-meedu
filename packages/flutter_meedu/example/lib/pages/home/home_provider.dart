import 'package:meedu/meedu.dart';
import 'package:meedu_example/pages/home/home_controller.dart';
import 'package:meedu_example/pages/home/home_state.dart';
import 'package:meedu_example/pages/login/login_provider.dart';

final homeProvider = StateProvider<HomeController, HomeState>(
  (ref) => HomeController(
    ref.read(loginProvider),
  ),
);
