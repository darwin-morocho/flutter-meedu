import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

class ProviderWidgetPage extends StatelessWidget {
  const ProviderWidgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<CounterController>(
      create: (_) => CounterController(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                router.pushReplacement(Scaffold());
              },
            ),
          ],
        ),
        body: Center(
          child: SimpleBuilder<CounterController>(
            builder: (_, controller) {
              return Text("jaja ${controller.counter}");
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.i.find<CounterController>().increment();
          },
        ),
      ),
    );
  }
}

class CounterController extends SimpleNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notify();
  }
}
