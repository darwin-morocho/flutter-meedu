**FULL DOCUMENTATION**  👉  https://flutter.meedu.app


Consider the following straightforward example of a typical counter app.

First, create a class that extends of **`StateNotifier`** and define the data type to be used for your state. In this example, we will use an **`int`** to represent the state of our counter app.

```dart
import 'package:flutter_meedu/notifiers.dart';// import the StateNotifer class

class CounterNotifier extends StateNotifer<int>{
  CounterNotifier(super.initialState); // the super class StateNotifer needs a initial state value

  void increment(){
    state++;
  }
}
```

Now you need to create a provider for our **`CounterNotifier`**

```dart
import 'package:flutter_meedu/providers.dart';// import the StateNotifierProvider class

final counterProvider = StateNotifierProvider<CounterNotifier, int>(
  (_) => CounterNotifier(0), // pass the initial state value when we create a CounterNotifier
);
```

As you may have noticed, we declare our **`counterProvider`** as a global variable. Don't worry; Meedu is fully compatible with testing.

With this setup, we can now easily listen to and update our counter within our views using the **`Consumer`** widget.

```dart {2,11,13,19}
import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart'; // import the consumer widget

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, child){
            final notifier =  ref.watch(counterProvider); // listen the state changes in our CounterNotifier
            return Text("${notifier.state}");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterProvider.read().increment(), // update the CounterNotifier state and rebuild the Consumer widget.
      ),
    );
  }
}
```

By default, our `counterProvider` does not create an instance of `CounterNotifier` until it is needed. In this scenario, the `Consumer` widget calls the `read` function of our `counterProvider` to check if an instance of `CounterNotifier` has been previously created and associated with our `counterProvider`. If not, it creates a new instance of `CounterNotifier` and associates it with our `counterProvider`.

:::note important
Inside the `Consumer` widget, we use `ref.watch(...)` to create or retrieve our instance of `CounterNotifier`. This action also establishes a subscriber for state changes. As a result, our `Consumer` will be rebuilt every time the state of our `CounterNotifier` instance changes.

When the `Consumer` widget is destroyed, all subscribers created by it are removed from our `CounterNotifier` instance.

Note: By default, when a `StateNotifier` loses all its subscribers, the `dispose` function of `StateNotifierProvider` will be called, and our `CounterNotifier` instance will also be disposed.

You can disable the autoDispose feature using `autoDispose: false` when we create our provider.
```dart {3}
final counterProvider = StateNotifierProvider<CounterNotifier, int>(
  (_) => CounterNotifier(0),
  autoDispose: false, // disable the autoDispose feature
);
```

Keep in mind that when you disable the autoDispose feature, you must release all resources and the StateNotifier linked to our providers by calling the dispose function.
For example you can use a StatefulWidget
```dart {12}
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  @override
  void dispose() {
    counterProvider.dispose(); // all resources and the StateNotifier linked to our provider
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return YOUR_CODE;
  }
}
```
:::


## What about testing?
This is very simple. Before or after each test you will need the default state of all StateNotifier. So you can use `ProvidersContainer.clear()` to clear and reset all providers.
```dart {6}
import 'package:flutter_meedu/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(ProvidersContainer.clear);

  testWidgets(
    'StateController test',
    (test) async {
      await test.pumpWidget(
        const MaterialApp(
          home: CounterView(),
        ),
      );
      expect(find.text("0"), findsOneWidget);
      await test.tap(find.byType(FloatingActionButton));
      await test.pump();
      expect(find.text("1"), findsOneWidget);
    },
  );
}

```