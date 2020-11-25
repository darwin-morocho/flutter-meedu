import 'package:flutter/material.dart';
import 'package:meedu/meedu.dart';

import '../numbers/numbers_page.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MeeduProvider<HomeController>(
      controller: HomeController(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MeeduBuilder<HomeController>(
                  id: 'counter',
                  builder: (_, controller) => Text(
                    "${controller.counter}\n counter",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, NumbersPage.routeName);
                  },
                  child: Text("Go to Numbers Page"),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: MeeduBuilder<HomeController>(
          builder: (_, __) => FloatingActionButton(
            onPressed: () {
              __.incremment();
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
