import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:meedu_example/controllers/counter_controller.dart';

final counterProvider = SimpleProvider(
  (ref) => CounterController(),
  autoDispose: false,
);

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    _subscription = counterProvider.read.stream.listen((_) {});
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (_, watch, __) {
                final controller = watch<CounterController, List>(
                  counterProvider,
                  WatchFilter(ids: ['text']),
                );
                return Text("${controller.counter}");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // you can use the read method to access to your CounterController
          counterProvider.read.increment();
        },
      ),
    );
  }
}
