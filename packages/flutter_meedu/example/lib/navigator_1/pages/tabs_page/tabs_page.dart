import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:meedu_example/navigator_1/routes/routes.dart';

import 'controller.dart';
import 'tabs/home/home_tab.dart';


class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final _controller = tabsProvider.read;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: TabBarView(
          controller: _controller.tabController,
          children: [
            HomeTab(),
            Container(
              alignment: Alignment.center,
              child: TextButton(
                child: Text("Push to VIDEO\n and remove until MENU"),
                onPressed: () {
                  router.pushNamedAndRemoveUntil(
                    Routes.VIDEO,
                    predicate: (route) => route.settings.name == Routes.MENU,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: TabBar(
          controller: _controller.tabController,
          tabs: [
            Tab(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
