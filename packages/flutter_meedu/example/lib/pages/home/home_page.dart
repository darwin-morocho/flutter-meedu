import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/state.dart';
import 'package:meedu/meedu.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<HomeController>(
      create: (_) => HomeController(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleBuilder<HomeController>(
                  id: 'counter',
                  builder: (controller) => Text(
                    "${controller.counter}",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                CounterDetail(),
                SizedBox(height: 20),
                FlatButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    router.pushNamed(
                      '/login',
                    );
                  },
                  child: Text("StateController example"),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: SimpleBuilder<HomeController>(
          allowRebuild: false,
          builder: (_) => FloatingActionButton(
            onPressed: () {
              _.increment();
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class CounterDetail extends SimpleWidget<HomeController> {
  final String id = 'counter'; //  to allow rebuilds when the update(['counter']) method is called

  void onPressed() {
    controller.increment();
  }

  @override
  Widget buildChild(BuildContext context, HomeController controller) {
    return Column(
      children: [
        Text("${controller.counter}"),
        FlatButton(
          color: Colors.grey,
          onPressed: onPressed,
          child: Text("add value to counter"),
        ),
      ],
    );
  }
}
