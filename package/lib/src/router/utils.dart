import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'meedu_page_route.dart';
import 'navigator.dart';
import 'transition.dart';

/// get the transition
Route getRoute(
  Widget page, {
  Object arguments,
  bool maintainState = true,
  bool fullscreenDialog = false,
  bool backGestureEnabled = true,
  Transition transition,
  Duration transitionDuration,
}) {
  final name = "/${page.runtimeType.toString()}";
  final settings = RouteSettings(
    name: name,
    arguments: arguments,
  );

  final _transition = transition ?? MeeduNavigator.instance.transition;
  final _transitionDuration =
      transitionDuration ?? MeeduNavigator.instance.transitionDuration;

  switch (_transition) {
    case Transition.material:
      return MaterialPageRoute(
        builder: (_) => page,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );
    case Transition.cupertino:
      return CupertinoPageRoute(
        builder: (_) => page,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );

    default:
      return MeeduPageRoute(
        page,
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
