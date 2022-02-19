import 'package:equatable/equatable.dart';
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
    'ProviderListener > StateProvider filters > select',
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
        expect(controller.state.counter, i);
        if (i < minValueToBeNotified) {
          expect(numberOfCalls, 0);
        }
      }
      expect(numberOfCalls, 4);
    },
  );

  testWidgets(
    'ProviderListener > StateProvider filters > when',
    (tester) async {
      int numberOfCalls = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: ProviderListener<_CounterController>(
            provider: _counterProvider.when(
              (prev, current) => prev.counter != current.counter,
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
      for (int i = 1; i <= 5; i++) {
        await tester.tap(find.text("add"));
        await tester.pump();
        expect(controller.state.counter, i);
      }
      expect(numberOfCalls, 5);
    },
  );
}

final _counterProvider = StateProvider<_CounterController, _State>(
  (_) => _CounterController(),
);

class _CounterController extends StateNotifier<_State> {
  _CounterController() : super(_State(0));

  void incremment() {
    state = state.update(
      state.counter + 1,
    );
  }
}

class _State extends Equatable {
  final int counter;

  _State(this.counter);

  _State update(int newValue) => _State(newValue);

  @override
  List<Object?> get props => [counter];
}
