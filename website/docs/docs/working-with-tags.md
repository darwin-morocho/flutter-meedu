---
sidebar_position: 6
---

# Working with tags

If you need to have multiples providers using the same `SimpleNotifier` or `StateNotifier` class but you don't want create a provider for each notifier you could use the `withTag` method to create multiples providers for a single Notifier class with its own state.

```dart
class CounterController extends SimpleNotifier {
  int counter = 0;
  void increment() {
    counter++;
    notify();
  }
}
```

Now you can create yours provider using `SimpleProvider.withTag` or `StateProvider.withTag`

```dart {1-3,21-24,27-30,55,69}
final counterProviderWithTag = SimpleProvider.withTag(
  (_) => CounterController(),
);


class SimpleTagPage extends StatelessWidget {
  const SimpleTagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              // each SimpleConsumerWithTag has their own state
              Expanded(
                child: SimpleConsumerWithTag(
                  tagName: 'counter1',
                  color: Colors.black26,
                ),
              ),
              Expanded(
                child: SimpleConsumerWithTag(
                  tagName: 'counter2',
                  color: Colors.redAccent.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleConsumerWithTag extends StatelessWidget {
  final String tagName;
  final Color color;
  const SimpleConsumerWithTag({
    Key? key,
    required this.tagName,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, watch, __) {
        // the find method creates a new unique provider using a string as key
        final controller = watch(
          counterProviderWithTag.find(tagName),
        );
        final counter = controller.counter;
        return Container(
          color: this.color,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$counter"),
              SizedBox(height: 10),
              CupertinoButton(
                color: Colors.blue,
                onPressed: () {
                  controller.increment();
                },
                child: Text("increment"),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

Also you can use `counterProviderWithTag.find('tagName')` to pass an initial argument to your notifier

```dart
counterProviderWithTag.find(tagName).setArguments('initial argument');
```

Also for `StateNotifier` you can use the `withTag` method but you need to define the generic types
```dart
final loginProviderWithTag = StateProvider.withTag<LoginController, LoginState>(
  (_) => LoginController(),
);
```

:::warning
If you want to use the `withTag` method to have the same route open multiple times at the same time with its own state, in that case you should disable the `autoDispose` feature to avoid destroying all your notifiers and **handle it manually**.


For example using a StatefulWidget.
```dart
final loginProviderWithTag = StateProvider.withTag<LoginController, LoginState>(
  (_) => LoginController(),
  autoDispose: false,
);

.
.
.

@override
void dispose() {
  // handle the dispose event manually
  // check if the provider has a Controller created before
  final provider = loginProviderWithTag.find('tagName');
  if (provider.mounted) {
    provider.dispose();
  }
  super.dispose();
}
```
:::