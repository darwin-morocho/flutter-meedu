import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hooks_meedu/hooks_meedu.dart';

void main() {
  setUp(
    () {
      ProvidersContainer.clear();
    },
  );
  testWidgets(
    'HookConsumerWidget',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HookConsumerTest(),
        ),
      );

      expect(
        find.text('provider 0'),
        findsOneWidget,
      );
      expect(
        find.text('useState 0'),
        findsOneWidget,
      );
      expect(
        find.text('text '),
        findsOneWidget,
      );

      await tester.tap(
        find.byIcon(Icons.person),
      );
      await tester.pump();
      expect(
        find.text('useState 1'),
        findsOneWidget,
      );

      expect(
        find.text('provider 0'),
        findsOneWidget,
      );

      await tester.tap(
        find.byIcon(Icons.add),
      );
      await tester.pump();
      expect(
        find.text('provider 1'),
        findsOneWidget,
      );

      await tester.tap(
        find.byIcon(Icons.abc),
      );
      await tester.pump();

      expect(
        find.text('text meedu'),
        findsOneWidget,
      );
    },
  );

  testWidgets('HookConsumerStatefulWidget', (tester) async {
    await tester.pumpWidget(
      const HookStatefulTest(),
    );

    expect(find.text('0 0 0'), findsOneWidget);

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    expect(find.text('0 1 1'), findsOneWidget);
  });
}

final provider = StateNotifierProvider<CounterBloc, int>(
  (_) => CounterBloc(0),
);

class CounterBloc extends StateNotifier<int> {
  CounterBloc(super.initialState);

  void increment() {
    state++;
  }
}

class HookConsumerTest extends HookConsumerWidget {
  const HookConsumerTest({super.key});

  @override
  Widget build(BuildContext context, BuilderRef ref) {
    final count = useState(0);

    return Scaffold(
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            child: const Icon(Icons.person),
            onPressed: () {
              count.value++;
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              provider.read().increment();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'provider ${ref.watch(provider).state}',
          ),
          Text(
            'useState ${count.value}',
          ),
          HookConsumer(
            builder: (_, ref, child) {
              final text = useState("");
              return Column(
                children: [
                  child!,
                  Text(
                    'text ${text.value}',
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.abc),
                    onPressed: () {
                      text.value = 'meedu';
                    },
                  ),
                ],
              );
            },
            child: const Icon(Icons.emoji_emotions),
          )
        ],
      ),
    );
  }
}

class HookStatefulTest extends StatefulHookConsumerWidget {
  const HookStatefulTest({super.key});

  @override
  HookStatefulTestState createState() => HookStatefulTestState();
}

class HookStatefulTestState extends ConsumerState<HookStatefulTest> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final count2 = useState(0);

    return GestureDetector(
      onTap: () {
        count2.value++;
        setState(() => count++);
      },
      child: Text(
        '${ref.watch(provider).state} $count ${count2.value}',
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
