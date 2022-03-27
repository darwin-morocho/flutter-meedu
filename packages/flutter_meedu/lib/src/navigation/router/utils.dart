import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../transitions/transition.dart';
import 'contextless_navigator.dart';
import 'meedu_page_route.dart';

/// get the transition
Route<T> getRoute<T>(
  Widget page, {
  Object? arguments,
  bool maintainState = true,
  bool fullscreenDialog = false,
  bool backGestureEnabled = true,
  Transition? transition,
  Duration? transitionDuration,
}) {
  final name = '/${page.runtimeType.toString()}';
  final settings = RouteSettings(
    name: name,
    arguments: arguments,
  );

  final _transition = transition ?? ContextlessNavigator.i.transition;

  final _transitionDuration =
      transitionDuration ?? ContextlessNavigator.i.transitionDuration;

  switch (_transition) {
    case Transition.material:
      return MaterialPageRoute<T>(
        builder: (_) => page,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );
    case Transition.cupertino:
      return CupertinoPageRoute<T>(
        builder: (_) => page,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );

    default:
      return MeeduPageRoute<T>(
        child: page,
        settings: settings,
        maintainState: maintainState,
        transitionDuration: _transition == Transition.none
            ? Duration.zero
            : _transitionDuration,
        fullscreenDialog: fullscreenDialog,
        transition: _transition,
        backGestureEnabled: backGestureEnabled,
      );
  }
}
