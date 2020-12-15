import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

import 'custom_transition.dart';

class RightToLeftTransition extends CustomTransition {
  @override
  Widget buildTransition({
    BuildContext context,
    Curve curve,
    @required Animation<double> animation,
    Animation<double> secondaryAnimation,
    @required Widget child,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
