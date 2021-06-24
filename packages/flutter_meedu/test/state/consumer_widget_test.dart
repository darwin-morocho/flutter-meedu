import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
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
            builder: (_, watch, __) {
              final controller = watch(
                _counterProvider.ids(() => ['66']),
              );
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
          body: Consumer(
            builder: (_, watch, __) {
              final controller = watch(
                _counterProvider.select((_) => _.counter),
              );
              number++;
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
    expect(number, 2);
  });

  testWidgets('consumer watch filter byIds test', (tester) async {
    int number = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                key: Key('button2'),
                onPressed: () {
                  _counterProvider.read.incrementById();
                },
                icon: Icon(Icons.add),
              )
            ],
          ),
          body: Consumer(
            builder: (_, watch, __) {
              final controller = watch(
                _counterProvider.ids(() => ['1']),
              );
              number++;
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
    expect(find.text("1"), findsNothing);
    expect(number, 1);

    await tester.tap(
      find.byKey(Key('button2')),
    );
    await tester.pump();
    expect(find.text("2"), findsOneWidget);
    expect(number, 2);
  });

  testWidgets('consumer - notify without ids', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Consumer(
            builder: (_, watch, __) {
              final counter = watch<CounterController, List>(
                _counterProvider.ids(() => ['66']),
              ).counter;
              return Text("${counter}");
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _counterProvider.read.incrementWithoutIds(),
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
}

class CounterController extends SimpleNotifier {
  int counter = 0;
  void increment() {
    counter++;
    notify(['66']);
  }

  void incrementById() {
    counter++;
    notify(['1']);
  }

  void incrementWithoutIds() {
    counter++;
    notify();
  }
}

final _counterProvider = SimpleProvider(
  (_) => CounterController(),
  autoDispose: false,
);
