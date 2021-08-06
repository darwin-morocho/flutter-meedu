import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'meedu_page_route.dart';
import 'transition.dart';
import 'utils.dart';
import 'navigator.dart';

export 'transition.dart';

GlobalKey<NavigatorState> get navigatorKey => MeeduNavigator.i.navigatorKey;
GlobalKey get appKey => MeeduNavigator.i.appKey;
NavigatorState? get _state => MeeduNavigator.i.navigatorKey.currentState;

/// set the default transition for all pages
void setDefaultTransition(Transition transition, {Duration? duration}) {
  MeeduNavigator.i.transition = transition;
  if (duration != null) {
    MeeduNavigator.i.transitionDuration = duration;
  }
}

void _validateRouterState() {
  assert(
    _state != null,
    "Invalid navigator state, make sure that you has been set the navigator key in your MaterialApp",
  );
}

/// use this method to destroy the current navigatorKey attached to the app
///
/// useful for widget testing
void dispose() {
  MeeduNavigator.i.dispose();
}

/// Push the given [page] onto the navigator.
///
/// [transitionDuration] will be [Duration.zero] when [transition] is equals to [Transition.none]
///
/// [backGestureEnabled] ignored when [transition] is equals to [Transition.material] or [Transition.cupertino]
Future<T?> push<T>(
  Widget page, {
  Object? arguments,
  bool maintainState = true,
  bool fullscreenDialog = false,
  Transition? transition,
  Duration? transitionDuration,
  bool backGestureEnabled = false,
}) {
  _validateRouterState();
  return _state!.push<T>(
    getRoute<T>(
      page,
      arguments: arguments,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      transition: transition,
      transitionDuration: transitionDuration,
      backGestureEnabled: backGestureEnabled,
    ),
  );
}

/// Replace the current [page] of the navigator by pushing the given [page] and then
///  disposing the previous route once the new route has finished animating in.
///
/// [transitionDuration] will be [Duration.zero] when [transition] is equals to [Transition.none]
///
/// [backGestureEnabled] ignored when [transition] is [Transition.material] or [Transition.cupertino]
Future<T?> pushReplacement<T>(
  Widget page, {
  Object? arguments,
  bool maintainState = true,
  bool fullscreenDialog = false,
  Transition? transition,
  Duration transitionDuration = const Duration(milliseconds: 300),
  bool backGestureEnabled = false,
}) {
  _validateRouterState();
  return _state!.pushReplacement(
    getRoute(
      page,
      arguments: arguments,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      transition: transition,
      transitionDuration: transitionDuration,
      backGestureEnabled: backGestureEnabled,
    ),
  );
}

/// Push a named route onto the navigator.
///
/// [transitionDuration] is ignored when transition is equals to Transition.material or Transition.cupertino
///
/// [backGestureEnabled] not works on Android if transition is Transition.material
Future<T?> pushNamed<T>(
  String routeName, {
  Object? arguments,
  bool backGestureEnabled = true,
  Transition? transition,
  Duration? transitionDuration,
}) {
  final route = _buildNamedRoute<T>(
    routeName: routeName,
    arguments: arguments,
    backGestureEnabled: backGestureEnabled,
    transition: transition,
    transitionDuration: transitionDuration,
  );
  if (route == null) {
    return _state!.pushNamed<T>(routeName, arguments: arguments);
  }
  return _state!.push<T>(route);
}

/// Pop the current route off the navigator and push a named route in its place
///
/// [transitionDuration] is ignored when transition is equals to Transition.material or Transition.cupertino
///
/// [backGestureEnabled] not works on Android if transition is Transition.material
Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
  String routeName, {
  Object? arguments,
  bool backGestureEnabled = true,
  Transition? transition,
  Duration? transitionDuration,
  TO? result,
}) {
  final route = _buildNamedRoute<T>(
    routeName: routeName,
    arguments: arguments,
    backGestureEnabled: backGestureEnabled,
    transition: transition,
    transitionDuration: transitionDuration,
  );
  if (route == null) {
    return _state!.popAndPushNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }
  _state!.pop<TO>(result);
  return _state!.push<T>(route);
}

