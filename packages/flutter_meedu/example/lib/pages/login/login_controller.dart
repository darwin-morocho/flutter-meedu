import 'package:meedu/state.dart';

class LoginController extends SimpleNotifier {
  String _email = '', _password = '';
  String get email => _email;
  String get password => _password;

  void onEmailChanged(String text) {
    _email = text;
    notify(['email']);
  }

  void onPasswordChanged(String text) {
    _password = text;
    notify(['password']);
  }

  Future<void> submit() {
    print("_email: $_email");
    print("_password: $_password");
    return Future.delayed(Duration(milliseconds: 100));
  }

  @override
  void onDispose() {
    print("LoginController disposed");
    super.onDispose();
  }
}
