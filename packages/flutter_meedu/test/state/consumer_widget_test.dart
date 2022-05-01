import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() {
    _counterProvider.dispose();
  });
  testWidgets('consumer test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Consumer(
            builder: (_, ref, __) {
              final controller = ref.watch(_counterProvider);
              return Text("${controller.counter}");
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _counterProvider.read.increment(),
            key: Key('button'),
          ),
        ),
      ),
    );

    expect(find.text("0"), findsOneWidget);
    await tester.tap(
      find.byKey(Key('button')),
    );
    await tester.pump();
    expect(find.text("1"), findsOneWidget);
  });

  testWidgets('consumer watch filter bySelect test', (tester) async {
    int number = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Consumer(
                builder: (_, ref, __) {
                  final controller = ref.watch(
                    _counterProvider.select((_) => _.counter),
                  );
                  number++;
                  return Text("consumer ${controller.counter}");
                },
              ),
              Consumer(
                builder: (_, ref, __) {
                  final counter = ref.select(
                    _counterProvider.select((_) => _.counter),
                  );
                  return Text("select $counter");
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _counterProvider.read.increment(),
            key: Key('button'),
          ),
        ),
      ),
    );

    expect(find.text("consumer 0"), findsOneWidget);
    expect(find.text("select 0"), findsOneWidget);
    await tester.tap(
      find.byKey(Key('button')),
    );
    await tester.pump();
    expect(find.text("consumer 1"), findsOneWidget);
    expect(find.text("select 1"), findsOneWidget);
    expect(number, 2);
  });
}

class CounterController extends SimpleNotifier {
  int counter = 0;
  void increment() {
    counter++;
    notify();
  }
}

final _counterProvider = SimpleProvider(
  (_) => CounterController(),
  autoDispose: false,
);
