import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:meedu_example/routes/routes.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text("Counter"),
            onTap: () => router.pushNamed(
              Routes.COUNTER,
              transition: router.Transition.upToDown,
              backGestureEnabled: false,
            ),
          ),
          ListTile(
            title: Text("Login Form"),
            onTap: () => router.pushNamed(Routes.LOGIN),
          ),
          ListTile(
            title: Text("Video player"),
            onTap: () => router.pushNamed(Routes.VIDEO),
          ),
          ListTile(
            title: Text("Simple Tag Example"),
            onTap: () => router.pushNamed(Routes.SIMPLE_TAG),
          ),
          ListTile(
            title: Text("State Tag Example"),
            onTap: () => router.pushNamed(Routes.STATE_TAG),
          ),
          ListTile(
            title: Text("MultiProvider Example"),
            onTap: () => router.pushNamed(Routes.MULTI_PROVIDER),
          )
        ],
      ),
    );
  }
}
