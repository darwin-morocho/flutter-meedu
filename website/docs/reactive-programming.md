# Reactive programming

The next example create on instance of `Rx` to save int values, every time that `_counter.value++` is called
the `RxBuilder` rebuilds the Text widget.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_meedu/rx.dart';

class RxPage extends StatefulWidget {
  @override
  _RxPageState createState() => _RxPageState();
}

class _RxPageState extends State<RxPage> {
  final _counter = Rx<int>(0); // create an observable

  @override
  void dispose() {
    _counter.close(); // You must call to close when you don't need the observable any more
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RxBuilder(
          (_) => Text("${_counter.value}"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counter.value++;
        },
      ),
    );
  }
}
```

:::note
You can create observables for String, int, double or booleans using the `.obs` extension

- `final _counter = 0.obs; // equals to final Rx<int> _counter = Rx(0);`
- `final _enabled = false.obs; // equals to final Rx<bool> _enabled = Rx(false);`
- `final _query = "".obs; // equals to final Rx<String> _query = Rx("");`
- `final _price = 9.99.obs; // equals to final Rx<double> _price = Rx(9.99);`
  :::

## Working with List and Map.

```dart
Rx<List<int>> numbers = Rx([]);

void add(int number){
    final copy = [...numbers.value]; // equals to List<int>.from(numbers.value);
    copy.add(number);
    numbers.value = copy;
}

void remove(int index){
    final copy = [...numbers.value];
    copy.removeAt(index);
    numbers.value = copy;
}

void update(int index, int number){
    final copy = [...numbers.value];
    copy[index] = number;
    numbers.value = copy;
}
```

```dart
Rx<Map<String, dynamic>> data = Rx({});

void add(String key, dynamic value) {
  final copy = {...data.value};// equals to Map<String, dynamic>.from(data.value);
  copy[key] = value;
  data.value = copy;
}
void remove(String key) {
  final copy = {...data.value};
  copy.remove(key);
  data.value = copy;
}
```

## Rx Reactions

You can use the Rx class to use some utils methods like debounce, once, ever and interval.

```dart
class SearchController extends SimpleNotifier {
  final Rx<String> _text = "".obs;
  RxReaction? _debounce, _ever, _once, _interval;

  void onTextChange(String text) {
    _text.value = text;
  }

  SearchController(){
      _init();
  }

  void _init() {

    // called every time after a certain duration
    _debounce = _text.debounce(Duration(milliseconds: 500), (value) {
      print("debounce  $value");
    });

    // called every time
    _ever = _text.ever(
      (value) {
        print("ever  $value");
      },
      condition: (value) => value.contains("@"),
    );

    // called only once time
    _once = _text.once(
      (value) {
        print("once  $value");
      },
      condition: (value) => value.contains("-"),
    );

    // called each a certain duration
    _interval = _text.interval(Duration(seconds: 2), (value) {
      print("interval  $value");
    });
  }

  @override
  void onDispose() {
    _text.close();
    _debounce?.dispose();
    _ever?.dispose();
    _once?.dispose();
    _interval?.dispose();
    super.onDispose();
  }
}
```
