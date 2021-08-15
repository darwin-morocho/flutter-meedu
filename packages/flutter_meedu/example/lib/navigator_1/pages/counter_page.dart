import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:meedu_example/my_app_with_navigator_2.dart';
import 'package:meedu_example/navigator_1/controllers/counter_controller.dart';
import 'package:routemaster/routemaster.dart';

final counterProvider = SimpleProvider<CounterController>(
  (_) => CounterController(),
);

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              // router2.push('/test');
              final result = await router2.push<DateTime>('/test');
              print("result $result");
            },
            icon: Icon(Icons.emoji_emotions),
          )
        ],
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
