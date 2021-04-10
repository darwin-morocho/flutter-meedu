import 'package:flutter/widgets.dart';
import 'package:meedu/provider.dart';
import 'package:meedu/state.dart';

typedef _ProviderListenerCallback<T> = void Function(
    BuildContext _, T notifier);

/// A widget to listen events in a SimpleProvider or a StateProvider
///
/// THis widget only listen the events, does not update the widget when a SimpleNotifier or a StateNotifier emit a new event
class ProviderListener<T extends BaseNotifier> extends StatefulWidget {
  final Widget Function(BuildContext, T) builder;

  /// provider to listen the changes
  final BaseProvider<T> provider;

  /// callback to listen the new events
  final _ProviderListenerCallback<T>? onChange;

  /// callback when initState is called
  final _ProviderListenerCallback<T>? onInitState;
  final _ProviderListenerCallback<T>? onAfterFirstLayout;

  /// callback when dispose is called
  final _ProviderListenerCallback<T>? onDispose;

  const ProviderListener({
    Key? key,
    this.onChange,
    required this.provider,
    required this.builder,
    this.onInitState,
    this.onDispose,
    this.onAfterFirstLayout,
  }) : super(key: key);

  @override
  _ProviderListenerState createState() => _ProviderListenerState<T>();
}

class _ProviderListenerState<T extends BaseNotifier>
    extends State<ProviderListener<T>> {
  late T _notifier;
  @override
  void initState() {
    super.initState();
    _notifier = widget.provider.read;
    if (widget.onChange != null) {
      _notifier.addListener(_listener);
    }
    if (widget.onInitState != null) widget.onInitState!(context, _notifier);
    if (widget.onAfterFirstLayout != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (mounted) {
          widget.onAfterFirstLayout!(context, _notifier);
        }
      });
    }
  }

  @override
  void dispose() {
    if (widget.onChange != null) {
      _notifier.removeListener(_listener);
    }
    if (widget.onDispose != null)
      widget.onDispose!(
        this.context,
        _notifier,
      );
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ProviderListener<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.onChange == null && widget.onChange != null) {
      _notifier.addListener(_listener);
    } else if (oldWidget.onChange != null && widget.onChange == null) {
      _notifier.removeListener(_listener);
    }
  }

  void _listener(_) {
    if (widget.onChange != null) {
      widget.onChange!(context, _notifier);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _notifier);
  }
}
