import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/state.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  void onInit(BuildContext context, HomeController controller) {
    print("HomePage provider OnInit");
  }

  void onAfterFirstLayout(BuildContext context, HomeController controller) {
    print("HomePage provider onAfterFirstLayout");
  }

  void onDispose(BuildContext context, HomeController controller) {
    print("HomePage provider onDispose");
  }

  @override
  Widget build(BuildContext context) {
    return Provider<HomeController>(
      create: (_) => HomeController(),
      onInit: this.onInit,
      onAfterFirstLayout: this.onAfterFirstLayout,
      onDispose: this.onDispose,
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
                    router.pushReplacementNamed(
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
