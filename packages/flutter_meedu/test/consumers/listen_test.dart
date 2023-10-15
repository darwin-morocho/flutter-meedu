import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_meedu/notifiers.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:flutter_test/flutter_test.dart';

int _index = 0;
int _selectIndex = 0;
int _whenIndex = 0;
int _builds = 0;

void main() {
  setUp(
    () {
      _index = 0;
      _selectIndex = 0;
      _whenIndex = 0;
      _builds = 0;
      ProvidersContainer.clear();
    },
  );

  testWidgets(
    'ref.listen',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            floatingActionButton: Builder(
              builder: (context) => FloatingActionButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyWidget(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(
        find.byType(FloatingActionButton),
        findsOneWidget,
      );
      expect(
        counterProvider.mounted(),
        false,
      );
      await tester.tap(
        find.byType(FloatingActionButton),
      );
      await tester.pumpAndSettle();
      expect(
        counterProvider.mounted(),
        true,
      );
      expect(_index, 0);
      expect(_builds, 1);
      counterProvider.read().increment();
      counterProvider.read().increment();
      expect(_selectIndex, 0);
      counterProvider.read().increment();
      expect(_builds, 1);
      expect(_index, 3);
      expect(_selectIndex, 1);
      expect(_whenIndex, 3);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(
        counterProvider.mounted(),
        false,
      );
    },
  );
}

class MyWidget extends ConsumerWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context, BuilderRef ref) {
    ref.watch(counterProvider);
    ref.listen(
      counterProvider,
      callback: (notifier) {
        _index++;
      },
    );

    ref.listen(
      counterProvider.select(
        (counter) => counter > 2,
        booleanCallback: true,
      ),
      callback: (notifier) {
        _selectIndex++;
      },
    );

    ref.listen(
      counterProvider.when(
        (prev, current) => prev != current,
      ),
      callback: (notifier) {
        _whenIndex++;
      },
    );

    _builds++;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Hello world',
        ),
      ),
    );
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(0),
);

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(super.initialState);
  void increment() {
    state++;
  }
}
