import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';

class TabsController extends SimpleNotifier {
  TabsController({int? initialIndex}) {
    print("tabs initialized");
    tabController = TabController(
      length: 2,
      vsync: NavigatorState(),
      initialIndex: initialIndex ?? 0,
    );
  }

  late TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    print("tabs disposed");
    super.dispose();
  }
}

final tabsProvider = SimpleProvider(
  (_) => TabsController(initialIndex: _.arguments),
);
