---
sidebar_position: 4
---

# BLoC pattern

Also you are able to use the BLoC pattern with flutter_meedu.


Just create a class that extends of `Bloc` and define the event and state class.

:::note
If you want to use the `freezed` package to generate your events using Union types
and Sealed classes. Don't worry. The `Bloc` class is totally compatible with that.
:::

```dart
import 'package:flutter_meedu/notifiers.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc(super.initialState) {
    on<Increment>(
      (event, emit) => emit(state + 1),
    );

    on<Decrement>(
      (event, emit) => emit(state - 1),
    );
  }
}

abstract class CounterEvent {}
class Increment extends CounterEvent {}
class Decrement extends CounterEvent {}
```

Next you need to create a `StateNotifierProvider` and use the `Consumer` widget to listen the changes in your state.

:::note
The `Bloc` class extends of `StateNotifier` so you are able to use
the `.select` and `.when` filters in your Consumers.
:::

```dart
import 'package:flutter/material.dart';
import 'package:flutter_meedu/providers.dart';


final counterProvider = StateNotifierProvider<CounterEvent, int>(
  (_) => CounterBloc(),
);

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (_, ref, __) {
          final counter = ref.watch(counterProvider).state;
          return Text('$counter');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterProvider.read.add(
           Increment(),
        ),
      ),
    );
  }
}
```

