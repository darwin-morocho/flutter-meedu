// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../navigator/navigator.dart';
import '../navigator_observer.dart';
import '../transitions/transition.dart';
import 'meedu_page_route.dart';

ContextlessNavigator get router => ContextlessNavigator.i;

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

  /// the observer to listen the changes in the stack route
  MeeduNavigatorObserver get observer => MeeduNavigatorObserver();

  /// a GlobalKey<NavigatorState> to navigate without BuildContext
  /// ```dart
  ///import 'package:flutter_meedu/router.dart';
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
  GlobalKey<NavigatorState> get navigatorKey {
    _navigatorKey ??= GlobalKey<NavigatorState>();
    return _navigatorKey!;
  }

  /// GlobalKey to detenrminate if a MaterialApp or CupertinoApp
  /// is using the `onGenerateRoute` paremeter or for custom transitions
  /// using named routes we need to now the value of `routes` parameter
  ///
  ///```dart
  ///import 'package:flutter_meedu/router.dart';
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
  GlobalKey get appKey {
    _appKey ??= GlobalKey();
    return _appKey!;
  }

  /// use material transition as default transition
  Transition _transition = Transition.material;
  Transition get transition => _transition;

  /// default transition duration
  Duration _transitionDuration = const Duration(milliseconds: 300);
  Duration get transitionDuration => _transitionDuration;

  /// current state of navigatorKey to be used to navigate without BuildContext
  NavigatorState? get _state => navigatorKey.currentState;

  /// create a navigator 1.0 to use push, pushReplacement, pushAndRemoveUntil and all pop methods
  Navigator1 get _navigator => Navigator1(_state!.context);

  /// set the current route settings data
  void setRouteSettings(
    RouteSettings settings, {
    bool isOverrride = false,
  }) {
    _currentRouteSettings = settings;
  }

  /// validate if the navigator key was assigned to one MaterialApp or CupertinoApp
  void _validateRouterState() {
    assert(
      _state != null,
      'Invalid navigator state, make sure that you has been set the navigator key in your MaterialApp',
    );
  }

  /// use this method to destroy the current navigatorKey attached to the app
  ///
  /// useful for widget testing
  void dispose() {
    _appKey = null;
    _navigatorKey?.currentState?.dispose();
    _navigatorKey = null;
  }

  /// set the default transition for all pages
  ///
  /// [duration] set the transition duration for all pages
  /// by default duration is 300 milliseconds
  void setDefaultTransition(Transition transition, {Duration? duration}) {
    _transition = transition;
    if (duration != null) {
      _transitionDuration = duration;
    }
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

    // if the MaterialApp or CupertinoApp is using onGenerateRoute custom
    // transitions are not allowed
    if (onGenerateRoute != null) {
      return null;
    }

    final mtransition = transition ?? _transition;
    if (mtransition == Transition.material ||
        mtransition == Transition.cupertino) {
      return null;
    }
    final mtransitionDuration = transitionDuration ?? _transitionDuration;

    // create a custom route with a custom transition
    return MeeduPageRoute<T>(
      routeName: routeName,
      settings: RouteSettings(
        name: routeName,
        arguments: arguments,
      ),
      maintainState: true,
      transitionDuration:
          mtransition == Transition.none ? Duration.zero : mtransitionDuration,
      fullscreenDialog: false,
      transition: mtransition,
      backGestureEnabled: backGestureEnabled,
    )..build();
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
    return _navigator.push<T>(
      page,
      arguments: arguments,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      transition: transition,
      transitionDuration: transitionDuration,
      backGestureEnabled: backGestureEnabled,
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
    return _navigator.pushReplacement<T, TO>(
      page,
      arguments: arguments,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      transition: transition,
      transitionDuration: transitionDuration,
      backGestureEnabled: backGestureEnabled,
      result: result,
    );
  }

  /// navigates to a new pages and remove until
  ///
  /// [transitionDuration] is ignored when transition is equals to Transition.material or Transition.cupertino
  ///
  /// [backGestureEnabled] not works on Android if transition is Transition.material
  Future<T?> pushAndRemoveUntil<T>(
    Widget page, {
    bool Function(Route<dynamic>)? predicate,
    Object? arguments,
    bool backGestureEnabled = true,
    bool maintainState = true,
    bool fullscreenDialog = false,
    Transition? transition,
    Duration? transitionDuration,
  }) {
    _validateRouterState();
    return _navigator.pushAndRemoveUntil<T>(
      page,
      arguments: arguments,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      transition: transition,
      transitionDuration: transitionDuration,
      backGestureEnabled: backGestureEnabled,
      predicate: predicate ?? (_) => false,
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
    return _navigator.maybePop(result);
  }

  /// remove the current page or dialog from the stack until `predicate`
  void pop<T>([T? result]) {
    _validateRouterState();
    _navigator.pop(result);
  }

  /// remove all pages in the stack until [predicate]
  void popUntil([bool Function(Route<dynamic>)? predicate]) {
    _validateRouterState();
    _navigator.popUntil(predicate ?? (_) => false);
  }

  /// return true if we can do pop
  bool canPop() {
    _validateRouterState();
    return _navigator.canPop();
  }

  /// return the arguments of the current page
  Object? get arguments {
    return settings.arguments;
  }

  /// return the current route settings
  RouteSettings get settings {
    assert(
      ContextlessNavigator.i.routeSettings != null,
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
    return ContextlessNavigator.i.routeSettings!;
  }

  /// return the current context linked to the global navigatorKey
  BuildContext? get context {
    return navigatorKey.currentContext;
  }
}
