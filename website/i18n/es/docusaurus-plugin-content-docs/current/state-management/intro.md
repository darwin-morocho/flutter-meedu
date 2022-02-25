---
sidebar_position: 2
---

# Configuración

## Como funciona flutter_meedu?

Para manejar el esdato de tus paginas o widget tenemos 2 formas:
- Usando la clase `SimpleNotifier` similiar a `ChangeNotifier` para un estado simple.
- Usando la clase `StateNotifier` para estados complejos.

:::success INFO
Si estas usando **visual studio code** considere instalar la siguiente [extensión](https://marketplace.visualstudio.com/items?itemName=meedu.meedu) para un desarrollo mas agil y rapido con flutter_meedu
:::
:::success INFO
Para usuarios linux y macOs (no probado en Windows, pero puede probarlo si lo desea) puede usar [meedu_cli](https://pub.dev/packages/meedu_cli) para crear proyectos flutter con flutter_meedu por defecto, definir una arquitectura limpia y crear sus paginas.
:::


# Auto dispose
El **ciclo de vida** de un `SimpleNotifier` o un `StateNotifier` por defecto esta anclado a una `Ruta`. Esto significa que nuestros Notifiers seran destruidos cuando la `ruta` que creo el `SimpleNotifier` o el `StateNotifier` es eliminada del stack de rutas.

**flutter_meedu** necesita escuchar los cambios en su `navigator`. Esto es muy simple simplemente es su `MaterialApp` o `CupertinoApp`
agrege el siguiente código:

```dart {15} title="main.dart"
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router; // <-- ADD THIS

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(    
       home: YourHomePage(),
       navigatorObservers: [
         router.observer,// <-- this allows to flutter_meedu listen the changes in your navigator
       ],
    );
  }
}
```

:::note Nested navigation
Si esta usando navegación anidada para habilitar la caracteristica de `auto dispose` en las rutas anidadas agrege el (`router.observer`) de flutter_meedu en el parametro `navigatorObservers` de su widget `Navigator`
:::

:::note
Si esta usando `navigator 2.0` o un `package` para navegar en su app asegurese de agrear el observer de flutter_meedu (`router.observer`) en sus `navigatorObservers` de sus `delegates` o sus widgets de tipo `Navigator`
:::