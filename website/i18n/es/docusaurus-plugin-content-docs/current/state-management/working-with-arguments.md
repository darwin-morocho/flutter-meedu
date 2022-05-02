---
sidebar_position: 5
---

# Trabajar con argumentos

A veces necesitamos pasar un dato inicial a nuestro `SimpleNotifier` o `StateNotifier` en esos casos puede usar el método `setArguments` de sus providers.

En el siguiente ejemplo la clase **LoginController** necesita un valor inicial
para el email de nuestro LoginState

```dart
class LoginController extends StateNotifier<LoginState> {
  LoginController(String initialEmail)
      : super(
          LoginState(email: initialEmail, password: ''),
        );
}
```

Ahora en su provider utilice el parámetro `ref` para recuperar los `argumentos` pasados en el método `initState`.
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
Si esta usando `ModalRoute.of(context)` en sus metodos `build` on en el parámetri `routes` de un `MaterialApp` para recuperar los `argumentos` pasados mediante
`Navigator.push`, `Navigator.pushName`, etc. y luego usa  `Navigator.pushNamedAndRemoveUntil` o `Navigator.pushNameAndRemoveUntil` para navegar removiendo multiples rutas del Stack entonces la llamada a `ModalRoute.of(context)` llamra al método build antes de remove la ruta por lo que podría tener un problema con sus `provider` ya que estos serán recreados.


En esos casos utilice el widget `PageWithArguments` para evitar esos posibles errores.
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


O también puede usar la clase `PageWithArgumentsWidget`
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
A partir de `flutter_meedu:^5.1.0` si esta usando el modulo de navegación de 
flutter_meedu usted puede recuperar sus argumentos sin la necesidad de un `BuildContext`
o utilizando un `PageWithArgumentsWidget`

```dart
/// you can pass directly the route arguments to your controllers
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