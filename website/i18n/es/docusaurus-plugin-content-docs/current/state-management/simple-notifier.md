---
sidebar_position: 3
---

# SimpleNotifier

Para manejar el estado de su vista similar a `ChangeNotifier`
utilice a clase `SimpleNotifier`.

Simplemente cree una clase  que extienda de `SimpleNotifier` y llame al método `notify` para notificar que ha ocurrido
un cambio y actualizar sus vistas.

```dart
import 'package:flutter_meedu/meedu.dart';//<-- IMPORT meedu

class CounterController extends SimpleNotifier{
    int _counter = 0;
    int get counter => _counter;

    void increment(){
        _counter++;
        notify(); // notify to all listeners
    }

    // override the next method is OPTIONAL
    @override
    void dispose() {
      // YOUR CODE HERE
      super.dispose();// <-- you must call to the super method
    }
}
```

## **SimpleProvider**

Ahora debe crear un `provider` como una variable global usando la clase `SimpleProvider`.

```dart
final counterProvider = SimpleProvider(
  (_) => CounterController(),
);
```

Ahora para escuchar los cambios y actualizar la vista use el widget `Consumer`.

```dart
import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/meedu.dart';

final counterProvider = SimpleProvider(
  (ref) => CounterController(),
);

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // The Consumer widget listen the changes in your CounterController
        // and rebuild the widget when is need it
        child: Consumer(builder: (_, ref, __) {
          final controller = ref.watch(counterProvider);
          return Text("${controller.counter}");
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // you can use the read method to access to your CounterController
          counterProvider.read.increment();
        },
      ),
    );
  }
}
```

Por defecto la variable global `counterProvider` no creara una instancia de `CounterController` hasta que es necesario. En el caso del widget `Consumer` este llama a la propiedad `read` de nuestro `counterProvider` y comprueba si anteriormente se creo una instancia de `CounterController` o si no la crea en ese momento.

El  método `dispose` de nuestro `CounterController` sera llamado cuando la `ruta` que creo nuestro `CounterController` es eliminada del stack de rutas (Esta es la caracteristica de **AUTO DISPOSE**).

Si desea desactivar la caracteristica de **AUTO DISPOSE** use el
parametro `autoDispose` de su provider.
```dart {3}
final counterProvider = SimpleProvider(
  (ref) => CounterController(),
  autoDispose: false,// <-- ADD THIS TO DISABLE THE AUTO DISPOSE
);
```

:::note
`autoDispose: false` puede usarse para crear estados globales.
:::

:::danger WARNING
Cuando desactiva la caracteristica de `autoDispose` en su `provider` usted debe encargarse de liberar su provider cuando
 este ya no es necesario. Aquí un ejemplo:

 ```dart {18}
final counterProvider = SimpleProvider(
  (ref) => CounterController(),
  autoDispose: false,
);

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  void dispose() {
    // handle the dispose event manually
    // check if the provider has a Controller created before
    if (counterProvider.mounted) {
      counterProvider.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(builder: (_, ref, __) {
          final controller = ref.watch(counterProvider);
          return Text("${controller.counter}");
        }),
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
:::


### Escuchando los cambios en un SimpleNotifier

El widget `ProviderListener` puede ser usado para escuchar los cambios en un `SimpleNotifier` y un `StateNotifier`

```dart {3-7}
 ProviderListener<CounterController>(
      provider: counterProvider,
      onChange: (context, controller) {
        // YOUR CODE HERE
        // This method is called every time that one Instance
        // of our CounterController calls to the notify() method
      },
      builder: (_, controller) => Scaffold(
        body: Center(
          // The Consumer widget listen the changes in your CounterController
          // and rebuild the widget when is need it
          child: Consumer(
            builder: (_, ref, __) {
              final controller = ref.watch(counterProvider);
              return Text("${controller.counter}");
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // you can use the read property to access to your CounterController
            counterProvider.read.increment();
          },
        ),
      ),
    )
```

:::note
El widget `ProviderListener` provee de los siguientes parámetros
para escuchar su ciclo de vida.
`onInitState, onAfterFirstLayout, onDispose`.
:::

:::note
Si quiere escuchar multiples providers al mismo tiempo utilice el widget `MultiProviderListener`.

```dart

final conterProvider = SimpleProvider(
  (_) => CounterController(),
);

final loginProvider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);

