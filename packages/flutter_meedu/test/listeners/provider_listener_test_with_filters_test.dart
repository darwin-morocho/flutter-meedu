import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    router.dispose();
  });
  tearDown(() {
    ProviderScope.clear();
  });

  testWidgets(
    'ProviderListener > SimpleProvider filters > select',
    (tester) async {
      int numberOfCalls = 0;
      int minValueToBeNotified = 5;
      await tester.pumpWidget(
        MaterialApp(
          home: ProviderListener<_CounterController>(
            provider: _counterProvider.select(
              (_) => _.counter >= minValueToBeNotified,
              booleanCallback: true,
            ),
            onChange: (_, __) {
              numberOfCalls++;
            },
            builder: (_, controller) {
              return Scaffold(
                body: Center(
                  child: TextButton(
                    child: Text("add"),
                    onPressed: controller.incremment,
                  ),
                ),
              );
            },
          ),
        ),
      );
      final controller = _counterProvider.read;
      for (int i = 1; i <= minValueToBeNotified + 3; i++) {
        await tester.tap(find.text("add"));
        await tester.pump();
        expect(controller.counter, i);
        if (i < minValueToBeNotified) {
          expect(numberOfCalls, 0);
        }
      }
    },
  );
}

final _counterProvider = SimpleProvider(
  (_) => _CounterController(),
);

class _CounterController extends SimpleNotifier {
  int _counter = 0;
  int get counter => _counter;

  void incremment() {
    _counter++;
    notify();
  }
}
