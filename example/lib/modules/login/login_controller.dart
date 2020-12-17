import 'package:meedu/state.dart';
import 'login_state.dart';

class LoginController extends StateController<LoginState> {
  @override
  LoginState get initialState => LoginState(email: '', password: '');

  void onEmailChanged(String email) {
    update(
      this.state.copyWith(email: email),
    );
  }

  void onPasswordChanged(String password) {
    update(
      this.state.copyWith(password: password),
    );
  }

  @override
  Future<void> onDispose() {
    print(":::: dispose login page");
    return super.onDispose();
  }
}