class MultiProviderPage extends StatelessWidget {
  const MultiProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProviderListener(
      items: [
        MultiProviderListenerItem<CounterController>(
          provider: conterProvider,
          onChange: (_, controller) {
              /// ADD YOUR CODE HERE
          },
        ),
        MultiProviderListenerItem<LoginController>(
          provider: loginProvider,
          onChange: (_, controller) {
             /// ADD YOUR CODE HERE
          },
        ),
      ],
      child: YOUR_WIDGET,
    );
  }
}

```
:::

:::note
- Los widgets `ProviderListener` y `MultiProviderListener` solamente escuchan los cambios pero NO actualizan la vista.
:::

Tambien puede escuchar los cambios en un provider mediante un `StreamSubscription`

```dart {1,5-7,12}
  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    _subscription = counterProvider.read.stream.listen((_) {
      // YOUR CODE HERE
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
```

### Actualizar Consumers mediante el filtro ***.select***

Si tiene multiples widget `Consumer` y no quiere que todos se actualicen cuando hay un cambio en su SimpleNotifier puede usar el filtro `.select`.

El siguiente código solo  actualiza el  `Consumer` cuando el
valor de `counter` es mayor o igual a 5.

```dart {20}
class CounterController extends SimpleNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notify();
  }
}

.
.
.

Scaffold(
  body: Center(
    child: Consumer(
        builder: (_, ref, __) {
          final controller = ref.watch(
            counterProvider.select(
              (controller) => controller.counter > 5),
            ),
          );
          return Text("${controller.counter}");
        },
    )
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      // you can use the read method to access to your CounterController
      counterProvider.read.increment();
    },
  ),
)
```

:::note
El filtro `.select` tambien puede ser usado para escuchar cuando
el valor de un dato ha cambiado en su Notifier.

El siguiente codigo actualiza el `Consumer` solo cuando el valor de la propiedad `counter`ha cambiado en nuestro CounterController.

```dart
Consumer(
  builder: (_, ref, __) {
    final controller = ref.watch(
        counterProvider.select((_) => _.counter,
      ),
    );
    return Text("${controller.counter}");
  },
)
```

Por defecto `ref.watch` retorna el Notifier vinculado a un provider.
Si quiere acceder directamente al valor retornado por el filtro `.select` utilice `ref.select` en lugar de `ref.watch`
```dart
Consumer(
  builder: (_, ref, __) {
    final counter = ref.select(
        counterProvider.select((_) => _.counter,
      ),
    );
    return Text("$counter");
  },
)
```
:::

:::note
- Los filtros `.select , .when` tambien pueden ser usados con los widgets `ProviderListener` 
y `MultiProviderListener`
  
  
Ejemplo:

```dart
ProviderListener<CounterController>(
  provider: counterProvider.select(
    (_) => _.counter >= 5,
  ),
  onChange: (_, controller) {

  },
  builder: (_, controller) {
    return YOUR_WIDGET;
  },
);
```
:::

## ConsumerWidget
Puede crear un widget que extienda de `ConsumerWidget` y escuchar los cambios en un `SimpleNotifier` o un `StateNotifier`

```dart {7}
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

class CounterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(counterProvider);
    return Text("${controller.counter}");
  }
}
```

:::success NOTE
El parámetro `ref` en un `Consumer` o en un `ConsumerWidget` puede ser usado para escuchar multiples providers.

```dart
class CounterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final counterController = ref.watch(counterProvider);
    final loginController = ref.watch(loginProvider);
    return Text("${counterController.counter}");
  }
}
```
:::
