import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_meedu/meedu.dart';

class Clock extends StatefulWidget {
  final Rx<int> counter;
  final Rx<bool> enabled;
  Clock({
    Key? key,
    required this.counter,
    required this.enabled,
  }) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  void onSwitch() {
    widget.enabled.value = !widget.enabled.value;
  }

  @override
  void dispose() {
    widget.counter.close();
    widget.enabled.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RxBuilder(
        (_) => widget.enabled.value
            ? RxBuilder(
                (_) {
                  return Column(
                    children: [
                      if (widget.enabled.value) ...[
                        Text("hi"),
                        Text("${widget.counter.value}"),
                      ]
                    ],
                  );
                },
              )
            : Container(),
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
              widget.counter.value++;
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  group('RxBuilder', () {
    testWidgets(
      'RxBuilder counter test',
      (test) async {
        final counter = 0.obs;
        await test.pumpWidget(
          MaterialApp(
            home: Clock(
              counter: counter,
              enabled: true.obs,
            ),
          ),
        );

        expect(find.text("hi"), findsOneWidget);
        expect(find.text("0"), findsOneWidget);
        await test.tap(find.text("Add"));
        print("value ${counter.value}");
        await test.pump();
        expect(find.text("1"), findsOneWidget);
        await test.tap(find.text("switch"));
        await test.pump();
        expect(find.text("hi"), findsNothing);
        await test.tap(find.text("switch"));
        await test.pump();
        expect(find.text("hi"), findsOneWidget);
        expect(find.text("1"), findsOneWidget);
        await test.tap(find.text("Add"));
        print("value ${counter.value}");
        await test.pump();
        expect(find.text("2"), findsOneWidget);
        await test.pump();
      },
    );
  });
}
