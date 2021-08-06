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

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (transition) {
      case Transition.downToUp:
        return DownToUpTransition().buildTransition(
          animation: animation,
          child: _getChild(context),
        );
      case Transition.upToDown:
        return UpToDownTransition().buildTransition(
          animation: animation,
          child: _getChild(context),
        );

      case Transition.rightToLeft:
        return RightToLeftTransition().buildTransition(
          animation: animation,
          child: _getChild(context),
        );

      case Transition.fadeIn:
        return FadeTransition(
          opacity: animation,
          child: _getChild(context),
        );

      case Transition.zoom:
        return ScaleTransition(
          scale: animation,
          child: _getChild(context),
        );

      default:
        return _getChild(context);
    }
  }

  /// check if [backGestureEnabled]is true and envolves it into a BackGestureDetector
  Widget _getChild(BuildContext context) {
    if (routeName != null) {
      final app = appKey.currentWidget;
      late Map<String, Widget Function(BuildContext)>? routes;
      if (app is MaterialApp) {
        routes = app.routes;
      } else {
        routes = (app as CupertinoApp).routes;
      }

      assert(
        routes != null,
        'routes is null in your MaterialApp or CupertinoApp',
      );
      assert(
        routes!.containsKey(routeName),
        'route name not found in your routes',
      );
      child = routes![routeName]!(context);
    }
    return this.backGestureEnabled
        ? BackGestureDetector(
            enabledCallback: _isPopGestureEnabled,
            onStartPopGesture: _startPopGesture,
            child: child,
          )
        : this.child;
  }

  ///
  BackGestureController<T> _startPopGesture<T>() {
    return BackGestureController<T>(
      navigator: this.navigator!,
      controller: this.controller!,
    );
  }

  ///
  bool get _isPopGestureInProgress {
    return this.navigator!.userGestureInProgress;
  }

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
  }
}
