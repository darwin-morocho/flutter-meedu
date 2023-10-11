---
sidebar_position: 2
---

# Inmutable States

Meedu is designed to streamline state management for both simple and complex apps, emphasizing the use of immutable state.

:::note
An immutable state is an instance of one Class that overrides `==` and `hashCode`. For example you could use [equatable](https://pub.dev/packages/equatable) or [freezed](https://pub.dev/packages/freezed) to create an immutable Class.
:::

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

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_state.freezed.dart';
@freezed
class LoginState with _$LoginState {
  const LoginState._();
  const factory LoginState({
    required String email,
    required String password,
  }) = _LoginState;
}
```

Now you can use the `LoginState` class to create a `StateNotifier`

```dart
import 'package:flutter_meedu/notifiers.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  // you need pass an inital state using super
  LoginNotifie(super.initialState);

  void onEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(password: password);
  }
}
```

:::info
If you only want to update the state of your `StateNotifier` but you don't want to notify to the listeners (don't rebuild the `Consumer` widgets)
you can use the `onlyUpdate` method in your `StateNotifier`.

```dart {7}
class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifie(super.initialState);

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

Next you need to create a `StateNotifierProvider` and use the `Consumer` widget to listen the changes in your state

Consider the following Login Form UI, where the `ElevatedButton` is enabled only when both the email and password in our state are not empty.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:flutter_meedu/consumer.dart';


final loginProvider = StateProvider<LoginNotifier, LoginState>(
  (_) => LoginController(
    LoginState(
      email: '',
      password:'',
    ),
  ),
);


class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: loginProvider.read().onEmailChanged,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextField(
                onChanged: loginProvider.read().onPasswordChanged,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              SizedBox(height: 30),
              Consumer(
                builder: (_, ref, __) {
                  final notifier = ref.watch(loginProvider);
                  final state = notifier.state;

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


## ConsumerWidget
Also you can extend from `ConsumerWidget` to create a widget and listen the changes in your notifier

```dart
import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';

class CounterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(counterProvider);
    return Text("${controller.counter}");
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CounterView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.read.increment();
        },
      ),
    );
  }
}
```

:::success NOTE
The `ref` parameter in a `Consumer` or a `ConsumerWidget` can be used to listen multiples providers.

```dart
class CounterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final counterNotifier = ref.watch(counterProvider);
    final loginNotifier = ref.watch(loginProvider);
    return Text("${counterNotifier.state} ${loginNotifier.state.email}");
  }
}
```
:::



## Listen to changes in our notifiers without rebuilding the UI

Sometimes we need to listen the changes in our state and perform some actions like showing a dialog, snackback, or navigation. In those cases, you can use `ref.listen` inside a `Consumer` or a `ConsumerWidget`.


```dart
class CounterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {

    ref.listen(
      loginProvider,
      callback: (notifier) {
        // YOUR ACTION HERE
      },
    );
   
    return MY_WIDGET;
  }
}
```

:::note
`ref.listen` only listens the changes in our state but does not rebuild our `Consumer` or `ConsumerWidget`.
:::