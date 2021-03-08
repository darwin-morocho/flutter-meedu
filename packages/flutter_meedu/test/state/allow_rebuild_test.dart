import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meedu/meedu.dart';

void main() {
  testWidgets("allowRebuild test", (test) async {
    await test.pumpWidget(
      MaterialApp(
        home: HomePage(),
      ),
    );
    expect(find.text("counter:: 0"), findsOneWidget);
    await test.tap(find.text("add"));
    await test.pump();
    expect(find.text("counter:: 1"), findsOneWidget);
    await test.tap(find.text("toggle"));
    await test.pump();
    await test.tap(find.text("add"));
    await test.pump();
    expect(find.text("counter:: 1"), findsOneWidget);
    await test.tap(find.text("toggle"));
    await test.pump();
    await test.tap(find.text("add"));
    await test.pump();
    expect(find.text("counter:: 3"), findsOneWidget);
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Rx<bool> allow = true.obs;

  @override
  void dispose() {
    allow.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => Controller(),
      child: Column(
        children: [
          RxBuilder(
            observables: [allow],
            builder: (__) => SimpleBuilder<Controller>(
              allowRebuild: allow.value,
              builder: (_) => Text("counter:: ${_.counter}"),
            ),
          ),
          FlatButton(
            onPressed: () => Get.i.find<Controller>().imcrement(),
            child: Text("add"),
          ),
          FlatButton(
            onPressed: () => allow.value = !allow.value,
            child: Text("toggle"),
          )
        ],
      ),
    );
  }
}

class Controller extends SimpleController {
  int counter = 0;

  void imcrement() {
    counter++;
    update();
  }
}
