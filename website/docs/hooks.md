# Hooks

If you like [flutter_hooks](https://pub.dev/packages/flutter_hooks) the GOOD NEWS is that flutter meedu is compatible with hooks.


First add [hooks_meedu](https://pub.dev/packages/hooks_meedu) to your `pubspec.yaml`

```yaml
dependencies:
  flutter_hooks: lastest_version
  hooks_meedu: ^0.1.0-beta.2
```


Now you can use the `HookConsumerWidget` class to create a widget that can works with hooks and meedu at the same time.

```dart
class HookConsumerTest extends HookConsumerWidget {
  const HookConsumerTest({super.key});

  @override
  Widget build(BuildContext context, BuilderRef ref) {
    final count = useState(0);
    final state = ref.watch(myProvider).state;

    return YOUR_WIDGET;
  }
}
```

Also you can use the `HookConsumer` widget.

```dart
HookConsumer(
  builder: (_, ref, child) {
    final text = useState("");
    final state = ref.watch(myProvider).state;

    return YOUR_WIDGE;
  },
)
```

If you need to work with a StatefulWidget, hooks and flutter meedu you can use the `StatefulHookConsumerWidget` class.

```dart
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
    final state = ref.watch(provider).state;

    return GestureDetector(
      onTap: () {
        count2.value++;
        setState(() => count++);
      },
      child: OTHER_WIDGET,
    );
  }
}
```