import 'package:flutter/material.dart';

class MNavigator {
  MNavigator._internal();
  static MNavigator _instance = MNavigator._internal();
  static MNavigator get instance => _instance;

  final GlobalKey<NavigatorState> _navigatorKey =
      new GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  NavigatorState get state => _navigatorKey.currentState;
}