/// replace the current page with a new route name
///
/// [transitionDuration] is ignored when transition is equals to Transition.material or Transition.cupertino
///
/// [backGestureEnabled] not works on Android if transition is Transition.material
Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
  String routeName, {
  Object? arguments,
  bool backGestureEnabled = true,
  Transition? transition,
  Duration? transitionDuration,
  TO? result,
}) {
  final route = _buildNamedRoute<T>(
    routeName: routeName,
    arguments: arguments,
    backGestureEnabled: backGestureEnabled,
    transition: transition,
    transitionDuration: transitionDuration,
  );
  if (route == null) {
    return _state!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }
  return _state!.pushReplacement<T, TO>(route);
}

/// navigates to a new pages and remove until
///
/// [transitionDuration] is ignored when transition is equals to Transition.material or Transition.cupertino
///
/// [backGestureEnabled] not works on Android if transition is Transition.material
Future<T?> pushNamedAndRemoveUntil<T>(
  String routeName, {
  bool Function(Route<dynamic>)? predicate,
  Object? arguments,
  bool backGestureEnabled = true,
  Transition? transition,
  Duration? transitionDuration,
}) {
  final route = _buildNamedRoute<T>(
    routeName: routeName,
    arguments: arguments,
    backGestureEnabled: backGestureEnabled,
    transition: transition,
    transitionDuration: transitionDuration,
  );
  if (route == null) {
    return _state!.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate ?? (_) => false,
      arguments: arguments,
    );
  }
  return _state!.pushAndRemoveUntil<T>(
    route,
    predicate ?? (_) => false,
  );
}

/// Consults the current route's [Route.willPop] method,
///  and acts accordingly, potentially popping the route as a result;
///
///  returns whether the pop request should be considered handled.
Future<bool> maybePop<T>([T? result]) {
  _validateRouterState();
  return _state!.maybePop(result);
}

/// remove the current page or dialog from the stack until [predicate]
void pop<T>([T? result]) {
  _validateRouterState();
  _state!.pop(result);
}

/// remove all pages in the stack until [predicate]
void popUntil([bool Function(Route<dynamic>)? predicate]) {
  _validateRouterState();
  _state!.popUntil(predicate ?? (_) => false);
}

/// return true if we can do pop
bool canPop() {
  _validateRouterState();
  return _state!.canPop();
}

/// return the arguments of the current page
T arguments<T>(BuildContext context) {
  _validateRouterState();
  return ModalRoute.of(context)?.settings.arguments as T;
}

/// return null if default transition must be used
///
/// [transitionDuration] is ignored when transition is equals to Transition.material or Transition.cupertino
///
/// [backGestureEnabled] not works on Android if transition is Transition.material
MeeduPageRoute<T>? _buildNamedRoute<T>({
  required String routeName,
  required Object? arguments,
  required bool backGestureEnabled,
  required Transition? transition,
  required Duration? transitionDuration,
}) {
  _validateRouterState();
  if (appKey.currentWidget == null) {
    return null;
  }
  final app = appKey.currentWidget;
  Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  if (app is MaterialApp) {
    onGenerateRoute = app.onGenerateRoute;
  } else if (app is CupertinoApp) {
    onGenerateRoute = app.onGenerateRoute;
  }
  if (onGenerateRoute != null) {
    return null;
  }

  final _transition = transition ?? MeeduNavigator.i.transition;
  if (_transition == Transition.material || _transition == Transition.cupertino) {
    return null;
  }
  final _transitionDuration = transitionDuration ?? MeeduNavigator.i.transitionDuration;
  return MeeduPageRoute<T>(
    routeName: routeName,
    settings: RouteSettings(
      name: routeName,
      arguments: arguments,
    ),
    maintainState: true,
    transitionDuration: _transition == Transition.none ? Duration.zero : _transitionDuration,
    fullscreenDialog: false,
    transition: _transition,
    backGestureEnabled: backGestureEnabled,
  );
}
