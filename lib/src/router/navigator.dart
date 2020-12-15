import 'package:flutter/widgets.dart';
import 'package:meedu/src/router/transition.dart';

///this class has the navigator state and the transition configuration
class MeeduNavigator {
  MeeduNavigator._internal();
  static final MeeduNavigator _instance = MeeduNavigator._internal();
  static MeeduNavigator get instance => _instance;

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  NavigatorState get state => navigatorKey.currentState;
  Transition transition = Transition.material;
  Duration transitionDuration = const Duration(milliseconds: 300);
}
