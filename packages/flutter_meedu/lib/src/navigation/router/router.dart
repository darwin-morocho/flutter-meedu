import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'meedu_page_route.dart';
import 'utils.dart';
import 'navigator.dart';
import '../transitions/transition.dart';
export '../transitions/transition.dart';

part 'build_named_route.dart';

/// a GlobalKey<NavigatorState> to navigate without BuildContext
/// ```dart
///import 'package:flutter_meedu/router.dart' as router;
///class MyApp extends StatelessWidget {
///  @override
///  Widget build(BuildContext context) {
///    return MaterialApp(
///      navigatorKey: router.navigatorKey, // add the navigator key
///      home: HomePage(),
///      routes: {YOUR_ROUTES},
///    );
///  }
///}
///```
GlobalKey<NavigatorState> get navigatorKey => MeeduNavigator.i.navigatorKey;

/// GlobalKey to detenrminate if a MaterialApp or CupertinoApp
/// is using the [onGenerateRoute] paremeter or for custom transitions
/// using named routes we need to now the value of `routes` parameter
///
///```dart
///import 'package:flutter_meedu/router.dart' as router;
///class MyApp extends StatelessWidget {
///  @override
///  Widget build(BuildContext context) {
///    return MaterialApp(
///      key: router.appKey,
///      navigatorKey: router.navigatorKey, // add the navigator key
///      home: HomePage(),
///      routes: {YOUR_ROUTES},
///    );
///  }
///}
///```
GlobalKey get appKey => MeeduNavigator.i.appKey;

/// current state of navigatorKey to be used to navigate without BuildContext
NavigatorState? get _state => MeeduNavigator.i.navigatorKey.currentState;

/// set the default transition for all pages
///
/// [duration] set the transition duration for all pages
/// by default duration is 300 milliseconds
void setDefaultTransition(Transition transition, {Duration? duration}) {
  MeeduNavigator.i.transition = transition;
  if (duration != null) {
    MeeduNavigator.i.transitionDuration = duration;
  }
}

/// validate if the navigator key was assigned to one MaterialApp or CupertinoApp
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
Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
  Widget page, {
  Object? arguments,
  bool maintainState = true,
  bool fullscreenDialog = false,
  Transition? transition,
  Duration transitionDuration = const Duration(milliseconds: 300),
  bool backGestureEnabled = false,
  TO? result,
}) {
  _validateRouterState();
  return _state!.pushReplacement<T, TO>(
    getRoute(
      page,
      arguments: arguments,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      transition: transition,
      transitionDuration: transitionDuration,
      backGestureEnabled: backGestureEnabled,
    ),
    result: result,
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
Object? get arguments {
  return settings.arguments;
}

/// return the current route settings
RouteSettings get settings {
  assert(
    MeeduNavigator.i.routeSettings != null,
    '''
    you need to define the navigator observer to allow
    flutter_meedu store the settings of the current route

      MaterialApp(
        key: router.appKey,
        initialRoute: '/',
        navigatorKey: router.navigatorKey,
        navigatorObservers: [
          router.observer, //<-- ADD THIS LINE
        ],
        routes: YOUR_ROUTES,
      ),

    ''',
  );
  return MeeduNavigator.i.routeSettings!;
}
