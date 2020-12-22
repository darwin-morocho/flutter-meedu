import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/router.dart' as router;

void main() {
  testWidgets('transitions test', (test) async {
    router.setDefaultTransition(router.Transition.material, duration: Duration(milliseconds: 100));
    await test.pumpWidget(
      MaterialApp(
        navigatorKey: router.navigatorKey,
        home: HomePage(),
        routes: {
          '/detail': (_) => DetailPage(),
        },
      ),
    );

    await test.tap(find.text("downToUp"));
    await test.pumpAndSettle();
    await test.tap(find.text("back"));
    await test.pumpAndSettle();
    await test.tap(find.text("upToDown"));
    await test.pumpAndSettle();
    await test.tap(find.text("back"));
    await test.pumpAndSettle();
    await test.tap(find.text("fadeIn"));
    await test.pumpAndSettle();
    await test.tap(find.text("back"));
    await test.pumpAndSettle();
    await test.tap(find.text("rightToLeft"));
    await test.pumpAndSettle();
    await test.tap(find.text("back"));
    await test.pumpAndSettle();
    await test.tap(find.text("none"));
    await test.pumpAndSettle();
    await test.tap(find.text("back"));
    await test.pumpAndSettle();
    await test.tap(find.text("cupertino"));
    await test.pumpAndSettle();
    await test.tap(find.text("back"));
    await test.pumpAndSettle();
    await test.tap(find.text("pushNamedAndRemoveUntil"));
    await test.pumpAndSettle();
    expect(router.canPop(), false);
  });
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FlatButton(
            onPressed: () => router.push(
              DetailPage(),
              transition: router.Transition.downToUp,
              backGestureEnabled: true,
            ),
            child: Text("downToUp"),
          ),
          FlatButton(
            onPressed: () => router.push(DetailPage(), transition: router.Transition.upToDown),
            child: Text("upToDown"),
          ),
          FlatButton(
            onPressed: () => router.push(DetailPage(), transition: router.Transition.fadeIn),
            child: Text("fadeIn"),
          ),
          FlatButton(
            onPressed: () => router.push(DetailPage(), transition: router.Transition.rightToLeft),
            child: Text("rightToLeft"),
          ),
          FlatButton(
            onPressed: () => router.push(DetailPage(), transition: router.Transition.none),
            child: Text("none"),
          ),
          FlatButton(
            onPressed: () => router.push(DetailPage(), transition: router.Transition.cupertino),
            child: Text("cupertino"),
          ),
          FlatButton(
            onPressed: () => router.pushNamedAndRemoveUntil('/detail'),
            child: Text("pushNamedAndRemoveUntil"),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {
            router.pop();
          },
          child: Text("back"),
        ),
      ),
    );
  }
}
