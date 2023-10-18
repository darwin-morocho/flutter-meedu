import 'package:flutter/widgets.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_meedu/notifiers.dart';
import 'package:flutter_meedu/providers.dart';

void main() {}

class MyWidget extends ConsumerWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context, BuilderRef ref) {
    ref.watch(
      provider,
    );
    return const Placeholder();
  }
}

final provider = Provider.state<CounterNotifier, int>(
  (ref) => CounterNotifier(0),
);

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(super.initialState);
}
