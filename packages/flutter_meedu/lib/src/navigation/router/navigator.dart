// ignore: public_member_api_docs
import 'package:flutter/material.dart';

import '../transitions/transition.dart';
import 'utils.dart';

/// Navigator 1.0 to use push, pushReplacement, pushAndRemoveUntil and all pop methods
class Navigator1 {
  // ignore: public_member_api_docs
  Navigator1(this._context);

  final BuildContext _context;

  NavigatorState get _navigator => Navigator.of(_context);

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
    return _navigator.push<T>(
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
    return _navigator.pushReplacement<T, TO>(
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
    return _navigator.pushAndRemoveUntil<T>(
      getRoute(
        page,
        arguments: arguments,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        transition: transition,
        transitionDuration: transitionDuration,
        backGestureEnabled: backGestureEnabled,
      ),
      predicate ?? (_) => false,
    );
  }

  /// Consults the current route's [Route.willPop] method,
  ///  and acts accordingly, potentially popping the route as a result;
  ///
  ///  returns whether the pop request should be considered handled.
  Future<bool> maybePop<T>([T? result]) {
    return _navigator.maybePop(result);
  }

  /// remove the current page or dialog from the stack until `predicate`
  void pop<T>([T? result]) {
    _navigator.pop(result);
  }

  /// remove all pages in the stack until [predicate]
  void popUntil([bool Function(Route<dynamic>)? predicate]) {
    _navigator.popUntil(predicate ?? (_) => false);
  }

  /// return true if we can do pop
  bool canPop() {
    return _navigator.canPop();
  }
}
