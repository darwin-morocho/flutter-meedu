import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_meedu/notifiers.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:flutter_test/flutter_test.dart';

final counterProvider = StateNotifierProvider<CounterNotifier, int>(
  (_) => CounterNotifier(0),
);

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(super.initialState);

  void increment() {
    state++;
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer(
            builder: (_, ref, __) {
              final counter1 = ref.watch(counterProvider, tag: '1').state;
              final counter2 = ref.watch(counterProvider, tag: '2').state;
              return Text('counter1=$counter1, counter2=$counter2');
            },
          ),
          TextButton(
            onPressed: () => counterProvider.read(tag: '1').increment(),
            child: Text('increment counter 1'),
          ),
          TextButton(
            onPressed: () => counterProvider.read(tag: '2').increment(),
            child: Text('increment counter 2'),
          ),
        ],
      ),
    );
  }
}

void main() {
  setUp(ProvidersContainer.clear);

  testWidgets(
    'Tags',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CounterWidget(),
        ),
      );
      expect(find.text('counter1=0, counter2=0'), findsOneWidget);
      await tester.tap(find.text('increment counter 1'));
      await tester.pump();
      expect(find.text('counter1=1, counter2=0'), findsOneWidget);
      await tester.tap(find.text('increment counter 2'));
      await tester.tap(find.text('increment counter 2'));
      await tester.pump();
      expect(find.text('counter1=1, counter2=2'), findsOneWidget);
    },
  );
}
