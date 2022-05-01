import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/ui.dart';

void main() {
  setUp(() {
    router.dispose();
  });
  group('navigation', () {
    testWidgets('normal navigation', (test) async {
      router.setDefaultTransition(
        Transition.material,
        duration: Duration(milliseconds: 100),
      );
      await test.pumpWidget(
        MaterialApp(
          navigatorKey: router.navigatorKey,
          home: HomePage(),
          navigatorObservers: [
            router.observer,
          ],
          routes: {
            'detail': (_) => DetailPage(),
          },
        ),
      );
      expect(router.canPop(), false);
      expect(router.settings.name, "/");
      expect(router.arguments, isNull);
      await test.tap(find.text("pushNamed"));
      await test.pumpAndSettle();
      expect(router.arguments, "meedu");
      expect(find.text("meedu"), findsOneWidget);
      expect(router.canPop(), true);
      await test.tap(find.text("back"));
      await test.pumpAndSettle();
      expect(find.text("meedu"), findsNothing);
      expect(router.arguments, isNull);
      await test.tap(find.text("pushReplacement"));
      await test.pumpAndSettle();
      expect(find.text("meedu"), findsOneWidget);
      expect(router.arguments, "meedu");
      expect(router.canPop(), false);
      await test.tap(find.byType(FloatingActionButton));
      await test.pumpAndSettle();
      expect(router.settings.name, "/");
      expect(router.arguments, "works");
      await test.tap(find.byType(IconButton));
      await test.pumpAndSettle();
      expect(find.text("GREAT"), findsOneWidget);
    });
  });

  testWidgets('popAndPushNamed', (tester) async {
    router.setDefaultTransition(Transition.downToUp);
    await tester.pumpWidget(
      MaterialApp(
        key: router.appKey,
        initialRoute: '/',
        navigatorKey: router.navigatorKey,
        navigatorObservers: [
          router.observer,
        ],
        routes: {
          '/': (_) => HomePage(),
          '/detail': (_) => DetailPage(),
        },
      ),
    );
    expect(router.context, isNotNull);
    await tester.tap(find.text("popAndPushNamed"));
    await tester.pumpAndSettle();
    expect(find.text("meedu"), findsOneWidget);
    expect(find.text("popAndPushNamed"), findsNothing);
  });

  testWidgets('initial arguments', (tester) async {
    router.setDefaultTransition(Transition.downToUp);
    await tester.pumpWidget(
      MaterialApp(
        key: router.appKey,
        onGenerateInitialRoutes: (String name) {
          return [
            MaterialPageRoute(
              builder: (_) => DetailPage(),
              settings: RouteSettings(
                name: name,
                arguments: "meedu",
              ),
            ),
          ];
        },
        navigatorKey: router.navigatorKey,
        initialRoute: '/',
        navigatorObservers: [
          router.observer,
        ],
        routes: {
          '/demo': (_) => Container(),
        },
      ),
    );

    expect(find.text("meedu"), findsOneWidget);
  });
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                router.pushReplacement(
                  DetailPage(),
                  arguments: "meedu",
                  transition: Transition.zoom,
                  transitionDuration: Duration(milliseconds: 100),
                );
              },
              child: Text("pushReplacement"),
            ),
            TextButton(
              onPressed: () {
                router.popAndPushNamed('/detail', arguments: 'meedu');
              },
              child: Text("popAndPushNamed"),
            ),
            TextButton(
              onPressed: () {
                router.pushNamed(
                  'detail',
                  arguments: "meedu",
                );
              },
              child: Text("pushNamed"),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => router.pushAndRemoveUntil(
                Scaffold(
                  body: Center(
                    child: Text('GREAT'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productName = router.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            router.popUntil((route) {
              print(" route.settings.name ${route.settings.name}");
              return route.settings.name == '/';
            });
          },
          child: Text("back"),
        ),
      ),
      body: Text(productName),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            router.pushNamedAndRemoveUntil('/', arguments: 'works'),
      ),
    );
  }
}
