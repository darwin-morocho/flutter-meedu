import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';

import 'controller/counter_notifier.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Consumer(
          builder: (_, ref, __) {
            final counter = ref.watch(counterProvider).state;
            return Text(
              "$counter",
              style: const TextStyle(fontSize: 30),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterProvider.read().increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
