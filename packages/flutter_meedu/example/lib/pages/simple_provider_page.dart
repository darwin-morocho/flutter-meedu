import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu/meedu.dart';
import 'package:meedu/state.dart';

class CounterController extends SimpleController {
  int counter = 0;
  void increment() {
    counter++;
    update(['id']);
  }
}

final counterProvider = SimpleProvider(() => CounterController());

class SimpleProviderPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final counter = watch(
      counterProvider,
      SimpleFilter(
        ['id'],
      ),
    ).counter;
    return Scaffold(
      appBar: AppBar(
        title: Text("$counter"),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) => ListTile(
          title: Text("$index"),
        ),
        itemCount: 1000,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.controller.increment();
        },
      ),
    );
  }
}
