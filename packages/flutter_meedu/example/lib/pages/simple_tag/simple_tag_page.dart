import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class SimpleTagPage extends StatelessWidget {
  const SimpleTagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: SimpleConsumerWithTag(
                  tagName: 'counter1',
                  color: Colors.black26,
                ),
              ),
              Expanded(
                child: SimpleConsumerWithTag(
                  tagName: 'counter2',
                  color: Colors.redAccent.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleConsumerWithTag extends StatelessWidget {
  final String tagName;
  final Color color;
  const SimpleConsumerWithTag({
    Key? key,
    required this.tagName,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        final controller = ref.watch(
          _counterProviderWithTag.find(tagName),
        );
        final counter = controller.counter;
        return Container(
          color: this.color,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$counter"),
              SizedBox(height: 10),
              CupertinoButton(
                color: Colors.blue,
                onPressed: () {
                  controller.increment();
                },
                child: Text("increment"),
              ),
            ],
          ),
        );
      },
    );
  }
}

final _counterProviderWithTag = SimpleProvider.withTag(
  (ref) => _CounterController(),
);

class _CounterController extends SimpleNotifier {
  int counter = 0;
  void increment() {
    counter++;
    notify();
  }

  @override
  void dispose() {
    print("Disposed _CounterController ${this.hashCode}");
    super.dispose();
  }
}
