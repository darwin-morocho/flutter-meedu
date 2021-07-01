import 'package:equatable/equatable.dart';
import 'package:meedu/meedu.dart';
import 'package:test/test.dart';

void main() {
  test('StateController', () async {
    final c = LoginController();
    var email = c.state.email;
    var password = c.state.password;
    expect(email, '');
    final subscribe = (LoginState state) {
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
    c.dispose();
    expect(email, 'test@test.com');
    expect(c.disposed, true);
    expect(() {
      c.onEmailChanged('test@test.com');
    }, throwsA(isA<AssertionError>()));
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
  final String email, password;
  LoginState({
    required this.email,
    required this.password,
  });

  static LoginState get initialState => LoginState(email: '', password: '');

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
