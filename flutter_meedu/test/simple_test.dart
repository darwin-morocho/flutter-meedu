import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


class StateNotifier {

}

class ProviderScope extends InheritedWidget {
  late final ProvidersContainer container;

  ProviderScope({
    super.key,
    required super.child,
  }) : container = ProvidersContainer();

  @override
  bool updateShouldNotify(ProviderScope oldWidget) =>
      container != oldWidget.container;

  static ProvidersContainer containerOf(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ProviderScope>();
    return scope!.container;
  }
}

extension ContextRef on BuildContext {
  ProvidersContainer get container {
    return ProviderScope.containerOf(this);
  }

  T read<T>(
    BaseProvider<T> provider, {
    String? tag,
  }) {
    final elements = container.elements;
    final key = ProviderReference.getKey(
      provider,
      tag,
    );

    if (elements.containsKey(key)) {
      return elements[key]!._value;
    }

    return ProviderReference(
      container: container,
    ).read(provider);
  }
}

void main() {
  test(
    'demo',
    () {
      final container = ProvidersContainer();
      final ref = ProviderReference(container: container);
      ref.setArguments(provider: provider, arguments: 100);
      final notifier = ref.read(provider);
      final notifier2 = ref.read(provider2);
      expect(ref.mounted(provider), true);
      expect(notifier.state, 100);
      expect(notifier2.state, 1000);
      expect(ref.read(provider).hashCode, notifier.hashCode);
      ref.dispose();
      expect(notifier.mounted, false);
      expect(ref.mounted(provider), false);
      expect(notifier2.mounted, true);
    },
  );
}

final provider = BaseProvider<CounterNotifier>(
  (ref) {
    final notifier = CounterNotifier(
      state: ref.arguments as int? ?? 0,
    );
    ref.onDispose(notifier.dispose);
    return notifier;
  },
);

final provider2 = BaseProvider<CounterNotifier>(
  (ref) {
    final notifier = CounterNotifier(
      state: 1000,
    );
    ref.onDispose(notifier.dispose);
    return notifier;
  },
);

class CounterNotifier {
  final int state;

  bool _mounted = true;
  bool get mounted => _mounted;

  CounterNotifier({required this.state});

  void dispose() {
    _mounted = false;
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
