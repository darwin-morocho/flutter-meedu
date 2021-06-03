---
sidebar_position: 3
---

# SimpleNotifier

Just create a class that extends of `SimpleNotifier`

```dart
import 'package:flutter_meedu/meedu.dart';

class CounterController extends SimpleNotifier{
    int _counter = 0;
    int get counter => _counter;

    void increment(){
        _counter++;
        notify(); // notify to all listeners
    }
 
    // override the next method is OPTIONAL
    @override
    void onDispose() {
      // YOUR CODE HERE
      super.onDispose();// <-- you must call to the super method
    }
}
```


## **SimpleProvider**
Now you need to create a `provider` as a global variable using the `SimpleProvider` class.

```dart
final counterProvider = SimpleProvider(
  (ref) => CounterController(),
);
```
Now you can use the `Consumer` widget to read your `CounterController`.
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
        child: Consumer(builder: (_, watch, __) {
          final controller = watch(counterProvider);
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

By default the `counterProvider` variable doesn't create one instance of `CounterController` until it is need it. In this case the `Consumer`
widget call to the `read` method of our `counterProvider` and check if the `CounterController` was created and return the `CounterController` that was created before or create a new `CounterController`.


The `onDispose` method in our `CounterController` will be called when the `route` who created the `CounterController` is popped.

If you don't want to call to the `onDispose` method when the `route` who created the `CounterController` is popped you could use.
```dart {3}
final counterProvider = SimpleProvider(
  (ref) => CounterController(),
  autoDispose: false,// <-- ADD THIS TO DISABLE THE AUTO DISPOSE
);
```
:::danger WARNING
When you disable the `autoDispose` of your `provider` you need to handle it manually. For example 
:::
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
        child: Consumer(builder: (_, watch, __) {
          final controller = watch(counterProvider);
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

### Listen the changes in your Controller
You could use the `ProviderListener` Widget to listen the changes in our `CounterController`
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
            builder: (_, watch, __) {
              final controller = watch(counterProvider);
              return Text("${controller.counter}");
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // you can use the read method to access to your CounterController
            counterProvider.read.increment();
          },
        ),
      ),
    )
```

Or you can listen the changes in your SimpleProvider as a `StreamSubscription`
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

### watch method with WatchFilter

If you have multiples `Consumer` widgets in View and you only want rebuild certain Consumer you can use the `WatchFilter`
:::note
When you use the `WatchFilter` class you need to define the **generic types** in the `watch` method.
The second generic type in the next code in our `WatchFilter` is a `List` beacuse we are using a list of strings (ids) to listen the changes.
:::

```dart {8,21,23}
class CounterController extends SimpleNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    // notify to all listeners but only rebuild the widgets with the id 'text'
    notify(['text']);
  }
}

.
.
.

Scaffold(
  body: Column(
    children: [
      Consumer(
        builder: (_, watch, __) {
          final controller = watch<CounterController, List>(
            counterProvider,
            WatchFilter(ids: ['text']),
          );
          return Text("${controller.counter}");
        },
      ),
      Consumer(
        builder: (_, watch, __) {
          final controller = watch(counterProvider);
          return Text("${controller.counter}");
        },
      )
    ],
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      // you can use the read method to access to your CounterController
      counterProvider.read.increment();
    },
  ),
)
```

If you don't want to use `ids` to rebuild your `Consumer` you can use the `select` param in the `WatchFilter` instance.
The next code rebuilds the first `Consumer` only when the counter is highest than 5.

:::note
The second **generic type** in the next code in our `WatchFilter` is a `bool` beacuse we are using a **boolean condition** to listen the changes.
:::

```dart {19,21}
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
        builder: (_, watch, __) {
          final controller = watch<CounterController, bool>(
            counterProvider,
            WatchFilter(select: (controller) => controller.counter > 5),
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


## ConsumerWidget

Also you can extend from `ConsumerWidget` to create a widget and listen the changes in your notifier
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
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(counterProvider);
    return Text("${controller.counter}");
  }
}
```

:::success NOTE
The `watch` method in a `Consumer` or a `ConsumerWidget` can be used to listen multiples providers.
```dart
class CounterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final counterController = watch(counterProvider);
    final loginController = watch(loginProvider);
    return Text("${counterController.counter}");
  }
}
```
:::