---
sidebar_position: 6
---

# Multiples notifiers con un solo provider

Si necesita tener multiples provider que usen la misma clase que extiende de `SimpleNotifier` o `StateNotifier` pero no quiere deninir entonces puede usar el método 
`withTag` para crear multiples providers de un mismo Notifier con su propio estado.

```dart
class CounterController extends SimpleNotifier {
  int counter = 0;
  void increment() {
    counter++;
    notify();
  }
}
```

Ahora puede crear sus provider usando `SimpleProvider.withTag` o `StateProvider.withTag`

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
      builder: (_, ref, __) {
        // the find method creates a new unique provider using a string as key
        final controller = ref.watch(
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

También puede usar `counterProviderWithTag.find('tagName')` para pasar un argumento.

```dart
counterProviderWithTag.find(tagName).setArguments('initial argument');
```

Para clases que extienden de `StateNotifier` puede usar el método `withTag` pero debe definir los `Generic Types` respectivos
```dart
final loginProviderWithTag = StateProvider.withTag<LoginController, LoginState>(
  (_) => LoginController(),
);
```