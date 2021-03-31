import 'package:flutter/widgets.dart';
import 'transition.dart';

///this class has the navigator state and the transition configuration
class MeeduNavigator {
  MeeduNavigator._();
  static final MeeduNavigator i = MeeduNavigator._();

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Transition transition = Transition.material;
  Duration transitionDuration = const Duration(milliseconds: 300);
}
