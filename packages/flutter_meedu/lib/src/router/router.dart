import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'transition.dart';
import 'utils.dart';
import 'navigator.dart';

export 'transition.dart';

GlobalKey<NavigatorState> get navigatorKey => MeeduNavigator.i.navigatorKey;
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
  Duration transitionDuration = const Duration(milliseconds: 300),
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
Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
  _validateRouterState();
  return _state!.pushNamed<T>(routeName, arguments: arguments);
}

/// Pop the current route off the navigator and push a named route in its place
Future<T?> popAndPushNamed<T>(String routeName, {Object? arguments}) {
  _validateRouterState();
  return _state!.popAndPushNamed(routeName, arguments: arguments);
}

/// replace the current page with a new route name
Future<T?> pushReplacementNamed<T>(String routeName, {Object? arguments}) {
  _validateRouterState();
  return _state!.pushReplacementNamed(routeName, arguments: arguments);
}

/// navigates to a new pages and remove until
Future<T?> pushNamedAndRemoveUntil<T>(
  String routeName, {
  bool Function(Route<dynamic>)? predicate,
  Object? arguments,
}) {
  _validateRouterState();
  return _state!.pushNamedAndRemoveUntil(routeName, predicate ?? (_) => false,
      arguments: arguments);
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
Object? arguments(BuildContext context) {
  return ModalRoute.of(context)?.settings.arguments;
}
