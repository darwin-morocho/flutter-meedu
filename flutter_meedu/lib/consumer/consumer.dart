// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart' show Widget, BuildContext, Key;

import 'consumer_widget.dart';

/// A function that can also listen to providers
///
/// See also [Consumer]
typedef ConsumerBuilder = Widget Function(
  BuildContext context,
  BuilderRef ref,
  Widget? child,
);

/// A widget to listen the events in a SimpleNotifier or StateNotifier
///
/// [builder]
/// [child] use this to pass a pre-built widget
class Consumer extends ConsumerWidget {
  const Consumer({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  /// callback that exposes the [BuilderRef] to decide
  /// when the consumer must be rebuilded
  final ConsumerBuilder builder;

  /// a pre-cached widget that it won't be
  /// rebuilded every time that the builder is called
  final Widget? child;

  @override
  Widget build(BuildContext context, BuilderRef ref) {
    return builder(
      context,
      ref,
      child,
    );
  }
}
