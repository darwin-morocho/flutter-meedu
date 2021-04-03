import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu/meedu.dart';
import 'package:meedu/state.dart';

class CounterController extends SimpleNotifier {
  int counter = 0;
  void increment() {
    counter++;
    update(['id']);
  }
}

class LoginController extends SimpleNotifier {
  String email = '';
  void onEmailChanged(String text) {
    email = text;
    update();
  }
}

final counterProvider = SimpleProvider((ref) => CounterController());

final SimpleProvider<LoginController> loginProvider = SimpleProvider((ref) {
  ref.read(counterProvider).increment();
  ref.onDispose(() {});

  return LoginController();
});

class SimpleProviderPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CounterPage(),
          ),
          Expanded(
            child: LoginPage(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.read.increment();
        },
      ),
    );
  }
}

class CounterPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final counter = watch(
      counterProvider,
      SimpleFilter(
        ['id'],
      ),
    ).counter;
    return Scaffold(
      body: Center(
        child: Text("$counter"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.read.increment();
        },
      ),
    );
  }
}

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final email = watch(
      loginProvider,
      SimpleFilter(
        ['id'],
      ),
    ).email;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(email),
              CupertinoTextField(
                placeholder: "kakakak",
                onChanged: loginProvider.read.onEmailChanged,
              ),
              CupertinoButton(
                child: Text("jaja"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
