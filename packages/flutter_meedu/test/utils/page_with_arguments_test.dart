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

  testWidgets('PageWithArgumentsWidget', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: _Page2(),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
      ),
    );
    expect(find.text("10"), findsOneWidget);
    expect(find.text("true"), findsOneWidget);
    await tester.tap(
      find.byType(FloatingActionButton),
    );
    await tester.pump();
    expect(find.text("11"), findsOneWidget);
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

class _CounterController extends SimpleNotifier {
  late int counter;
  _CounterController(this.counter);

  void increment() {
    counter++;
    notify();
  }
}

final _counterProvider = SimpleProvider(
  (ref) => _CounterController(ref.arguments ?? 0),
);

class _Page2 extends PageWithArgumentsWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer(builder: (_, ref, __) {
            final counter = ref.watch(_counterProvider).counter;
            return Text(
              counter.toString(),
            );
          }),
          Text(
            context.isDarkMode.toString(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counterProvider.read.increment();
        },
      ),
    );
  }

  @override
  void onInit(RouteSettings settings) {
    _counterProvider.setArguments(10);
  }
}
