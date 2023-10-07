import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'adds one to input values',
    () {
      final counterProvider = NotifierProvider<CounterNotifier, int>(
        (ref) => CounterNotifier(0),
      );

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
}

class CounterNotifier extends Notifier<int> {
  CounterNotifier(super.initialState);

  void increment() => state++;
}
