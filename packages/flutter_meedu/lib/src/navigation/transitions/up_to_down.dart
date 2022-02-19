import 'package:flutter/material.dart';

/// this class build an Up to down animation
class UpToDownTransition {
  // ignore: public_member_api_docs
  Widget buildTransition({
    Curve curve = Curves.ease,
    required Animation<double> animation,
    required Widget child,
  }) {
    const begin = Offset(0, -1);
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
