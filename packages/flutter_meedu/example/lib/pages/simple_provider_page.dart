import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu/meedu.dart';
import 'package:meedu/state.dart';
import 'package:flutter_meedu/router.dart' as router;

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

final counterProvider = SimpleProvider.autoDispose<CounterController>(
  (ref) {
    ref.onDispose(() {
      print("counterProvider disposed");
    });
    return CounterController();
  },
);

final loginProvider = SimpleProvider((_) => LoginController());

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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              router.pushReplacement(LoginPage());
            },
          )
        ],
      ),
      body: Center(
        child: Text("->> $counter"),
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
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text(email),
              CupertinoTextField(
                placeholder: "",
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
