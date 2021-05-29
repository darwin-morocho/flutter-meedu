---
sidebar_position: 5
---

# Working with arguments

Some times you need to pass a initial values to your `SimpleNotifier` or `StateNotifier` in that cases you can sue the `setArguments` method of your provider.

In the next example to create a new instance of **LoginController** we need a initial email value

```dart
class LoginController extends StateNotifier<LoginState> {
  LoginController(String initialEmail)
      : super(
          LoginState(email: initialEmail, password: ''),
        );
}
```

Next you can use the `ref` parameter of your callback generator to get the `arguments` passed in the `initState` method.
```dart {2,19}
final loginProvider = StateProvider<LoginController, LoginState>(
  (ref) => LoginController(ref.arguments ?? ''),
);


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    // you must set your arguments
    // before call loginProvider.read or before use watch(loginProvider)
    loginProvider.setArguments("initial@email.com");
  }

  @override
  Widget build(BuildContext context) {
    // YOUR CODE HERE
  }
}
```
