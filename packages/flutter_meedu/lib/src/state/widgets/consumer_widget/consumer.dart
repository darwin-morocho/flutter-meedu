import 'package:flutter/material.dart' show Widget, BuildContext, Key;
import 'consumer_widget.dart';

/// A function that can also listen to providers
///
/// See also [Consumer]
typedef ConsumerBuilder = Widget Function(
  BuildContext context,
  ScopedReader watch,
  Widget? child,
);

/// A widget to listen the events in a SimpleNotifier or StateNotifier
///
/// [builder]
/// [child] use this to pass a pre-built widget
class Consumer extends ConsumerWidget {
  final ConsumerBuilder builder;
  final Widget? child;

  const Consumer({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return builder(context, watch, this.child);
  }
}
