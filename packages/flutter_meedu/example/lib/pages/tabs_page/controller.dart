import 'package:flutter/material.dart';
import 'package:meedu/meedu.dart';
import 'package:meedu/state.dart';

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
