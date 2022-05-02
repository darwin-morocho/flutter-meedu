---
sidebar_position: 4
---

# StateNotifier
If you have a more complex state consider using the StateNotifier class instead of SimpleNotifier.

A StateNotifier stores a single immutable state.

An immutable state is an instance of one Class that overrides `==` and `hashCode`. For example you could use [equatable](https://pub.dev/packages/equatable) or [freezed](https://pub.dev/packages/freezed) to create an immutable Class.


### With equatable
Add equatable as a dependency in your `pubspec.yaml` file
```yaml
equatable: latest_version
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

### With freezed
To use freezed you need [build_runner](https://pub.dev/packages/build_runner) and [freezed_annotation](https://pub.dev/packages/freezed_annotation)



in your `pubspec.yaml` file (replace `latest_version` with the latest version of each dependency)
```yaml
dependencies:
  flutter:
    sdk: flutter
  freezed_annotation: latest_version

dev_dependencies:
  flutter_test:
    sdk: flutter

  build_runner: latest_version
  freezed: latest_version
```

If you have conflicts when you try to install freezed check the oficial
documentation https://pub.dev/packages/freezed

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_state.freezed.dart';
@freezed
class LoginState with _$LoginState {
  const LoginState._();
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
  }) = _LoginState;

  static LoginState get initialState => LoginState();
}
```

next run the next command to generate the `.frezeed.dart` files
```shell
flutter pub run build_runner build --delete-conflicting-outputs
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
:::info
If you only want to update the state of your `StateNotifier` but you don't want to notify to the listeners (don't rebuild the `Consumer` widgets and don't listen the changes in the `ProviderListener` widget)
you can use the `onlyUpdate` method in your `StateNotifier`.

```dart {7}
class LoginController extends StateNotifier<LoginState> {
  // you need pass an inital state using super
  LoginController():super(LoginState.initialState);

  void onEmailChanged(String email) {
    // only update the state
    onlyUpdate(state.copyWith(email: email));
  }
  .
  .
  .

}
```
:::

Next you need to create a `StateProvider` and use the `Consumer` widget to listen the changes in your state

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

Also you can use the `.select` filter to only rebuild your `Consumer` when is need it.

For example the next code only rebuilds the Consumer widget when the `email` in our `LoginState` has changed.

here we use `ref.select` to direct access to the value returned by `loginProvider.select` but if you want get the notifier linked to `loginProvider` you can use `ref.watch` with `loginProvider.select`

```dart {4}
Consumer(
  builder: (_, ref, __) {
    final email = ref.select(
      loginProvider.select((_)=>_.email),
    );
    return Text(email);
  },
)
```

:::note
Also you can use the `when` method for a more complex condition.
```dart {4}
Consumer(
  builder: (_, ref, __) {
    final email = ref.watch(
      loginProvider.when((prev, current) => prev.email != current.email),
    ).state.email;
    return Text(email);
  },
)
```
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
