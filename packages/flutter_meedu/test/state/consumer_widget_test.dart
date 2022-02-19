import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
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
              final controller = ref.watch(
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
            builder: (_, ref, __) {
              final controller = ref.watch(
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
            builder: (_, ref, __) {
              final counter = ref
                  .watch(
                    _counterProvider,
                  )
                  .counter;
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

  testWidgets('consumer > ids filter only using ref.watch', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Consumer(
            builder: (_, ref, __) {
              final counter = ref.select(
                _counterProvider.ids(() => ['id']),
              );
              return Text("${counter}");
            },
          ),
        ),
      ),
    );

    expect(
      tester.takeException(),
      isInstanceOf<AssertionError>(),
    );
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
