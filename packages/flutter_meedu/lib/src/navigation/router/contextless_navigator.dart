import 'package:flutter/widgets.dart';

import '../transitions/transition.dart';

///this class has the navigator state and the transition configuration
class ContextlessNavigator {
  ContextlessNavigator._();

  /// expose the MeeduNavigator soingleton
  static final ContextlessNavigator i = ContextlessNavigator._();

  GlobalKey<NavigatorState>? _navigatorKey;
  GlobalKey? _appKey;

  RouteSettings? _currentRouteSettings;

  /// store the current route settings
  RouteSettings? get routeSettings => _currentRouteSettings;

  /// return the navigator key
  GlobalKey<NavigatorState> get navigatorKey {
    _navigatorKey ??= GlobalKey<NavigatorState>();
    return _navigatorKey!;
  }

  /// a global key that should be passed
  /// to MaterialApp or CupertinoApp
  /// if tyou want to use custom transtions
  /// for named routes
  GlobalKey get appKey {
    _appKey ??= GlobalKey();
    return _appKey!;
  }

  /// use material transition as default transition
  Transition transition = Transition.material;

  /// default transition duration
  Duration transitionDuration = const Duration(milliseconds: 300);

  /// set the current route settings data
  void setRouteSettings(
    RouteSettings settings, {
    bool isOverrride = false,
  }) {
    _currentRouteSettings = settings;
  }

  /// use this method for widget testing
  void dispose() {
    _appKey = null;
    _navigatorKey?.currentState?.dispose();
    _navigatorKey = null;
  }
}
