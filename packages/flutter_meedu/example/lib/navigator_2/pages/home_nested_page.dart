import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

final homeKey = GlobalKey<NavigatorState>();

final homeDelegate = NestedRouterDelegate(
  navigatorKey: homeKey,
  initialRoutes: [
    MaterialPage(
      key: ValueKey('dashboard-tab'),
      name: '/dasboard',
      child: Text("DASHBOARD"),
    ),
    MaterialPage(
      key: ValueKey('profile-tab'),
      name: '/profile',
      child: Text("PROFILE"),
    )
  ],
);

class HomeNestedPage extends StatelessWidget {
  const HomeNestedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NestedRouterWidget(
        routerDelegate: homeDelegate,
      ),
    );
  }
}
