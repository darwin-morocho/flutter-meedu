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

@override
Future<void> onDispose(){
 counter.close(); // close the stream controller
 return super.onDispose();
}
```
Don't forget to call `close()` method when your widget or controller is destroyed.

Now you can use the `RxBuilder` widget to listen changes in your observables

```dart
import 'package:flutter_meedu/rx.dart';
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

## Working with ***List*** and ***Map***.

### Lists
```dart
Rx<List<int>> numbers = Rx([]);

void add(int number){
    final copy = List<int>.from(numbers.value);
    copy.add(number);
    numbers.value = copy;
}

void remove(int index){
    final copy = List<int>.from(numbers.value);
    copy.removeAt(index);
    numbers.value = copy;
}

void update(int index, int number){
    final copy = List<int>.from(numbers.value);
    copy[index] = number;
    numbers.value = copy;
}
```


### Maps
```dart
Rx<Map<String, dynamic>> data = Rx({});
void add(String key, dynamic value) {
  final copy = Map<String, dynamic>.from(data.value);
  copy[key] = value;
  data.value = copy;
}
void remove(String key) {
  final copy = Map<String, dynamic>.from(data.value);
  copy.remove(key);
  data.value = copy;
}
```


## Rx Workers
You can use the `Rx` class to use some utils methods like **debounce, once, ever and interval**.
Check one example [here](https://github.com/darwin-morocho/flutter-meedu/blob/master/packages/flutter_meedu/example/lib/pages/rx/search_controller.dart).