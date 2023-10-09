// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_meedu/rx.dart';
import 'package:flutter_test/flutter_test.dart';

class Clock extends StatefulWidget {
  const Clock({
    Key? key,
    required this.counter,
    required this.enabled,
  }) : super(key: key);
  final Rx<int> counter;
  final Rx<bool> enabled;

  @override
  // ignore: library_private_types_in_public_api
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
                        const Text("hi"),
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
            onPressed: onSwitch,
            child: const Text("switch"),
          ),
          FloatingActionButton(
            child: const Text("Add"),
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
