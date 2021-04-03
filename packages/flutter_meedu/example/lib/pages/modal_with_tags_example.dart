import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu/get.dart';
import 'package:meedu/state.dart';

class ModalAndTagsExamplePage extends StatelessWidget {
  const ModalAndTagsExamplePage({Key? key}) : super(key: key);

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CounterView(tag: "tag1"),
            CounterView(tag: "tag2"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("CLOSE"),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Show dialog"),
          onPressed: () => _showDialog(context),
        ),
      ),
    );
  }
}

class CounterView extends StatelessWidget {
  final String tag;
  const CounterView({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<CounterController>(
      tag: this.tag,
      create: (_) => CounterController(),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SimpleBuilder<CounterController>(
              tag: this.tag,
              id: 'counter',
              builder: (_) => Text("${_.counter}"),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                final controller = Get.i.find<CounterController>(tag: this.tag);
                controller.increment();
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

class CounterController extends SimpleNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    update(['counter']);
  }
}
