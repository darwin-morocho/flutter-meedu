import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu_example/controllers/counter_controller.dart';

class CounterPageWithProviderWidget extends StatelessWidget {
  const CounterPageWithProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<CounterController>(
      create: (_) => CounterController(),
      builder: (_, controller, __) => Scaffold(
        body: Center(
          // The SimpleBuilder listen the changes in our CounterController
          // and rebuild the widget when is need it
          child: SimpleBuilder<CounterController>(
            builder: (_, controller) => Text("${controller.counter}"),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.increment();
          },
        ),
      ),
    );
  }
}
