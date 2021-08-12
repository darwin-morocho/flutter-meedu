import 'package:flutter/widgets.dart';
import 'package:meedu/provider.dart';
import 'package:meedu/state.dart';

/// a typedef for a common callback
typedef _ProviderListenerCallback<T> = void Function(
  BuildContext _,
  T notifier,
);

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

class _ProviderListenerState<T extends BaseNotifier> extends State<ProviderListener<T>> {
  /// the notifier attached to widget.provider
  late T _notifier;

  @override
  void initState() {
    super.initState();

    /// read and save the provider
    _notifier = widget.provider.read;

    /// check if the onChange callback is defined
    if (widget.onChange != null) {
      // add a listener for the current notifier
      _notifier.addListener(_listener);
    }

    // check if the onInitState callback needs to be called
    if (widget.onInitState != null) {
      widget.onInitState!(context, _notifier);
    }

    // check if the onAfterFirstLayout callback needs to be called
    if (widget.onAfterFirstLayout != null) {
      // wait after first frame
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (mounted) {
          widget.onAfterFirstLayout!(context, _notifier);
        }
      });
    }
  }

  /// listen when the widget is disposed
  /// and remove the listeners
  @override
  void dispose() {
    if (widget.onChange != null) {
      _notifier.removeListener(_listener);
    }

    // check if the onDispose callback
    // needs to be called
    if (widget.onDispose != null)
      widget.onDispose!(
        this.context,
        _notifier,
      );
    super.dispose();
  }

  /// listen when the widget is updated
  /// due to the properties has changes or for hot reaload
  @override
  void didUpdateWidget(covariant ProviderListener<T> oldWidget) {
    if (oldWidget.onChange == null && widget.onChange != null) {
      _notifier.addListener(_listener);
    } else if (oldWidget.onChange != null && widget.onChange == null) {
      _notifier.removeListener(_listener);
    }
    super.didUpdateWidget(oldWidget);
  }

  /// listen all notify events of one notifier
  /// and call to onChange callback
  void _listener(_) {
    if (widget.onChange != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        // before call onChange we need to check
        // if the widget is mounted
        if (mounted) {
          widget.onChange!(context, _notifier);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _notifier);
  }
}
