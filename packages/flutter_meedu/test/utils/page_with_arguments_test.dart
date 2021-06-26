import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('screen utils', (tester) async {
    int counter = 0;
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (_) => _Page(),
          '/two': (_) => PageWithArguments(
                onReady: (settings) {
                  counter++;
                },
                builder: (_) => Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      child: Text("go"),
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        _,
                        '/',
                        (_) => false,
                      ),
                    ),
                  ),
                ),
              ),
        },
      ),
    );
    await tester.pump();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text("go"), findsOneWidget);
    expect(counter, 1);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.text("go"), findsNothing);
    expect(counter, 1);
  });
}

class _Page extends StatefulWidget {
  const _Page({Key? key}) : super(key: key);

  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/two');
        },
      ),
    );
  }
}
