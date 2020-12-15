import 'package:flutter/material.dart';
import 'custom_transition.dart';

class UpToDownTransition extends CustomTransition {
  @override
  Widget buildTransition({
    BuildContext context,
    Curve curve = Curves.ease,
    @required Animation<double> animation,
    Animation<double> secondaryAnimation,
    @required Widget child,
  }) {
    const begin = Offset(0.0, -1.0);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
