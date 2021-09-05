import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../state/consumer_widget_test.dart';
import '../state/state_controller_test.dart';
import 'package:flutter_meedu/router.dart' as router;

bool _counterCalled = false, _loginCalled = false;
void main() {
  setUp(() {
    _counterCalled = false;
    _loginCalled = false;
    router.dispose();
  });
  tearDown(() {
    ProviderScope.clear();
  });

  testWidgets(
    "multi provider test",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: router.navigatorKey,
          navigatorObservers: [
            router.observer,
          ],
          home: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => router.push(
                MultiProviderPage(),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      await tester.tap(find.byKey(Key('reload')));
      await tester.pump();
      await tester.enterText(find.byType(CupertinoTextField), 'test@test.com');
      await tester.pump();
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(_counterCalled, true);
      expect(_loginCalled, true);
    },
  );
}

final _conterProvider = SimpleProvider(
  (_) => CounterController(),
);

final _loginProvider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);

class MultiProviderPage extends StatefulWidget {
  const MultiProviderPage({Key? key}) : super(key: key);

  @override
  _MultiProviderPageState createState() => _MultiProviderPageState();
}

class _MultiProviderPageState extends State<MultiProviderPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProviderListener(
      onInitState: (_) {},
      onAfterFirstLayout: (_) {},
      onDispose: (_) {},
      items: [
        MultiProviderListenerItem<CounterController>(
          provider: _conterProvider,
          onChange: (_, controller) {
            print("🔥 ${controller.counter}");
            _counterCalled = true;
          },
        ),
        MultiProviderListenerItem<LoginController>(
          provider: _loginProvider,
          onChange: (_, controller) {
            print("🥶 ${controller.state.email}");
            _loginCalled = true;
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              key: Key('reload'),
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.pedal_bike),
            ),
          ],
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Consumer(
                    builder: (_, watch, __) {
                      final counter = watch(
                        _conterProvider.ids(() => ['66']),
                      ).counter;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("$counter"),
                          SizedBox(height: 20),
                          ElevatedButton(
                            key: Key('increment'),
                            onPressed: () {
                              _conterProvider.read.increment();
                            },
                            child: Icon(Icons.add),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Consumer(
                    builder: (_, watch, __) {
                      final controller = watch(_loginProvider);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${controller.state.email}"),
                            SizedBox(height: 20),
                            CupertinoTextField(
                              key: Key('onEmailChanged'),
                              onChanged: controller.onEmailChanged,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
