import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meedu/state.dart';

void main() {
  group('Simple Controller', () {
    test('BaseBuilder builder!=null', () {
      expect(() {
        SimpleBuilder(
          builder: null,
        );
      }, throwsAssertionError);
    });

    test('Invalid update', () {
      final Controller controller = Controller();
      expect(() {
        controller.update(null);
      }, throwsAssertionError);
    });

    test('Call after dispose', () {
      final Controller controller = Controller();
      controller.onDispose();
      expect(() {
        controller.update([]);
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
                    CounterDetail(),
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
      expect(find.text(":: 3"), findsOneWidget);
      await test.tap(find.text("add"));
      await test.pump();
      expect(find.text("4"), findsWidgets);
      expect(find.text(":: 4"), findsOneWidget);
    });
  });
}

class Controller extends SimpleController {
  int counter = 0;

  void increment() {
    counter++;
    update();
  }

  @override
  void onAfterFirstLayout() {
    print("👉 afterFirstLayout SimpleController");
  }

  void incrementWithId() {
    counter++;
    update(['id']);
  }
}

class CounterDetail extends SimpleWidget<Controller> {
  String get id => 'id'; //  to allow rebuilds when the update(['counter']) method is called

  void onPressed() {
    controller.increment();
  }

  @override
  Widget buildChild(BuildContext context, Controller controller) {
    return Column(
      children: [
        Text(":: ${controller.counter}"),
        FlatButton(
          color: Colors.grey,
          onPressed: onPressed,
          child: Text("add"),
        ),
      ],
    );
  }
}
