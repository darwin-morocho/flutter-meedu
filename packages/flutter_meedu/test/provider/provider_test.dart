import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Provider > TabController',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          key: router.appKey,
          navigatorKey: router.navigatorKey,
          navigatorObservers: [
            router.observer,
          ],
          home: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                router.push(
                  const HomePage(),
                );
              },
            ),
          ),
        ),
      );

      expect(homePageTabBarProvider.mounted, false);
      await tester.tap(
        find.byType(FloatingActionButton),
      );
      await tester.pumpAndSettle();
      expect(find.text('Home tab'), findsOneWidget);
      expect(homePageTabBarProvider.mounted, true);
      await tester.tap(
        find.byIcon(Icons.person),
      );
      await tester.pumpAndSettle();
      expect(find.text('Profile tab'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(homePageTabBarProvider.mounted, false);
    },
  );
}

final homePageTabBarProvider = Provider(
  (ref) {
    final controller = ref.arguments as TabController;
    ref.onDispose(
      controller.dispose,
    );
    return controller;
  },
  autoDispose: false,
);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    homePageTabBarProvider.setArguments(
      TabController(
        length: 2,
        vsync: this,
      ),
    );
  }

  @override
  void dispose() {
    homePageTabBarProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomTabBar(),
      body: SafeArea(
        child: TabBarView(
          controller: homePageTabBarProvider.read,
          children: [
            Center(
              child: Text('Home tab'),
            ),
            Center(
              child: Text('Profile tab'),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget with PreferredSizeWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: TabBar(
        controller: homePageTabBarProvider.read,
        tabs: [
          Tab(
            text: 'Home',
            icon: Icon(Icons.home),
          ),
          Tab(
            text: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 2);
}
