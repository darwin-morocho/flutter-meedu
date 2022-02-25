**FULL DOCUMENTATION**  👉  https://flutter.meedu.app


## Similar to ChangeNotifier but better
```dart
import 'package:flutter_meedu/meedu.dart';

class CounterController extends SimpleNotifier{
    int _counter = 0;
    int get counter => _counter;

    void increment(){
        _counter++;
        notify(); // notify to all listeners
    }
}
```

```dart
import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/meedu.dart';

final counterProvider = SimpleProvider(
  (ref) => CounterController(),
);

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // The Consumer widget listen the changes in your CounterController
        // and rebuild the widget when is need it
        child: Consumer(builder: (_, ref, __) {
          final controller = ref.watch(counterProvider);
          return Text("${controller.counter}");
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // you can use the read method to access to your CounterController
          counterProvider.read.increment();
        },
      ),
    );
  }
}
```


## With inmutable states
```dart
import 'package:equatable/equatable.dart';
import 'package:flutter_meedu/meedu.dart';

class LoginController extends StateNotifier<LoginState> {
  // you need pass an inital state using super
  LoginController():super(LoginState.initialState);

  void onEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(password: password);
  }
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

  @override
  List<Object?> get props => [email, password];
}
```

```dart
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';


final loginProvider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: loginProvider.read.onEmailChanged,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextField(
                onChanged: loginProvider.read.onPasswordChanged,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              SizedBox(height: 30),
              Consumer(
                builder: (_, ref, __) {
                  final controller = ref.watch(loginProvider);
                  final state = controller.state;

                  final email = state.email;
                  final password = state.password;

                  final enabled = email.isNotEmpty && password.isNotEmpty;

                  return ElevatedButton(
                    onPressed: enabled
                        ? () {
                            // YOUR CODE HERE
                          }
                        : null,
                    child: Text("SEND"),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
```