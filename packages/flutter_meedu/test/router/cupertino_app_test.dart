import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/router.dart' as router;

void main() {
  setUp(() {
    router.dispose();
  });

  testWidgets(
    'CupertinoApp',
    (tester) async {
      router.setDefaultTransition(router.Transition.downToUp);
      await tester.pumpWidget(
        CupertinoApp(
          key: router.appKey,
          navigatorKey: router.navigatorKey,
          initialRoute: '/',
          routes: {
            '/': (_) => CupertinoPageScaffold(
                  child: Center(
                    child: Column(
                      children: [
                        CupertinoButton(
                          child: Text("push"),
                          onPressed: () => router.pushNamed(
                            '/popAndPushNamed',
                          ),
                        ),
                        CupertinoButton(
                          child: Text("pushNamedAndRemoveUntil"),
                          onPressed: () => router.pushNamedAndRemoveUntil(
                            '/',
                          ),
                        ),
                        CupertinoButton(
                          child: Text("popAndPushNamed cupertino"),
                          onPressed: () => router.popAndPushNamed(
                            '/',
                            transition: router.Transition.cupertino,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            '/popAndPushNamed': (_) => CupertinoPageScaffold(
                  child: Center(
                    child: CupertinoButton(
                      child: Text("popAndPushNamed"),
                      onPressed: () => router.pushNamed(
                        '/pushReplacement',
                      ),
                    ),
                  ),
                ),
            '/pushReplacement': (_) => CupertinoPageScaffold(
                  child: Center(
                    child: CupertinoButton(
                      child: Text("pushReplacement"),
                      onPressed: () => router.pushReplacementNamed(
                        '/',
                      ),
                    ),
                  ),
                )
          },
        ),
      );
      await tester.pump();
      expect(find.text("push"), findsOneWidget);
      await tester.tap(find.text("push"));
      await tester.pumpAndSettle();
      expect(find.text("popAndPushNamed"), findsOneWidget);
      expect(router.canPop(), true);
      await tester.tap(find.text("popAndPushNamed"));
      await tester.pumpAndSettle();
      expect(find.text("pushReplacement"), findsOneWidget);
      await tester.tap(find.text("pushReplacement"));
      await tester.pumpAndSettle();
      expect(find.text("push"), findsOneWidget);
      await tester.tap(find.text("pushNamedAndRemoveUntil"));
      await tester.pumpAndSettle();
      expect(router.canPop(), false);
      await tester.tap(find.text("popAndPushNamed cupertino"));
      await tester.pumpAndSettle();
      expect(router.canPop(), false);
    },
  );
}
