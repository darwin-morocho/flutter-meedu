import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:meedu_example/controllers/counter_controller.dart';

final counterProvider = SimpleProvider<CounterController>(
  (_) => CounterController(),
);

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            CounterView(),
            Consumer(builder: (_, watch, __) {
              final counter = watch(
                counterProvider.select((_) => _.counter >= 10),
              ).counter;
              return Text("${counter}");
            }),
            Consumer(builder: (_, watch, __) {
              final counter = watch(
                counterProvider.select((_) => _.demo),
              ).demo.counter;
              return Text("Demo ${counter}");
            }),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            child: Icon(Icons.sim_card),
            heroTag: 'demo',
            onPressed: () {
              counterProvider.read.incrementDemo();
            },
          ),
          FloatingActionButton(
            onPressed: () {
              counterProvider.read.increment();
            },
            heroTag: 'increment',
          ),
        ],
      ),
    );
  }
}

class CounterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(
      counterProvider.ids(() => ['id']),
    );
    return Text("${controller.counter}");
  }
}
