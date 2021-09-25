import 'package:flutter/widgets.dart';
import 'transition.dart';

///this class has the navigator state and the transition configuration
class MeeduNavigator {
  MeeduNavigator._();
  static final MeeduNavigator i = MeeduNavigator._();

  GlobalKey<NavigatorState>? _naviatorKey;
  GlobalKey? _appKey;

  RouteSettings? _currentRouteSettings;

  /// store the current route settings
  RouteSettings? get routeSettings => _currentRouteSettings;

  /// return the navigator key
  GlobalKey<NavigatorState> get navigatorKey {
    _naviatorKey ??= GlobalKey<NavigatorState>();
    return _naviatorKey!;
  }

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
    _naviatorKey?.currentState?.dispose();
    _naviatorKey = null;
  }
}
