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
}
```

## Working with the **Provider** widget

You can use the `Provider` widget to create and inject a new `CounterController`.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu_example/controllers/counter_controller.dart';

class CounterPageWithProviderWidget extends StatelessWidget {
  const CounterPageWithProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<CounterController>(
      create: (_) => CounterController(),
      builder: (_, controller, __) => Scaffold(
        body: Center(
          // The SimpleBuilder listen the changes in our CounterController
          // and rebuild the widget when is need it
          child: SimpleBuilder<CounterController>(
            builder: (_, controller) => Text("${controller.counter}"),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.increment(); // or Get.i.find<CounterController>().increment();
          },
        ),
      ),
    );
  }
}
```

🔥🔥 **IMPORTANT** 🔥🔥 The `Provider` widget automatically inject your controller using `Get.i.put<YourController>()` so you can call to `Get.i.find<YourController>()` from anywhere of your code while your Provider is inside the **_widget tree_**. When the `Provider` widget is **_destroyed_** your controller will be removed using `Get.i.remove<YourController>()`.

### Life cycle

When a `SimpleController` or a `StateController` is passed to the `Provider` widget you can track the Life cycle of this widget since your controller.

Just override the respective methods.

```dart
class CounterController extends SimpleNotifier {

  /// called when the controller is inserted into the widget tree by one Provider
  @override
  void onInit() {

  }

  /// called when the provider and its child is rendered for the first time
  @override
  void onAfterFirstLayout() {

  }

  /// called when the controller is removed because the Provider widget was destroyed
  @override
  void onDispose() {
    // YOUR CODE HERE
    super.onDispose();// <-- you must call to the super method
  }
}
```

---

## Working with the **SimpleProvider** class

This is my favorite option because the **life cycle** of our controller is attached to one `Route` instead of a `Provider` widget.

First **flutter_meedu** needs to listen the changes in your route navigator. This is very simple in your `main.dart` file add the next code

```dart
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(    
       home: YourHomePage(),
       navigatorObservers: [
         router.observer,// <--this allows to flutter_meedu listen the changes in your navigator
       ],
    );
  }
}
```

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


When a `provider` is created  using the `SimpleProvider` class the controller returned by the `provider` doen't have a **life cycle** with the 
`onInit` and `onAfterFirstLayout` methods, only the `onDispose` method works and the `onDispose` will be called when the `route` who created the `CounterController` is popped.

If you don't want to call to the `onDispose` method when the `route` who created the `CounterController` is popped you could use.
```dart
final counterProvider = SimpleProvider(
  (ref) => CounterController(),
  autoDispose: false,// <-- ADD THIS TO DISABLE THE AUTO DISPOSE
);
```
When you disable the `autoDispose` of your `provider` you need to handle it manually. For example 
```dart
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