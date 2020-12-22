Just use the `Rx<T>` class to create one observable

```dart
import 'package:meedu/rx.dart';
Rx<int> counter = Rx(0); // or use Rx<int> counter = 0.obs;
.
.
.
void increment() {
    counter.value++;
}
```
Don't forget to call `close()` method when your widget or controller is destroyed.

Now you can use the `RxBuilder` widget to listen changes in your observables

```dart
import 'package:meedu/rx.dart';
.
.
.
RxBuilder(
    observables: [
      counter,
    ],
    builder: (ctx) => Text(
        "counter ${counter.value}",
    ),
)
```

Check the example for more info abour how to use the `Rx` class with `List` and `Map`.
