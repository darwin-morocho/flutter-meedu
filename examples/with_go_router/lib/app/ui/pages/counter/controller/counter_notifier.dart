import 'package:flutter_meedu/notifiers.dart';
import 'package:flutter_meedu/providers.dart';

final counterProvider = StateNotifierProvider<CounterNotifier, int>(
  (_) => CounterNotifier(0),
);

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(super.initialState);

  void increment() {
    state++;
  }

  @override
  void dispose() {
    print("counter disposed");
    super.dispose();
  }
}
