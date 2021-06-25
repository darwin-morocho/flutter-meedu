import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meedu/meedu.dart';

part 'watch_filter.dart';

/// A function to read SimpleProvider or a StateProvider and subscribe to the events.
///
/// [provider] must be a SimpleProvider or a BaseProvider.
///
/// [filter] one instance of WatchFilter, use this to avoid unnecessary rebuilds
typedef ScopedReader = T Function<T, S>(Provider<T> provider);

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
  Map<BaseProvider, ListenerCallback> _dependencies = {};

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
    if (_afterFirstLayout) {
      (context as Element).markNeedsBuild();
    }
  }

  @override
  void deactivate() {
    _clearDependencies();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// clear the listeners for this widget
  void _clearDependencies() {
    _dependencies.forEach(
      (provider, listener) {
        if (provider.mounted) {
          provider.read.removeListener(listener);
        }
      },
    );
    _dependencies = {};
  }

  /// read a Notifier from one provider and subscribe the widget to the changes of this Notifier.
  ///
  /// [filter] optional parameter to avoid unnecessary rebuilds
  T _reader<T, S>(Provider<T> providerOrTarget) {
    // if the widget was rebuilded
    if (_isExternalBuild) {
      _clearDependencies();
    }
    _isExternalBuild = false;
    late BaseProvider<T> provider;
    final target = providerOrTarget is _Target ? providerOrTarget as _Target<T, S> : null;

    if (target != null) {
      provider = target.provider;
    } else {
      provider = providerOrTarget as BaseProvider<T>;
    }
    final insideDependencies = _dependencies.containsKey(provider);

    // add a new listener if the provider is not into dependencies
    final notifier = provider.read;

    if (!insideDependencies) {
      late void Function(dynamic) listener;
      if (target != null) {
        target.rebuild = _rebuild;
        listener = target.listener;
      } else {
        listener = (_) => _rebuild();
      }

      _dependencies[provider] = listener;
      (notifier as BaseNotifier).addListener(listener);
    }

    return notifier;
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, _reader);
  }
}
