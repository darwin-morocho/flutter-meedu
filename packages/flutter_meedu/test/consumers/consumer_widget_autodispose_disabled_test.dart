import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meedu/notifiers.dart';
import 'package:meedu/provider/provider.dart';
import 'package:meedu/provider/providers_container.dart';

void main() {
  setUp(ProvidersContainer.clear);

  testWidgets(
    'Auto dispose disabled',
    (test) async {
      await test.pumpWidget(
        MaterialApp(
          home: HomeView(),
        ),
      );

      expect(_provider.mounted(), false);
      await test.tap(find.text("go"));
      await test.pumpAndSettle();
      expect(find.text("0"), findsWidgets);
      expect(_provider.mounted(), true);
      await test.tap(find.byType(FloatingActionButton));
      await test.pump();
      expect(find.text("1"), findsWidgets);
      await test.pageBack();
      await test.pumpAndSettle();
      expect(find.text("1"), findsNothing);
      expect(_provider.mounted(), true);
    },
  );
}

final _provider = Provider.state<CounterController, int>(
  (_) => CounterController(),
  autoDispose: false,
);

class CounterController extends StateNotifier<int> {
  CounterController() : super(0);
  void increment() => state++;
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CounterView(),
            ),
          ),
          child: Text('go'),
        ),
      ),
    );
  }
}

class CounterView extends ConsumerWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(_provider);
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: bloc.increment,
      ),
      body: Center(
        child: Text(bloc.state.toString()),
      ),
    );
  }
}
