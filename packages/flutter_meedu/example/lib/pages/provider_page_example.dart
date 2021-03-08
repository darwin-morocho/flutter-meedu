import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:meedu/meedu.dart';

class ProviderPageExample extends ProviderPage<Controller> {
  @override
  Controller create(BuildContext context) {
    return Controller(10);
  }

  @override
  void onInit(BuildContext context, Controller controller) {
    print("ProviderPageExample onInit");
  }

  @override
  void onAfterFirstLayout(BuildContext context, Controller controller) {
    print("ProviderPageExample onAfterFirstLayout");
  }

  @override
  void onDispose(BuildContext context, Controller controller) {
    print("ProviderPageExample onDispose");
  }

  @override
  Widget buildPage(BuildContext context, Controller controller) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SimpleBuilder<Controller>(
              builder: (_) => Text("${controller.counter}"),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => pushReplacementNamed('/login'),
              child: Text("GO TO LOGIN"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Controller extends SimpleController {
  int counter;

  Controller(this.counter);

  void increment() {
    counter++;
    update();
  }
}
