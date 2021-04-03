import 'package:meedu/state.dart';
import 'login_state.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController() : super(LoginState.initialState);

  void onEmailChanged(String email) {
    state = this.state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = this.state.copyWith(password: password);
  }

  @override
  void onStateChanged(LoginState oldState, LoginState currentState) {
    print("oldState ${oldState.toJson()}");
    print("currentState ${currentState.toJson()}\n\n");
  }

  @override
  void onDispose() {
    print(":::: dispose login page");
    super.onDispose();
  }
}
