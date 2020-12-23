import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:meedu/meedu.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

void main() {
  test('StateController', () async {
    final c = LoginController();
    String email = c.state.email;
    String password = c.state.password;
    expect(email, '');
    c.onInit();
    c.afterFirstLayout();
    final subscribe = BaseListener<LoginState>((state) {
      email = state.email;
      password = state.password;
    });
    c.addListener(subscribe);

    c.onEmailChanged("test@test.com");
    c.onPasswordChanged("test");

    c.removeListener(subscribe);
    c.onDispose();
    expect(email, "test@test.com");
    expect(password, "test");
    expect(c.disposed, true);
    expect(() {
      c.onEmailChanged("test@test.com");
    }, throwsA(isA<AssertionError>()));
  });
}

class LoginState extends Equatable {
  final String email, password;
  LoginState({
    @required this.email,
    @required this.password,
  });

  static LoginState get initialState => LoginState(email: '', password: '');

  LoginState copyWith({
    String email,
    String password,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map toJson() => {"email": this.email, "password": this.password};

  @override
  List<Object> get props => [email, password];
}

class LoginController extends StateController<LoginState> {
  LoginController() : super(LoginState.initialState);

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
  bool onStateWillChange(LoginState oldState, LoginState newState) {
    if (oldState.email != newState.email) {
      return newState.email.contains("@");
    }
    return true;
  }

  @override
  void onStateChanged(LoginState oldState, LoginState currentState) {
    print("oldState ${oldState.toJson()}");
    print("currentState ${currentState.toJson()}\n\n");
  }

  @override
  Future<void> onDispose() {
    print(":::: dispose login page");
    return super.onDispose();
  }
}
