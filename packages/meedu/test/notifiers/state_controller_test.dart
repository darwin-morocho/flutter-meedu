// ignore_for_file: prefer_function_declarations_over_variables, avoid_print

import 'package:equatable/equatable.dart';
import 'package:meedu/notifiers.dart';
import 'package:test/test.dart';

void main() {
  test('StateController', () async {
    final c = LoginController();
    var email = c.state.email;
    var password = c.state.password;
    expect(email, '');
    // ignore: omit_local_variable_types
    final void Function(LoginState) subscribe = (LoginState state) {
      email = state.email;
      password = state.password;
    };
    c.addListener(subscribe);

    c.onEmailChanged('test@test.com');
    c.onPasswordChanged('test');
    expect(password, 'test');
    c.onPasswordChanged('newpassword');
    expect(c.oldState.password, 'test');
    c.removeListener(subscribe);
    // ignore: invalid_use_of_protected_member
    c.dispose();
    expect(email, 'test@test.com');
    expect(c.disposed, true);
    c.onEmailChanged('test2@test.com');
    expect(email, 'test@test.com');
    expect(c.initialState.email, '');
    expect(c.initialState.password, '');
  });

  test('StateController onlyUpdate', () async {
    final c = LoginController();
    var email = c.state.email;
    expect(email, '');
    final subscribe = (LoginState state) {
      email = state.email;
    };
    c.addListener(subscribe);
    print(c.hashCode);
    c.onlyUpdateEmail('test@test.com');
    expect(email, '');
    expect(c.state.email, 'test@test.com');
  });
}

class LoginState extends Equatable {
  const LoginState({
    required this.email,
    required this.password,
  });
  final String email, password;

  static LoginState get initialState =>
      const LoginState(email: '', password: '');

  LoginState copyWith({
    String? email,
    String? password,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map toJson() => {'email': email, 'password': password};

  @override
  List<Object> get props => [email, password];
}

class LoginController extends StateNotifier<LoginState> {
  LoginController() : super(LoginState.initialState);

  void onEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(password: password);
  }

  void onlyUpdateEmail(String email) {
    onlyUpdate(state.copyWith(email: email));
  }

  @override
  bool onStateWillChange(LoginState oldState, LoginState newState) {
    if (oldState.email != newState.email) {
      return newState.email.contains('@');
    }
    return true;
  }

  @override
  void onStateChanged(LoginState oldState, LoginState currentState) {
    print('oldState ${oldState.toJson()}');
    print('currentState ${currentState.toJson()}\n\n');
  }
}
