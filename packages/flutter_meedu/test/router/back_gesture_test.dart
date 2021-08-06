import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_meedu/router.dart' as router;

void main() {
  setUp(() {
    router.dispose();
  });
  testWidgets('back gesture', (tester) async {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
     
        navigatorKey: router.navigatorKey,
        home: Scaffold(
          body: Center(
            child: TextButton(
              child: Text("GO"),
              onPressed: () => router.push(
                Scaffold(
                  key: _scaffoldKey,
                  body: Center(
                    child: Text("SECOND"),
                  ),
                ),
                backGestureEnabled: true,
                transitionDuration: Duration(milliseconds: 100),
                transition: router.Transition.rightToLeft,
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text("SECOND"), findsNothing);
    await tester.tap(find.text("GO"));
    await tester.pumpAndSettle();
    expect(find.text("SECOND"), findsOneWidget);
    final size = _scaffoldKey.currentContext!.size!;
    await tester.dragFrom(Offset.zero, Offset(size.width * 0.6, 0));
    await tester.pumpAndSettle();
    expect(find.text("SECOND"), findsNothing);
  });
}
