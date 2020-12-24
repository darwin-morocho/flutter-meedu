import 'dart:async';

import 'package:meedu/state.dart';

class HomeController extends SimpleController {
  int counter = 0;

  @override
  void onInit() {
    print("onInit");
  }

  @override
  void onAfterFirstLayout() {
    print("afterFirstLayout");
  }

  void increment() {
    counter++;
    update(['counter']);
  }

  @override
  void onDispose() {
    super.onDispose();
  }
}
