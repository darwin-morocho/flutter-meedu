// ignore_for_file: library_private_types_in_public_api

library hooks_meedu;

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_meedu/ui.dart';

/// {@template hooks_meedu.hookconsumer.hookconsumerwidget}
/// A widget that can both use hooks and listen to providers.
///
/// If you do not need hooks, you can use [Consumer].
/// {@endtemplate}
abstract class HookConsumerWidget extends ConsumerWidget {
  /// {@macro hooks_meedu.hookconsumer.hookconsumerwidget}
  const HookConsumerWidget({super.key});

  @override
  _HookConsumerElement createElement() => _HookConsumerElement(this);
}

// ignore: invalid_use_of_visible_for_testing_member
class _HookConsumerElement extends ConsumerStatefulElement with HookElement {
  _HookConsumerElement(HookConsumerWidget super.widget);
}

/// {@macro hooks_meedu.hookconsumer.hookconsumerwidget}

class HookConsumer extends HookConsumerWidget {
  /// {@macro hooks_meedu.hookconsumer.hookconsumerwidget}
  const HookConsumer({super.key, required this.builder, this.child});

  /// A function that builds a widget.
  ///
  /// Can both listen to providers and use hooks.
  final ConsumerBuilder builder;

  /// An optional child widget that will be passed to [builder].
  ///
  /// This is useful for performance optimization, as this allows [builder] to
  /// be called again without rebuilding [child].
  final Widget? child;

  @override
  Widget build(BuildContext context, BuilderRef ref) {
    return builder(context, ref, child);
  }
}

/// A [StatefulWidget] that is both a [ConsumerWidget] and a [HookWidget].
abstract class StatefulHookConsumerWidget extends ConsumerStatefulWidget {
  /// A [StatefulWidget] that is both a [ConsumerWidget] and a [HookWidget].
  const StatefulHookConsumerWidget({super.key});

  @override
  _StatefulHookConsumerElement createElement() =>
      _StatefulHookConsumerElement(this);
}

class _StatefulHookConsumerElement extends ConsumerStatefulElement
    with
// ignore: invalid_use_of_visible_for_testing_member
        HookElement {
  _StatefulHookConsumerElement(StatefulHookConsumerWidget super.widget);
}
