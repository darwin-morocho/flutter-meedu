import 'package:equatable/equatable.dart';
import 'package:meedu/meedu.dart';
import 'package:test/test.dart';

typedef _Subscriber = void Function(LoginState);

void main() {
  test('StateController', () async {
    final c = LoginController();
    String email = c.state.email;
    String password = c.state.password;
    expect(email, '');
    c.onInit();
    c.onAfterFirstLayout();
    final _Subscriber subscribe = (LoginState state) {
      email = state.email;
      password = state.password;
    };
    c.addListener(subscribe);

    c.onEmailChanged("test@test.com");
    c.onPasswordChanged("test");
    expect(password, "test");
    c.onPasswordChanged("newpassword");
    expect(c.oldState.password, "test");
    c.removeListener(subscribe);
    c.onDispose();
    expect(email, "test@test.com");
    expect(c.disposed, true);
    expect(() {
      c.onEmailChanged("test@test.com");
    }, throwsA(isA<AssertionError>()));
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

  Map toJson() => {"email": this.email, "password": this.password};

  @override
  List<Object> get props => [email, password];
}

class LoginController extends StateNotifier<LoginState> {
  LoginController() : super(LoginState.initialState);

  void onEmailChanged(String email) {
    state = this.state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = this.state.copyWith(password: password);
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
  void onDispose() {
    print(":::: dispose login page");
    super.onDispose();
  }
}
