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
  @override
  void dispose() {
    // handle the dispose event manually
    // check if the provider has a Controller created before
    if (counterProvider.mounted) {
      counterProvider.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // The Consumer widget listen the changes in your CounterController
        // and rebuild the widget when is need it
        child: Consumer(builder: (_, watch, __) {
          final controller = watch(counterProvider);
          return Text("${controller.counter}");
        }),
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
