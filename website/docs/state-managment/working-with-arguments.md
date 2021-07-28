---
sidebar_position: 5
---

# Working with arguments

Some times you need to pass an initial values to your `SimpleNotifier` or `StateNotifier` in that cases you can sue the `setArguments` method of your provider.

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

:::danger WARNING
If you are using `ModalRoute.of(context)` in your `build` method or in the `routes` parameter of one `MaterialApp`  to get `arguments` that was passed by
`Navigator.push`, `Navigator.pushName`, etc and next you use  `Navigator.pushNamedAndRemoveUntil` or `Navigator.pushNameAndRemoveUntil` to navigate to a new Route removing multiples routes from the Stack the `ModalRoute.of(context)` will rebuild the route before remove it and it could be a problem with a `provider` because that could be recreated a disposed provider.


In that cases you could use the `PageWithArguments` widget to avoid the recreation of a disposed provider.
:::

```dart
import 'package:flutter/material.dart';
import 'package:flutter_meedu/page.dart';

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


// or in your MaterialApp
MaterialApp(
  initialRoute: Routes.SPLASH,
  navigatorObservers: [
    router.observer,
  ],
  routes: {
    'product-detail': (_) => PageWithArguments(
      onReady: (RouteSettings settings) {
         final arguments = settings.arguments;
         tabsProvider.setArguments(arguments);
      },
      builder: (_) => ProductPage(),
    ),
  },
) 
```


Or you can create yourn own widget using `PageWithArgumentsWidget` class.
```dart

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/page.dart';

final loginProvider = SimpleProvider(
  (ref) => LoginController(ref.arguments),
);

class LoginPage extends PageWithArgumentsWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  void onInit(RouteSettings settings) {
    /// you can use settings to get data passed as an argument
    /// using Navigator.pushName(context,'rpute-name', arguments: data);
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
