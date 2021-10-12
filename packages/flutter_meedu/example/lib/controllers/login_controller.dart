import 'package:equatable/equatable.dart';
import 'package:flutter_meedu/meedu.dart';

class LoginController extends StateNotifier<LoginState> {
  // you need pass an inital state using super
  LoginController() : super(LoginState.initialState);

  void onEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> submit() async {
    state = state.copyWith(loading: true);
    await Future.delayed(Duration(milliseconds: 1000));
    state = state.copyWith(loading: false);
  }

  @override
  void dispose() {
    print("Login disposed");
    super.dispose();
  }
}

class LoginState extends Equatable {
  final String email, password;
  final bool loading;
  LoginState({
    required this.email,
    required this.password,
    this.loading = false,
  });

  static LoginState get initialState => LoginState(email: '', password: '');

  LoginState copyWith({
    String? email,
    String? password,
    bool? loading,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        loading,
      ];
}
