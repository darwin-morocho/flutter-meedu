import 'package:flutter/cupertino.dart' show CupertinoApp;
import 'package:flutter/material.dart';
import '../../router.dart';
import 'gesture_detector/back_gesture_controller.dart';
import 'gesture_detector/gesture_detector.dart';
import 'transitions/down_to_up.dart';
import 'transitions/right_to_left.dart';
import 'transition.dart';
import 'transitions/up_to_down.dart';

class MeeduPageRoute<T> extends PageRoute<T> {
  final Duration transitionDuration;
  final bool maintainState;
  final Color? barrierColor;
  final String? barrierLabel;
  final Transition transition;
  late Widget child;
  final String? routeName;
  final bool backGestureEnabled;

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

  @override // coverage:ignore-line
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return this.child; // coverage:ignore-line
  }

  void build() {
    this.child = _getChild(appKey.currentContext!);
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
          child: this.child,
        );
      case Transition.upToDown:
        return UpToDownTransition().buildTransition(
          animation: animation,
          child: this.child,
        );

      case Transition.rightToLeft:
        return RightToLeftTransition().buildTransition(
          animation: animation,
          child: this.child,
        );

      case Transition.fadeIn:
        return FadeTransition(
          opacity: animation,
          child: this.child,
        );

      case Transition.zoom:
        return ScaleTransition(
          scale: animation,
          child: this.child,
        );

      default:
        return this.child;
    }
  }

  /// check if [backGestureEnabled]is true and envolves it into a BackGestureDetector
  Widget _getChild(BuildContext context) {
    if (routeName != null) {
      final app = appKey.currentWidget;
      late Map<String, Widget Function(BuildContext)> routes;
      if (app is MaterialApp) {
        routes = app.routes ?? {};
      } else {
        routes = (app as CupertinoApp).routes ?? {};
      }

      assert(
        routes.containsKey(routeName),
        'route name not found in your routes',
      );
      child = routes[routeName]!(context);
    }
    return this.backGestureEnabled
        ? BackGestureDetector(
            enabledCallback: _isPopGestureEnabled,
            onStartPopGesture: _startPopGesture,
            child: child,
          )
        : this.child; // coverage:ignore-line
  }

  // coverage:ignore-start
  BackGestureController<T> _startPopGesture<T>() {
    return BackGestureController<T>(
      navigator: this.navigator!,
      controller: this.controller!,
    );
  } // coverage:ignore-end

  // coverage:ignore-start
  bool get _isPopGestureInProgress {
    return this.navigator!.userGestureInProgress;
  } // coverage:ignore-end

  // coverage:ignore-start
  bool _isPopGestureEnabled<T>() {
    // ignore: lines_longer_than_80_chars
    if (this.isFirst ||
        this.willHandlePopInternally ||
        this.hasScopedWillPopCallback ||
        this.fullscreenDialog ||
        this.animation!.status != AnimationStatus.completed ||
        this.secondaryAnimation!.status != AnimationStatus.dismissed ||
        _isPopGestureInProgress) return false;

    return true;
  } // coverage:ignore-end
}
