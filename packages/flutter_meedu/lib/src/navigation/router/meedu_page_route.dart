// ignore_for_file: avoid_shadowing_type_parameters, avoid_renaming_method_parameters, public_member_api_docs

import 'package:flutter/cupertino.dart' show CupertinoApp;
import 'package:flutter/material.dart';

import '../gesture_detector/back_gesture_controller.dart';
import '../gesture_detector/gesture_detector.dart';
import '../transitions/export.dart';
import 'contextless_navigator.dart';

/// custom PageRoute for custom transitions in the router module
class MeeduPageRoute<T> extends PageRoute<T> {
  MeeduPageRoute({
    Widget? child,
    this.routeName,
    @required RouteSettings? settings,
    required this.maintainState,
    required this.transitionDuration,
    required bool fullscreenDialog,
    this.barrierColor,
    this.barrierLabel,
    required this.transition,
    required this.backGestureEnabled,
  }) : super(
          settings: settings,
          fullscreenDialog: fullscreenDialog,
        ) {
    if (child != null) {
      this.child = child;
    }
  }

  @override
  final Duration transitionDuration;

  @override
  final bool maintainState;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  final Transition transition;

  /// page content for the current route
  late Widget child;

  /// this value wont't be  null if the navigation
  /// was used throught a named route
  final String? routeName;

  /// if the back gesture to pop a page is enabled
  final bool backGestureEnabled;

  @override // coverage:ignore-line
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return child; // coverage:ignore-line
  }

  void build() {
    child = _getChild(ContextlessNavigator.i.appKey.currentContext!);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget _,
  ) {
    switch (transition) {
      case Transition.downToUp:
        return DownToUpTransition().buildTransition(
          animation: animation,
          child: child,
        );
      case Transition.upToDown:
        return UpToDownTransition().buildTransition(
          animation: animation,
          child: child,
        );

      case Transition.rightToLeft:
        return RightToLeftTransition().buildTransition(
          animation: animation,
          child: child,
        );

      case Transition.fadeIn:
        return FadeTransition(
          opacity: animation,
          child: child,
        );

      case Transition.zoom:
        return ScaleTransition(
          scale: animation,
          child: child,
        );

      default:
        return child;
    }
  }

  /// check if [backGestureEnabled]is true and envolves it into a BackGestureDetector
  Widget _getChild(BuildContext context) {
    if (routeName != null) {
      final app = ContextlessNavigator.i.appKey.currentWidget;
      late Map<String, Widget Function(BuildContext)> routes;
      if (app is MaterialApp) {
        routes = app.routes ?? {};
      } else {
        // ignore: cast_nullable_to_non_nullable
        routes = (app as CupertinoApp).routes ?? {};
      }

      assert(
        routes.containsKey(routeName),
        'route name not found in your routes',
      );
      child = routes[routeName]!(context);
    }
    return backGestureEnabled
        ? BackGestureDetector(
            enabledCallback: _isPopGestureEnabled,
            onStartPopGesture: _startPopGesture,
            child: child,
          )
        : child; // coverage:ignore-line
  }

  // coverage:ignore-start
  BackGestureController<T> _startPopGesture<T>() {
    return BackGestureController<T>(
      navigator: navigator!,
      controller: controller!,
    );
  } // coverage:ignore-end

  // coverage:ignore-start
  bool get _isPopGestureInProgress {
    return navigator!.userGestureInProgress;
  } // coverage:ignore-end

  // coverage:ignore-start
  bool _isPopGestureEnabled<T>() {
    // ignore: lines_longer_than_80_chars
    if (isFirst ||
        willHandlePopInternally ||
        hasScopedWillPopCallback ||
        fullscreenDialog ||
        animation!.status != AnimationStatus.completed ||
        secondaryAnimation!.status != AnimationStatus.dismissed ||
        _isPopGestureInProgress) {
      return false;
    }

    return true;
  } // coverage:ignore-end
}
