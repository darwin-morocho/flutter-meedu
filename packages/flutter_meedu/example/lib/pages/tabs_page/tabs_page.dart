import 'package:flutter/material.dart';
import 'package:meedu_example/pages/home/home_provider.dart';
import 'package:meedu_example/pages/tabs_page/controller.dart';
import 'package:meedu_example/pages/tabs_page/tabs/home/home_tab.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:meedu_example/routes/routes.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final _controller = tabsProvider.read;

  @override
  void dispose() {
    tabsProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: _controller.tabController,
          children: [
            HomeTab(),
            Container(
              alignment: Alignment.center,
              child: TextButton(
                child: Text("log out"),
                onPressed: () {
                  router.pushNamedAndRemoveUntil(Routes.LOGIN);
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
