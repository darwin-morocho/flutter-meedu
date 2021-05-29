import 'package:flutter/widgets.dart';
import 'transition.dart';

///this class has the navigator state and the transition configuration
class MeeduNavigator {
  MeeduNavigator._();
  static final MeeduNavigator i = MeeduNavigator._();

  GlobalKey<NavigatorState>? _naviatorKey;

  /// return the navigator key
  GlobalKey<NavigatorState> get navigatorKey {
    _naviatorKey ??= GlobalKey<NavigatorState>();
    return _naviatorKey!;
  }

  /// use material transition as default transition
  Transition transition = Transition.material;

  /// default transition duration
  Duration transitionDuration = const Duration(milliseconds: 300);

  /// use this method for widget testing
  void dispose() {
    _naviatorKey?.currentState?.dispose();
    _naviatorKey = null;
  }
}
