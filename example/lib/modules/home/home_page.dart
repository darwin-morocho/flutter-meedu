import 'package:flutter/material.dart';
import 'package:meedu/state.dart';
import 'package:meedu/router.dart' as router;
import '../numbers/numbers_page.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MeeduBuilder<HomeController>(
      controller: HomeController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MeeduBuilder<HomeController>(
                  id: 'counter',
                  builder: (controller) => Text(
                    "${controller.counter}\n counter",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                FlatButton(
                  onPressed: () {
                    router.pushNamed(NumbersPage.routeName, arguments: "este es un parametro");
                  },
                  child: Text("Go to Numbers Page"),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.incremment();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
