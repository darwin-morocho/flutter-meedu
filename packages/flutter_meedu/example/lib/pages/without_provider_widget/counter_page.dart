import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:meedu_example/controllers/counter_controller.dart';

final counterProvider = SimpleProvider<CounterController>(
  (ref) {
    ref.onDispose(() {
      // YOUR CODE HERE
    });
    return CounterController();
  },
);

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CounterView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.read.increment();
        },
      ),
    );
  }
}

class CounterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(counterProvider);
    return Text("${controller.counter}");
  }
}
