import 'package:flutter/widgets.dart';

class Navigator {
  Navigator._internal();
  static Navigator _instance = Navigator._internal();
  static Navigator get instance => _instance;

  final GlobalKey<NavigatorState> _navigatorKey =
      new GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  NavigatorState get state => _navigatorKey.currentState;
}
