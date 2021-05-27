---
sidebar_position: 4
---

# StateNotifier
If you have a more complex state consider using the StateNotifier class instead of SimpleNotifier.

A StateNotifier stores a single immutable state.

An immutable state is an instance of one Class that overrides `==` and `hashCode`. For example you could use [equatable](https://pub.dev/packages/equatable) to create an immutable Class.

Add equatable as a dependency in your `pubspec.yaml` file
```yaml
equatable: "^2.0.2"
```
Now you can create a Class to manage your state
```dart
import 'package:equatable/equatable.dart';

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


Now you can use the `LoginState` class to create a `StateNotifier`
```dart
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
```

Next you need to create a `StateNotifier` and use the `Consumer` widget to listen the changes in your state

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
                builder: (_, watch, __) {
                  final controller = watch(loginProvider);
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

Also you can use the `WatchFilter` class to only rebuild your `Consumer` when is need it.

For example the next code only rebuilds the Consumer widget when the `email` in our `LoginState` has changed.

```dart {3,6}
Consumer(
  builder: (_, watch, __) {
    final email = watch<LoginController, LoginState>(
      loginProvider,
      WatchFilter(
        when: (prev, current) => prev.email != current.email,
      ),
    ).state.
    return Text(email);
  },
)
```

:::note
When you use the `WatchFilter` to listen the changes in a `StateNotifier` you need to define the generic types 
in the watch method.
- The first generic type is the class witch extends of StateNotifier.
- The second generic type is the class used to manage our state.
:::

:::info
In the same way you can listen the changes of your `StateNofier` using the `ProviderListener` widget or using a `StreamSubscription`
:::


Also the `StateNotifier` class allows you to listen when the state is going to change and listen when the state has changed.
```dart
class LoginController extends StateNotifier<LoginState> {
  // you need pass an inital state using super
  LoginController() : super(LoginState.initialState);

  void onEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(password: password);
  }

  @override
  void onStateChanged(LoginState oldState, LoginState currentState) {
    // YOUR CODE HERE
  }

  @override
  bool onStateWillChange(LoginState oldState, LoginState newState) {
    // YOUR CODE HERE
    return true; // you need to return a boolean to decide if the update of the state is allowed
  }
}
```