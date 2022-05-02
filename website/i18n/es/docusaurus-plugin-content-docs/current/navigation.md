# Navegación
:::note
**flutter_meedu** usa **navigator 1.0** en su modulo de navegación y no hay planes de agreagr **navigator 2.0** como nuevo modulo debido a la complejidad de crear un package de navegación que se adapte a todos los posibles flujos que un desarrollador quiera crear.

En ese caso puede usar cualquier package en [pub.dev](https://pub.dev) compatible con navigation 2.0 y usarlo con flutter_meedu sin problema solo asegúrese de agreagr el `observer` de flutter_meedu en sus `navigatorObservers`.
:::

Para navegar en su app usando del modulo de rutas de flutter meedu simplemente
agrege el siguiente codigo en su MaterialApp

```dart
import 'package:flutter_meedu/ui.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: router.navigatorKey, // add the navigator key
      navigatorObservers: [
        router.observer,// <-- ADD THIS
      ],
      home: HomePage(),
      routes: {YOUR_ROUTES},
    );
  }
}
```

Ahora puede navegar en su app usando

```dart
import 'package:flutter_meedu/ui.dart';
.
.
.
router.pushNamed('detail-page', arguments: "your-arguments");
```

Para recuperar sus argumentos use `router.arguments`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = router.arguments as String;
    return YOUR_WIDGET;
  }
}
```

## onGenerateRoute
Si desea usar el parámetro `onGenerateRoute` en su MaterialApp o CupertinoApp  debe definir el parámetro `key`
```dart {7}
import 'package:flutter_meedu/ui.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: router.appKey,// add the route key
      navigatorKey: router.navigatorKey, // add the navigator key
      navigatorObservers: [
        router.observer,// <-- ADD THIS
      ],
      onGenerateRoute: (settings) {
        final name = settings.name;
        switch (name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => HomePage(),
            );

          case '/counter':
            return MaterialPageRoute(
              builder: (_) => CounterPage(),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Text("Page not found"),
                ),
              ),
            );
        }
      },
    );
  }
}
```


## navegando con nombres de rutas usando transiciones personalizadas
Si desea usar transiciones personalizadas mientras navega mediante
nombre de rutas debe definir el parámetro `key` en su MaterialApp o CupertinoApp
```dart {5,13}
import 'package:flutter_meedu/ui.dart';

void main() {
  // overrride the default page transition for named and non named routes
  router.setDefaultTransition(router.Transition.downToUp);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: router.appKey,// add the route key
      navigatorKey: router.navigatorKey, // add the navigator key
      navigatorObservers: [
        router.observer,// <-- ADD THIS
      ],
      home: HomePage(),
      routes: {YOUR_ROUTES},
    );
  }
}
```
:::info
Posibles transiciones
```dart
enum Transition {
  fadeIn,
  rightToLeft,
  upToDown,
  downToUp,
  zoom,
  none,
  cupertino,
  material,
}
```
:::




## Testing

Para widget testing usted debe liberar el NavigatorState creado por `router.navigatorKey` antes o despues de cada test.

```dart
import 'package:flutter_meedu/ui.dart';

.
.
.

setUp((){
  router.dispose();
});

// or

tearDown((){
  router.dispose();
});
```
