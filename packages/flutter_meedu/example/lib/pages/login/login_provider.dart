import 'package:flutter_meedu/meedu.dart';
import 'package:meedu_example/pages/login/login_controller.dart';

final loginProvider = SimpleProvider<LoginController>(
  (_) {
    return LoginController();
  },
);
