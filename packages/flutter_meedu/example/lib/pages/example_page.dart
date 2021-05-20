import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<ExampleController>(
      provider: providerExample,
      onAfterFirstLayout: (_, notifier) {},
      onChange: (_, controller) {
        // print(controller.dateAsString);
        router.pushReplacement(Scaffold());
      },
      builder: (_, __) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                router.pushReplacement(Scaffold());
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            providerExample.read.update();
          },
        ),
        body: SafeArea(
          child: Consumer(
            builder: (_, watch, child) {
              final dateAsString = watch(providerExample).dateAsString;
              return Column(
                children: [
                  child!,
                  Text("HOLA MUNDO $dateAsString"),
                ],
              );
            },
            child: Icon(Icons.face),
          ),
        ),
      ),
    );
  }
}

class ExampleController extends SimpleNotifier {
  late String dateAsString;
  ExampleController(this.dateAsString) {
    print("ExampleController created");
  }

  update() {
    dateAsString = DateTime.now().toString();
    notify();
  }

  @override
  void onDispose() {
    print("dispose ExampleController");
    super.onDispose();
  }
}

class SessionController extends SimpleNotifier {
  String get name => DateTime.now().toString();
}

final sessionProvider = SimpleProvider(
  (_) => SessionController(),
);

final providerExample = SimpleProvider<ExampleController>(
  (_) => ExampleController(
    _.read(sessionProvider).name,
  ),
);
