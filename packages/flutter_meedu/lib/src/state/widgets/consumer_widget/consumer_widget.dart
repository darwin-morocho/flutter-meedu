import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:meedu/meedu.dart';

import '../watch_filter.dart';

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
abstract class ConsumerWidget extends StatefulWidget {
  const ConsumerWidget({Key? key}) : super(key: key);
  Widget build(BuildContext context, BuilderRef ref);

  @override
  _ConsumerState createState() => _ConsumerState();
}

class _ConsumerState extends State<ConsumerWidget> implements BuilderRef {
  Map<BaseNotifier, ListenerCallback> _dependencies = {};

  // initialized at true for the first build
  bool _isExternalBuild = true;

  /// used know when the first frame was redered
  bool _afterFirstLayout = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _afterFirstLayout = true;
    });
  }

  @override // coverage:ignore-line
  void didUpdateWidget(ConsumerWidget oldWidget) {
    super.didUpdateWidget(oldWidget); // coverage:ignore-line
    _isExternalBuild = true; // coverage:ignore-line
  }

  @override // coverage:ignore-line
  void reassemble() {
    super.reassemble(); // coverage:ignore-line
    _isExternalBuild = true; // coverage:ignore-line
  }

  /// force the widget update
  void _rebuild() {
    if (_afterFirstLayout && this.mounted) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    _clearDependencies();
    super.deactivate();
  }

  /// clear the listeners for this widget
  void _clearDependencies() {
    _dependencies.forEach(
      (notifier, listener) {
        if (!notifier.disposed) {
          notifier.removeListener(listener);
        }
      },
    );
    _dependencies = {};
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
  T watch<T>(Provider<T> providerOrTarget) {
    // if the widget was rebuilded
    if (_isExternalBuild) {
      _clearDependencies();
    }
    _isExternalBuild = false;
    final target =
        providerOrTarget is Target ? providerOrTarget as Target : null;

    late T notifier;

    if (target != null) {
      // If [providerOrTarget] is a value gotten from .select, .ids or .when
      notifier = target.notifier as T;
    } else {
      // if [providerOrTarget] is a [SimpleProvider] or a [StateProvider]
      notifier = (providerOrTarget as BaseProvider<T>).read;
    }

    final insideDependencies = _dependencies.containsKey(notifier);

    // if there is not a listener for the current provider
    if (!insideDependencies) {
      late void Function(dynamic) listener;
      // if the data passed to the watch function
      // was gotten using the .ids, .select or .when methods
      if (target != null) {
        target.rebuild = _rebuild;
        listener = target.listener;
      } else {
        // if the notifier is a SimpleNotifier
        if (notifier is SimpleNotifier) {
          listener = (_) {
            final listeners = _ as List<String>;
            // only rebuild the Consumer if the notify method was called
            // without ids
            if (listeners.isEmpty) {
              _rebuild();
            }
          };
        } else {
          // if the notifier is a StateNotifier
          listener = (_) => _rebuild();
        }
      }
      // add the listener to the current notifier
      _dependencies[notifier as BaseNotifier] = listener;
      notifier.addListener(listener);
    }
    return notifier; // coverage:ignore-line
  }

  /// read a Notifier from one provider and subscribe the widget to the changes of this Notifier.
  ///
  /// [target] is a value gotten from .select or .when
  ///
  /// the  widget only will be rebuilded depending of the condition of each method.
  R select<T, R>(Target<T, R> target) {
    // if the widget was rebuilded
    if (_isExternalBuild) {
      _clearDependencies();
    }
    _isExternalBuild = false;
    late T notifier = target.notifier;
    final insideDependencies = _dependencies.containsKey(notifier);
    // if there is not a listener for the current provider
    if (!insideDependencies) {
      target.rebuild = _rebuild;
      void Function(dynamic) listener = target.listener;
      // add the listener to the current notifier
      _dependencies[notifier as BaseNotifier] = listener;
      notifier.addListener(listener);
    }
    return target.selectValue; // coverage:ignore-line
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, this);
  }
}

abstract class BuilderRef {
  /// A function to read SimpleProvider or a StateProvider and subscribe to the events.
  ///
  /// this method returns the Notifier linked to the provider
  T watch<T>(Provider<T> providerOrTarget);

  /// A function to read SimpleProvider or a StateProvider and subscribe to the events.
  ///
  /// this method returns the value returned by the select or when methods
  R select<T, R>(Target<T, R> target);
}
