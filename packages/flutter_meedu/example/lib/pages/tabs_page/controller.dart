import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';

class TabsController extends SimpleNotifier {
  final TabController tabController = TabController(
    length: 2,
    vsync: NavigatorState(),
  );

  @override
  void onDispose() {
    tabController.dispose();
    super.onDispose();
  }
}

final tabsProvider = SimpleProvider(
  (_) => TabsController(),
  autoDispose: false,
);
