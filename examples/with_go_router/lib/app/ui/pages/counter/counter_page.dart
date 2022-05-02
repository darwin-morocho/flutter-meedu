import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

import 'controller/counter_provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Consumer(
          builder: (_, ref, __) {
            final controller = ref.watch(counterProvider);
            return Text(
              "${controller.counter}",
              style: const TextStyle(fontSize: 30),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: counterProvider.read.increment,
      ),
    );
  }
}
