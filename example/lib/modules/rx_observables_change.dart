import 'package:flutter/material.dart';
import 'package:meedu/rx.dart';

class Clock extends StatefulWidget {
  Clock({Key key}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Rx<int> counter = Rx(0);
  Rx<bool> enabled = Rx(true);

  void onSwitch() {
    this.enabled.value = !this.enabled.value;
  }

  @override
  void dispose() {
    counter.close();
    enabled.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RxBuilder(
        observables: [this.enabled],
        builder: (ctx) => RxBuilder(
          observables: [this.counter, if (enabled.value) enabled],
          builder: (ctx) {
            print("🎃 enabled ${enabled.value}");
            print("🎃 ${counter.value}");
            return Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (enabled.value) ...[
                    Text("hi"),
                    Text("${counter.value}"),
                  ]
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            child: Text("switch"),
            onPressed: this.onSwitch,
          ),
          FloatingActionButton(
            child: Text("Add"),
            onPressed: () {
              print("currentValue ${counter.value}");
              counter.value++;
            },
          ),
        ],
      ),
    );
  }
}
