import 'package:flutter/material.dart';
import 'package:meedu/provider.dart';
import 'package:meedu/state.dart';

import '../widgets/watch_filter.dart';

typedef _ListenerCallback<T> = void Function(T);
typedef _ProviderListenerCallback<Notifier> = void Function(
  BuildContext,
  Notifier,
);

/// this class allows you listen the changes in multiples providers
class MultiProviderListener extends StatefulWidget {
  // ignore: public_member_api_docs
  MultiProviderListener({
    Key? key,
    required this.items,
    required this.child,
    this.onInitState,
    this.onAfterFirstLayout,
    this.onDispose,
  }) : super(key: key);

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

  @override
  _MultiProviderListenerState createState() => _MultiProviderListenerState();
}

class _MultiProviderListenerState extends State<MultiProviderListener> {
  Map<BaseNotifier, List<_ListenerCallback>> _dependencies = {};

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
      WidgetsBinding.instance.addPostFrameCallback((_) {
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
      final target = item.provider is Target ? item.provider as Target : null;
      final BaseNotifier notifier = target != null
          ? target.notifier
          : (item.provider as BaseProvider).read;

      if (!_dependencies.containsKey(notifier)) {
        _dependencies[notifier] = [];
      }

      if (target != null) {
        target.rebuild = () {
          if (mounted) {
            // ignore: avoid_dynamic_calls
            (item as dynamic).onChange(context, notifier);
          }
        };

        if (notifier is SimpleNotifier) {
          if (target.filter == Filter.select) {
            createSimpleSelectListener(target);
          }
        } else {
          if (target.filter == Filter.select) {
            createStateSelectListener(target);
          } else {
            createWhenListener(target);
          }
        }
        final listener = target.listener;
        (notifier as ListeneableNotifier).addListener(listener);
        _dependencies[notifier]?.add(listener);
      } else {
        // ignore: prefer_function_declarations_over_variables
        final listener = (_) {
          // before call onChange we need to check
          // if the widget is mounted
          if (mounted) {
            // ignore: avoid_dynamic_calls
            (item as dynamic).onChange(context, notifier);
          }
        };
        (notifier as ListeneableNotifier).addListener(listener);
        _dependencies[notifier]?.add(listener);
      }
    }
  }

  /// clear the listeners for this widget
  void _clearDependencies() {
    for (final item in _dependencies.entries) {
      final notifier = item.key;
      if (!notifier.disposed) {
        // ignore: prefer_foreach
        for (final listener in item.value) {
          (notifier as ListeneableNotifier).removeListener(listener);
        }
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
class MultiProviderListenerItem<Notifier extends BaseNotifier> {
  // ignore: public_member_api_docs
  MultiProviderListenerItem({
    required this.provider,
    required this.onChange,
  });

  /// provider to listen the changes
  final ListeneableProvider<Notifier> provider;

  /// callback to listen the new events
  final _ProviderListenerCallback<Notifier> onChange;
}
