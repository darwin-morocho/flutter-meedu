import 'package:flutter/widgets.dart';
import 'package:meedu/provider.dart';
import 'package:meedu/state.dart';

/// A widget to listen events in a SimpleProvider or a StateProvider
///
/// THis widget only listen the events, does not update the widget when a SimpleNotifier or a StateNotifier emit a new event
class ProviderListener<T extends BaseNotifier> extends StatefulWidget {
  final Widget Function(BuildContext, T) builder;

  /// provider to listen the changes
  final BaseProvider<T> provider;

  /// callback to listen the new events
  final void Function(T) onChanged;

  const ProviderListener({
    Key? key,
    required this.onChanged,
    required this.provider,
    required this.builder,
  }) : super(key: key);

  @override
  _ProviderListenerState createState() => _ProviderListenerState<T>();
}

class _ProviderListenerState<T extends BaseNotifier> extends State<ProviderListener<T>> {
  @override
  void initState() {
    super.initState();
    widget.provider.read.addListener(_listener);
  }

  @override
  void dispose() {
    widget.provider.read.removeListener(_listener);
    super.dispose();
  }

  void _listener(_) {
    widget.onChanged(widget.provider.read);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.provider.read);
  }
}
