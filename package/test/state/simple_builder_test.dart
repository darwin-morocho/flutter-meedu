import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meedu/state.dart';

void main() {
  testWidgets("MeeduController counter", (test) async {
    final incrementButtonKey = Key('incrementButtonKey');
    final incrementButtonIdKey = Key('incrementButtonIdKey');
    final withIdTextKey = Key('withIdTextKey');
    final withoutTextKey = Key('withoutIdTextKey');

    await test.pumpWidget(
      MaterialApp(
        home: Provider<Controller>(
          create: (_) => Controller(),
          child: Scaffold(
            body: Center(
              child: Column(
                children: [
                  //its value must be always 0
                  SimpleBuilder<Controller>(
                    allowRebuild: false,
                    builder: (_) => Text("${_.counter}"),
                  ),
                  // its value must change when call update() without ids
                  SimpleBuilder<Controller>(
                    key: withoutTextKey,
                    builder: (_) => Text("${_.counter}"),
                  ),
                  // its value must change when call update() or  update(['id'])
                  SimpleBuilder<Controller>(
                    key: withIdTextKey,
                    id: 'id',
                    builder: (_) => Text("${_.counter}"),
                  ),
                ],
              ),
            ),
            floatingActionButton: Builder(
              builder: (context) => Row(
                children: [
                  FloatingActionButton(
                    key: incrementButtonKey,
                    onPressed: () {
                      Provider.of<Controller>(context).increment();
                    },
                  ),
                  FloatingActionButton(
                    key: incrementButtonIdKey,
                    onPressed: () {
                      Provider.of<Controller>(context).incrementWithId();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text("0"), findsWidgets);
    await test.tap(find.byKey(incrementButtonIdKey));
    await test.pump();
    expect(find.text("0"), findsWidgets);
    expect(find.text("1"), findsOneWidget);
    await test.tap(find.byKey(incrementButtonKey));
    await test.tap(find.byKey(incrementButtonKey));
    await test.pump();
    expect(find.text("0"), findsOneWidget);
    expect(find.text("3"), findsWidgets);
  });
}

class Controller extends SimpleController {
  int counter = 0;

  void increment() {
    counter++;
    update();
  }

  void incrementWithId() {
    counter++;
    update(['id']);
  }
}
