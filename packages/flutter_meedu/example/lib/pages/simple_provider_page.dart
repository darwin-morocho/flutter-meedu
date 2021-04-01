import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu/meedu.dart';
import 'package:meedu/state.dart';

class CounterController extends SimpleController {
  int counter = 0;
  void increment() {
    counter++;
    update();
  }
}

final counterProvider = SimpleProvider(() => CounterController());

class SimpleProviderPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final counter = watch(counterProvider).counter;
    return Scaffold(
      body: Center(
        child: Text("$counter"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.controller.increment();
        },
      ),
    );
  }
}
