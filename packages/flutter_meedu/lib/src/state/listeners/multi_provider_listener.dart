import 'package:flutter/material.dart';
import 'package:meedu/provider.dart';
import 'package:meedu/state.dart';

typedef _ProviderListenerCallback<T> = void Function(BuildContext, T);

/// this class allows you listen the changes in multiples providers
class MultiProviderListener extends StatefulWidget {
  /// a list of [MultiProviderListenerItem]
  final List<MultiProviderListenerItem> items;

  /// callback when initState is called
  final void Function(BuildContext)? onInitState;

  /// this callback will be called when the first frame was rendered
  /// use this callback if you want to show a dialog, snackbar or navigate
  /// after the first frame
  final void Function(BuildContext)? onAfterFirstLayout;

  /// callback when dispose is called
  final void Function(BuildContext)? onDispose;

  /// widget to be rendered
  final Widget child;

  MultiProviderListener({
    Key? key,
    required this.items,
    required this.child,
    this.onInitState,
    this.onAfterFirstLayout,
    this.onDispose,
  }) : super(key: key);
  @override
  _MultiProviderListenerState createState() => _MultiProviderListenerState();
}

class _MultiProviderListenerState extends State<MultiProviderListener> {
  Map<BaseNotifier, ListenerCallback> _dependencies = {};

  @override
  void initState() {
    super.initState();
    _addListeners();
    // check if the onInitState callback needs to be called
    if (widget.onInitState != null) {
      widget.onInitState!(context);
    }

    // check if the onAfterFirstLayout callback needs to be called
    if (widget.onAfterFirstLayout != null) {
      // wait after first frame
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (mounted) {
          widget.onAfterFirstLayout!(context);
        }
      });
    }
  }

  void _addListeners() {
    /// read all providers passed into widget.items
    /// and add a listener when a notifier changes
    for (final item in widget.items) {
      final notifier = item.provider.read;
      _dependencies.putIfAbsent(notifier, () {
        void Function(dynamic) listener = (_) {
          // before call onChange we need to check
          // if the widget is mounted
          if (mounted) {
            (item as dynamic).onChange(context, notifier);
          }
        };
        notifier.addListener(listener);
        return listener;
      });
    }
  }

  /// clear the listeners for this widget
  void _clearDependencies() {
    for (final item in _dependencies.entries) {
      final notifier = item.key;
      if (!notifier.disposed) {
        notifier.removeListener(item.value);
      }
    }
    _dependencies = {};
  }

  /// listen when the widget is updated
  /// due to the properties has changes or for hot reaload
  @override
  void didUpdateWidget(MultiProviderListener oldWidget) {
    _clearDependencies();
    _addListeners();
    super.didUpdateWidget(oldWidget);
  }

  /// if the widget will be disposed
  @override
  void deactivate() {
    _clearDependencies();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// this class is used to define onChange callback for one Notifier
class MultiProviderListenerItem<T extends BaseNotifier> {
  /// provider to listen the changes
  final BaseProvider<T> provider;

  /// callback to listen the new events
  final _ProviderListenerCallback<T> onChange;

  MultiProviderListenerItem({
    required this.provider,
    required this.onChange,
  });
}
