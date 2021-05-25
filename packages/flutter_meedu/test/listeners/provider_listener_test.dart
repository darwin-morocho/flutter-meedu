import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_meedu/router.dart' as router;

import '../state/consumer_widget_test.dart';

void main() {
  setUp(() {
    router.dispose();
  });
  testWidgets('provider listener test', (tester) async {
    int counter = 0;
    bool disposed = false, afterFirstlayout = false;
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: router.navigatorKey,
        navigatorObservers: [router.observer],
        initialRoute: '/',
        routes: {
          '/': (_) => Scaffold(
                body: TextButton(
                  child: Text("GO"),
                  onPressed: () => router.pushNamed('/counter'),
                ),
              ),
          '/counter': (_) => _CounterPage(
                onCounterChanged: (v) => counter = v,
                onDispose: () => disposed = true,
                onAfterFirstLayout: () => afterFirstlayout = true,
              ),
        },
      ),
    );
    expect(find.text("TAP"), findsNothing);
    await tester.tap(find.text("GO"));
    await tester.pumpAndSettle();
    expect(find.text("TAP"), findsOneWidget);
    await tester.tap(find.text("TAP"));
    await tester.pump();
    await tester.tap(find.text("TAP"));
    await tester.pump();
    expect(counter, 2);
    await tester.tap(find.byKey(Key('toggle-button')));
    await tester.pump();
    await tester.tap(find.text("TAP"));
    await tester.pump();
    expect(counter, 2);
    await tester.tap(find.byKey(Key('toggle-button')));
    await tester.pump();
    await tester.tap(find.text("TAP"));
    await tester.pump();
    expect(counter, 4);
    await tester.tap(find.byKey(Key('back-button')));
    await tester.pumpAndSettle();
    expect(find.text("TAP"), findsNothing);
    expect(disposed, true);
    expect(afterFirstlayout, true);
  });
}

final _counterProvider = SimpleProvider(
  (_) => CounterController(),
);

class _CounterPage extends StatefulWidget {
  final void Function(int) onCounterChanged;
  final VoidCallback onDispose, onAfterFirstLayout;

  const _CounterPage({
    Key? key,
    required this.onCounterChanged,
    required this.onDispose,
    required this.onAfterFirstLayout,
  }) : super(key: key);
  @override
  __CounterPageState createState() => __CounterPageState();
}

class __CounterPageState extends State<_CounterPage> {
  bool enabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: Key('back-button'),
          icon: Icon(Icons.backpack),
          onPressed: () => router.pop(),
        ),
        actions: [
          IconButton(
            key: Key('toggle-button'),
            onPressed: () {
              enabled = !enabled;
              setState(() {});
            },
            icon: Icon(Icons.ac_unit),
          ),
        ],
      ),
      body: ProviderListener<CounterController>(
        provider: _counterProvider,
        onChange: enabled
            ? (_, controller) {
                widget.onCounterChanged(controller.counter);
              }
            : null,
        onAfterFirstLayout: (_, __) => widget.onAfterFirstLayout(),
        onDispose: (_, __) => widget.onDispose(),
        builder: (_, controller) => TextButton(
          child: Text("TAP"),
          onPressed: () => controller.increment(),
        ),
      ),
    );
  }
}
