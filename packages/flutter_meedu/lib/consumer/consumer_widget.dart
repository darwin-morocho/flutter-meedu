import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meedu/notifiers.dart';
import 'package:meedu/providers.dart' as m;

import '../provider/filters.dart';

part 'consumer.dart';

typedef _ListenerCallback<T> = void Function(T);

/// A [StatefulWidget] that can read providers.
abstract class ConsumerStatefulWidget extends StatefulWidget {
  const ConsumerStatefulWidget({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  ConsumerState createState();

  @override
  ConsumerStatefulElement createElement() {
    return ConsumerStatefulElement(this);
  }
}

/// A [State] that has access to a [BuilderRef] through [ref], allowing
/// it to read providers.
abstract class ConsumerState<T extends ConsumerStatefulWidget>
    extends State<T> {
  /// An object that allows widgets to interact with providers.
  late final BuilderRef ref = context as BuilderRef;
}

class ConsumerStatefulElement extends StatefulElement implements BuilderRef {
  ConsumerStatefulElement(StatefulWidget widget) : super(widget);

  Map<StateNotifier, Function> _builders = {};
  Map<StateNotifier, Function> _listeners = {};
  Map<StateNotifier, Function> _selectListeners = {};
  Map<StateNotifier, Function> _whenListeners = {};

  Map<StateNotifier, m.BaseStateNotifierProvider> _targets = {};

  // initialized at true for the first build
  bool _isExternalBuild = true;

  bool _mounted = true;
  bool _init = false;

  @override // coverage:ignore-line
  void didChangeDependencies() {
    super.didChangeDependencies(); // coverage:ignore-line
    _isExternalBuild = true; // coverage:ignore-line
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _init = true;
  }

  /// force the widget update
  void _rebuild() {
    if (_mounted) {
      markNeedsBuild();
    }
  }

  @override
  void unmount() {
    _mounted = false;
    _clearDependencies();
    super.unmount();
  }

  /// clear the listeners for this widget
  void _clearDependencies() {
    void clearListeners(Map<StateNotifier, Function> map) {
      for (final e in map.entries) {
        if (!e.key.disposed) {
          (e.key as dynamic).removeListener(e.value);
        }
      }
      map.clear();
    }

    clearListeners(_builders);
    clearListeners(_listeners);
    clearListeners(_selectListeners);
    clearListeners(_whenListeners);

    _targets.clear();
  }

  @override
  N listen<N extends StateNotifier<S>, S>(
    m.BaseStateNotifierProvider<N, S> providerOrFilter, {
    required void Function(N notifier) callback,
    String? tag,
  }) {
    return _buildWatcher(
      providerOrFilter: providerOrFilter,
      tag: tag,
      isListener: true,
      callback: (notifier) {
        if (_init && mounted) {
          callback(notifier);
        }
      },
    );
  }

  /// read a Notifier from one provider and subscribe the widget to the changes of this Notifier.
  ///
  /// [providerOrTarget] this param is required to decide when the Consumer
  /// needs to be rebuilded, if [providerOrTarget] is a [SimpleProvider] or a
  /// [StateProvider] the  widget will be rebuilded when the notify method is called
  /// inside a SimpleNotifier or StateNotifier.
  ///
  /// If [providerOrTarget] is a value gotten from .select, .ids or .when
  /// the  widget only will be rebuilded depending of the condition of each method.
  @override
  N watch<N extends StateNotifier<S>, S>(
    m.BaseStateNotifierProvider<N, S> providerOrFilter, {
    String? tag,
  }) {
    return _buildWatcher(
      providerOrFilter: providerOrFilter,
      tag: tag,
      isListener: false,
      callback: (_) => _rebuild(),
    ); // coverage:ignore-line
  }

  /// read a Notifier from one provider and subscribe the widget to the changes of this Notifier.
  ///
  /// [target] is a value gotten from .select or .when
  ///
  /// the  widget only will be rebuilded depending of the condition of each method.
  @override
  R select<N extends StateNotifier<S>, S, R>(
    SelectFilteredProvider<N, S, R> filter,
  ) {
    // if the widget was rebuilded
    if (_isExternalBuild) {
      _clearDependencies();
    }
    _isExternalBuild = false;
    final notifier = filter.notifier;

    final insideDependencies = _builders.containsKey(notifier);
    // if there is not a listener for the current provider
    if (!insideDependencies) {
      filter.reaction = (_) => _rebuild();
      filter.createListener();
      // add the listener to the current notifier
      _builders[notifier] = filter.listener;
      _targets[notifier] = filter;
      notifier.addListener(filter.listener);
    }
    return (_targets[notifier] as SelectFilteredProvider)
        .selectValue; // coverage:ignore-line
  }

// coverage:ignore-start
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty(
        '_notifiers',
        _builders.keys.map((e) => e.runtimeType.toString()),
      ),
    );
  }
  // coverage:ignore-end
}

/// A interface that must be implemented in the ConsumerWidget
abstract class BuilderRef {
  /// A function to read SimpleProvider or a StateProvider and subscribe to the events.
  ///
  /// this method returns the Notifier linked to the provider
  N listen<N extends StateNotifier<S>, S>(
    m.BaseStateNotifierProvider<N, S> providerOrFilter, {
    required void Function(N notifier) callback,
    String? tag,
  });

  /// A function to read SimpleProvider or a StateProvider and subscribe to the events.
  ///
  /// this method returns the Notifier linked to the provider
  N watch<N extends StateNotifier<S>, S>(
    m.BaseStateNotifierProvider<N, S> providerOrFilter, {
    String? tag,
  });

  /// A function to read SimpleProvider or a StateProvider and subscribe to the events.
  ///
  /// this method returns the value returned by the select or when methods
  R select<N extends StateNotifier<S>, S, R>(
    SelectFilteredProvider<N, S, R> filter,
  );
}

/// {@template meedu.consumerwidget}
/// A base-class for widgets that wants to listen to providers
/// ```dart
/// class Example extends ConsumerWidget {
///   const Example({Key? key}): super(key: key);
///
///   @override
///   Widget build(BuildContext context, ref) {
///     final value = ref.watch(myProvider);
///     return YOUR_WIDGET;
///   }
/// }
/// ```
/// {@endtemplate}
abstract class ConsumerWidget extends ConsumerStatefulWidget {
  // ignore: public_member_api_docs
  const ConsumerWidget({Key? key}) : super(key: key);

  // ignore: public_member_api_docs
  Widget build(BuildContext context, BuilderRef ref);

  @override
  // ignore: library_private_types_in_public_api
  _ConsumerState createState() => _ConsumerState();
}

class _ConsumerState<T extends ConsumerWidget>
    extends ConsumerState<ConsumerWidget> {
  /// An object that allows widgets to interact with providers.
  @override
  BuilderRef get ref => context as BuilderRef;

  @override
  Widget build(BuildContext context) {
    return widget.build(context, ref);
  }
}
