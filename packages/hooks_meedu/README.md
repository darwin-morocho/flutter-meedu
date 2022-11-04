A way to use both flutter_hooks and flutter_meedu together.

Documentation: https://flutter.meedu.app

Example:
```dart

final provider = SimpleProvider(
  (_) => CounterBloc(),
);

class CounterBloc extends SimpleNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notify();
  }
}

class HookConsumerTest extends HookConsumerWidget {
  const HookConsumerTest({super.key});

  @override
  Widget build(BuildContext context, BuilderRef ref) {
    final count = useState(0);

    return Scaffold(
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            child: const Icon(Icons.person),
            onPressed: () {
              count.value++;
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              provider.read.increment();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'provider ${ref.watch(provider).counter}',
          ),
          Text(
            'useState ${count.value}',
          ),
          HookConsumer(
            builder: (_, ref, child) {
              final text = useState("");
              return Column(
                children: [
                  child!,
                  Text(
                    'text ${text.value}',
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.abc),
                    onPressed: () {
                      text.value = 'meedu';
                    },
                  ),
                ],
              );
            },
            child: const Icon(Icons.emoji_emotions),
          )
        ],
      ),
    );
  }
}

class HookStatefulTest extends StatefulHookConsumerWidget {
  const HookStatefulTest({super.key});

  @override
  HookStatefulTestState createState() => HookStatefulTestState();
}

class HookStatefulTestState extends ConsumerState<HookStatefulTest> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final count2 = useState(0);

    return GestureDetector(
      onTap: () {
        count2.value++;
        setState(() => count++);
      },
      child: Text(
        '${ref.watch(provider).counter} $count ${count2.value}',
      ),
    );
  }
}
```