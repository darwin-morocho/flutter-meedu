import 'package:flutter/widgets.dart';

abstract class CustomTransition {
  Widget buildTransition({
    @required BuildContext context,
    @required Curve curve,
    @required Animation<double> animation,
    @required Animation<double> secondaryAnimation,
    @required Widget child,
  });
}
