import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'bloc/counter_bloc.dart';
import 'bloc/counter_provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter example"),
      ),
      body: Center(
        child: Consumer(
          builder: (_, ref, __) {
            final counter = ref.watch(counterProvider).state;
            return Text(
              "$counter",
              style: const TextStyle(
                fontSize: 50,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterProvider.read().add(
              Increment(),
            ),
        child: const Icon(
          Icons.add_rounded,
        ),
      ),
    );
  }
}
