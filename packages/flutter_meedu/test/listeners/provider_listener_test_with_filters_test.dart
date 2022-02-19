import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/router.dart' as router;

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

  testWidgets(
    'ProviderListener > SimpleProvider filters > ids',
    (tester) async {
      int numberOfCalls = 0;
      int minValueToBeNotified = 5;
      await tester.pumpWidget(
        MaterialApp(
          home: ProviderListener<_CounterController>(
            provider: _counterProvider.ids(
              () => ['id'],
              allowNotifyWithEmptyIds: false,
            ),
            onChange: (_, __) {
              numberOfCalls++;
            },
            builder: (_, controller) {
              return Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      TextButton(
                        child: Text("add"),
                        onPressed: controller.incremment,
                      ),
                      TextButton(
                        child: Text("addId1"),
                        onPressed: controller.incremmentWithId1,
                      ),
                      TextButton(
                        child: Text("addId2"),
                        onPressed: controller.incremmentWithId2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
      final controller = _counterProvider.read;
      for (int i = 1; i <= minValueToBeNotified + 3; i++) {
        await tester.tap(find.text("addId2"));
        await tester.pump();
        expect(controller.counter, i);
        expect(numberOfCalls, 0);
      }
      await tester.tap(find.text("addId1"));
      await tester.pump();
      await tester.tap(find.text("addId1"));
      await tester.pump();
      expect(numberOfCalls, 2);
      await tester.tap(find.text("add"));
      await tester.pump();
      expect(numberOfCalls, 2);
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

  void incremmentWithId1() {
    _counter++;
    notify(['id']);
  }

  void incremmentWithId2() {
    _counter++;
    notify(['id2']);
  }
}
