import 'package:meedu/meedu.dart';
import 'package:meedu_example/pages/login/login_controller.dart';

final loginProvider = SimpleProvider<LoginController>((ref) {
  final message = ref.params as String;
  print("arguments $message");
  return LoginController();
});
