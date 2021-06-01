import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meedu/state.dart';

void main() {
  group('Simple Controller', () {
    test('Call after dispose', () {
      final Controller controller = Controller();
      controller.onDispose();
      expect(() {
        controller.notify([]);
      }, throwsAssertionError);
    });
    testWidgets("MeeduController counter", (test) async {
      final incrementButtonKey = Key('incrementButtonKey');
      final incrementButtonIdKey = Key('incrementButtonIdKey');
      final withIdTextKey = Key('withIdTextKey');
      final withoutTextKey = Key('withoutIdTextKey');

      await test.pumpWidget(
        MaterialApp(
          home: Provider<Controller>(
            create: (_) => Controller(),
            onInit: (BuildContext context, Controller controller) {
              print("Provider OnInit");
            },
            onAfterFirstLayout: (BuildContext context, Controller controller) {
              print("Provider onAfterFirstLayout");
            },
            builder: (_, __, ___) => Scaffold(
              body: Center(
                child: Column(
                  children: [
                    //its value must be always 0
                    SimpleBuilder<Controller>(
                      allowRebuild: false,
                      builder: (context, _) => Text("${_.counter}"),
                    ),
                    // its value must change when call update() without ids
                    SimpleBuilder<Controller>(
                      key: withoutTextKey,
                      builder: (context, _) => Text("${_.counter}"),
                    ),
                    // its value must change when call update() or  update(['id'])
                    SimpleBuilder<Controller>(
                      key: withIdTextKey,
                      id: 'id',
                      builder: (context, _) => Text("${_.counter}"),
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
                        Provider.of<Controller>().increment();
                      },
                    ),
                    FloatingActionButton(
                      key: incrementButtonIdKey,
                      onPressed: () {
                        Provider.of<Controller>().incrementWithId();
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

    testWidgets("SimpleWidget counter", (test) async {
      await test.pumpWidget(
        MaterialApp(
          home: Provider<Controller>(
            create: (_) => Controller(),
            builder: (_, controller, ___) => Scaffold(
              body: Center(
                child: CounterDetail(),
              ),
            ),
          ),
        ),
      );

      expect(find.text("0"), findsWidgets);
      await test.tap(find.text("add"));
      await test.pump();
      expect(find.text("1"), findsWidgets);
    });
  });
}

class Controller extends SimpleNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notify();
  }

  @override
  void onAfterFirstLayout() {
    print("👉 afterFirstLayout SimpleController");
  }

  void incrementWithId() {
    counter++;
    notify(['id']);
  }
}

class CounterDetail extends SimpleWidget<Controller> {
  @override
  String? get id => 'id'; //  to allow rebuilds when the update(['id']) method is called

  void onPressed() {
    controller.incrementWithId();
  }

  @override
  Widget buildChild(BuildContext context, Controller controller) {
    return Column(
      children: [
        Text("${controller.counter}"),
        TextButton(
          onPressed: onPressed,
          child: Text("add"),
        ),
      ],
    );
  }
}
