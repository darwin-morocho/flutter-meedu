import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meedu/meedu.dart';

part 'watch_filter.dart';

/// A function to read SimpleProvider or a StateProvider and subscribe to the events.
///
/// [provider] must be a SimpleProvider or a BaseProvider.
///
/// [filter] one instance of WatchFilter, use this to avoid unnecessary rebuilds
typedef ScopedReader = T Function<T>(Provider<T> provider);

/// {@template meedu.consumerwidget}
/// A base-class for widgets that wants to listen to providers
/// ```dart
/// class Example extends ConsumerWidget {
///   const Example({Key? key}): super(key: key);
///
///   @override
///   Widget build(BuildContext context, ScopedReader watch) {
///     final value = watch(myProvider);
///
///   }
/// }
/// ```
/// {@endtemplate}
abstract class ConsumerWidget extends StatefulWidget {
  const ConsumerWidget({Key? key}) : super(key: key);
  Widget build(BuildContext context, ScopedReader watch);

  @override
  _ConsumerState createState() => _ConsumerState();
}

class _ConsumerState extends State<ConsumerWidget> {
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
  /// [filter] optional parameter to avoid unnecessary rebuilds
  T _reader<T>(Provider<T> providerOrTarget) {
    // if the widget was rebuilded
    if (_isExternalBuild) {
      _clearDependencies();
    }
    _isExternalBuild = false;
    final target =
        providerOrTarget is _Target ? providerOrTarget as _Target : null;

    late T notifier;
    if (target != null) {
      notifier = target.notifier as T;
    } else {
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

  @override
  Widget build(BuildContext context) {
    return widget.build(context, _reader);
  }
}
