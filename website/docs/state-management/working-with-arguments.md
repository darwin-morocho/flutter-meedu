---
sidebar_position: 5
---

# Working with arguments

Sometimes you need to pass initial values to your `StateNotifier`. In such cases, you can use the `StateNotifierArgumentsProvider` class and call the `setArguments` function to set argument values that will be retrieved in the creator callback of your provider.

Next, you can use the `ref` parameter of your callback generator to access the arguments passed in the `initState` method.

```dart {4,24}
final loginProvider = Provider.stateArguments<LoginNotifier, LoginState, String>(
  (ref) => LoginNotifier(
    LoginState(
      email: ref.arguments, // here ref.arguments is a String
      password: '',
    ),
  ),
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