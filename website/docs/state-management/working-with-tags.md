---
sidebar_position: 6
---

# Working with tags

If you need to have multiple notifiers using the same `StateNotifier` or `Bloc` class, but you don't want to create a provider for each notifier, you can use the `tag` parameter when you call the `read` function of our providers.

Consider the following example:

```dart {1, 3}
final counterProvider = Provider.stateTag<CounterNotifier, int>(
  (_) => CounterNotifier(0),
);

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(super.initialState);

  void increment() {
    state++;
  }
}
```

Now we can use a single `Consumer` widget to create two different instances of `CounterNotifier` using the same provider.

```dart {11-12,17,21}
class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer(
            builder: (_, ref, __) {
              final counter1 = ref.watch(counterProvider, tag: '1').state;
              final counter2 = ref.watch(counterProvider, tag: '2').state;
              return Text('counter1=$counter1, counter2=$counter2');
            },
          ),
          TextButton(
            onPressed: () => counterProvider.read(tag: '1').increment(),
            child: Text('increment counter 1'),
          ),
          TextButton(
            onPressed: () => counterProvider.read(tag: '2').increment(),
            child: Text('increment counter 2'),
          ),
        ],
      ),
    );
  }
}
```

:::note
In the example above, we have created 2 instances of `CounterNotifier` by using tags, and each of these instances has its own state.

NOTE: If you need to manually dispose of your notifiers that were created using tags, you can use

```dart
yourProvider.dispose(tag:'YOUR_TAG');
```

:::

## How to Set Arguments for Our Notifiers

When you call the setArguments function of our `StateNotifierTagArgumentsProvider`, you must use the tag argument.

```dart {3,8}
final counterProvider = Provider.stateArgumentsTag<CounterNotifier, int, int>(
  (ref) => CounterNotifier(ref.arguments), // ref.arguments is an int
);

counterProvider.setArguments(
  100,
  tag: '1',
);
```

## Tags and filters

If you use `ref.watch` or `ref.listen` with filters like `.select` or `.when`, the `tag` parameter of `ref.watch` or `ref.listen` will be omitted, as the filters have their own `tag` parameter.

```dart {6}
Consumer(
  builder: (_, ref, __){
    final notifier = ref.watch(
      myProvider.select(
        (state) => state.value,
        tag: 'myTag',
      ),
    );

    YOUR_CODE
  },
)
```
