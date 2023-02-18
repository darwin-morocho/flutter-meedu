---
sidebar_position: 6
---

# Working with arguments

Some times you need to pass an initial values to your `SimpleNotifier` or `StateNotifier` in that cases you can use the `setArguments` method of your provider.

In the next example to create a new instance of **LoginController** we needs a initial email value

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

:::danger WARNING
If you are using `ModalRoute.of(context)` in your `build` method or in the `routes` parameter of one `MaterialApp`  to get `arguments` that was passed by
`Navigator.push`, `Navigator.pushName`, etc and next you use  `Navigator.pushNamedAndRemoveUntil` or `Navigator.pushNameAndRemoveUntil` to navigate to a new Route removing multiples routes from the Stack the `ModalRoute.of(context)` will rebuild the route before remove it and it could be a problem with a `provider` because that could be recreated a disposed provider.


In that cases you could use the `PageWithArguments` widget to avoid the recreation of a disposed provider.
:::

```dart
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWithArguments(
      onReady: (RouteSettings settings) {
        final arguments = settings.arguments;
        productProvider.setArguments(arguments);
      },
     builder: (context) => Scaffold(...) ,
    );
  }
}
```


Or you can create yourn own widget using `PageWithArgumentsWidget` class.
```dart

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';

final loginProvider = SimpleProvider(
  (ref) => LoginController(ref.arguments),
);

class LoginPage extends PageWithArgumentsWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  void onInit(RouteSettings settings) {
    /// you can use settings to get data passed as an argument
    /// using Navigator.pushName(context,'route-name', arguments: data);
    loginProvider.setArguments(settings.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      .
      .
      .
    );
  }
}
```

:::success
Since `flutter_meedu:^5.1.0` if you are using the meedu's router module
to navigate in your app you can get your arguments without BuildContext
and you can directly use them in your providers. With this you don't need
a `PageWithArgumentsWidget` to pass route arguments to your providers.

```dart
/// also you can pass directly the route arguments to your controllers
final loginProvider = SimpleProvider(
  (_) => LoginController(router.arguments as String),
);

or

/// if you need to write unit or widget testing
/// you can use the [overrideProvider] method
setUp((){
  loginProvider.overrideProvider(
    (_) => LoginController(mockedInitialValue),
  );
});
```
:::