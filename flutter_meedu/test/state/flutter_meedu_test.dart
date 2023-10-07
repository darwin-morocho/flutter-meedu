import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/provider_scope.dart';
import 'package:flutter_test/flutter_test.dart';

final counterProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(0),
);

void main() {
  setUp(ProviderScope.clear);
  test(
    'autodispose',
    () {
      expect(counterProvider.mounted, false);

      final initialHasCode = counterProvider.read.hashCode;

      /// the notifier returned must be the same
      expect(counterProvider.read.hashCode, initialHasCode);

      // ignore: prefer_function_declarations_over_variables
      final void Function(int) listener = (int value) {};

      counterProvider.read.addListener(listener);
      expect(counterProvider.mounted, true);
      final notifier = counterProvider.read;
      counterProvider.read.removeListener(listener);
      expect(counterProvider.mounted, false);
      expect(notifier.mounted, false);
    },
  );

  test(
    'overrideProvider',
    () {
      counterProvider.overrideProvider(
        (_) => CounterNotifier(100),
        autoDispose: false,
      );

      // ignore: prefer_function_declarations_over_variables
      final void Function(int) listener = (int value) {};

      counterProvider.read.addListener(listener);
      expect(counterProvider.mounted, true);
      expect(counterProvider.read.state, 100);
      counterProvider.read.removeListener(listener);
      expect(counterProvider.mounted, true);
    },
  );
}

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(super.initialState);

  void increment() => state++;
}
