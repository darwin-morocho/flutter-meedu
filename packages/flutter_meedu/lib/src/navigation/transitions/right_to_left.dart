import 'package:flutter/widgets.dart';

// ignore: public_member_api_docs
class RightToLeftTransition {
  // ignore: public_member_api_docs
  Widget buildTransition({
    required Animation<double> animation,
    required Widget child,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
