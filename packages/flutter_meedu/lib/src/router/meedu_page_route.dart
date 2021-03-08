import 'package:flutter/material.dart';
import 'gesture_detector/back_gesture_controller.dart';
import 'gesture_detector/gesture_detector.dart';
import 'transitions/down_to_up.dart';
import 'transitions/right_to_left.dart';
import 'transition.dart';
import 'transitions/up_to_down.dart';

class MeeduPageRoute<T> extends PageRoute<T> {
  final Duration transitionDuration;
  final bool maintainState;
  final Color barrierColor;
  final String barrierLabel;
  final Transition transition;
  final Widget child;
  final bool backGestureEnabled;

  MeeduPageRoute(
    this.child, {
    @required RouteSettings settings,
    @required this.maintainState,
    @required this.transitionDuration,
    @required bool fullscreenDialog,
    this.barrierColor,
    this.barrierLabel,
    @required this.transition,
    @required this.backGestureEnabled,
  }) : super(
          settings: settings,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return this.child;
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
          child: _child,
        );
      case Transition.upToDown:
        return UpToDownTransition().buildTransition(
          animation: animation,
          child: _child,
        );

      case Transition.rightToLeft:
        return RightToLeftTransition().buildTransition(
          animation: animation,
          child: _child,
        );

      case Transition.fadeIn:
        return FadeTransition(
          opacity: animation,
          child: _child,
        );

      case Transition.zoom:
        return ScaleTransition(
          scale: animation,
          child: _child,
        );

      default:
        return child;
    }
  }

  /// check if [backGestureEnabled]is true and envolves it into a BackGestureDetector
  Widget get _child {
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
      navigator: this.navigator,
      controller: this.controller,
    );
  }

  ///
  bool get _isPopGestureInProgress {
    return this.navigator.userGestureInProgress;
  }

  bool _isPopGestureEnabled<T>() {
    // ignore: lines_longer_than_80_chars
    if (this.isFirst ||
        this.willHandlePopInternally ||
        this.hasScopedWillPopCallback ||
        this.fullscreenDialog ||
        this.animation.status != AnimationStatus.completed ||
        this.secondaryAnimation.status != AnimationStatus.dismissed ||
        _isPopGestureInProgress) return false;

    return true;
  }
}
