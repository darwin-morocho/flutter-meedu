import 'package:meedu/meedu.dart';
import 'package:meedu_example/pages/login/login_controller.dart';

final loginProvider = SimpleProvider<LoginController>((ref) {
  print("arguments ${ref.params}");
  return LoginController();
});
