import 'package:flutter/widgets.dart'
    show Widget, BuildContext, StatefulWidget, State, WidgetsBinding, Key;
import 'package:meedu/meedu.dart';

import '../widgets/watch_filter.dart';

/// a typedef for a common callback
typedef _ProviderListenerCallback<T> = void Function(
  BuildContext _,
  T notifier,
);

typedef _Builder<T> = Widget Function(BuildContext, T);

/// A widget to listen events in a SimpleProvider or a StateProvider
///
/// THis widget only listen the events, does not update the widget when a SimpleNotifier or a StateNotifier emit a new event
class ProviderListener<T extends BaseNotifier> extends StatefulWidget {
  // ignore: public_member_api_docs
  const ProviderListener({
    Key? key,
    this.onChange,
    required this.provider,
    required this.builder,
    this.onInitState,
    this.onDispose,
    this.onAfterFirstLayout,
  }) : super(key: key);

  /// callback that must return the widget child of the ProviderListener
  final _Builder<T> builder;

  /// provider to listen the changes
  final ListeneableProvider<T> provider;

  /// callback to listen the new events
  final _ProviderListenerCallback<T>? onChange;

  /// callback when initState is called
  final _ProviderListenerCallback<T>? onInitState;

  /// this callback will be called when the first frame was rendered
  /// use this callback if you want to show a dialog, snackbar or navigate
  /// after the first frame
  final _ProviderListenerCallback<T>? onAfterFirstLayout;

  /// callback when dispose is called
  final _ProviderListenerCallback<T>? onDispose;

  @override
  _ProviderListenerState createState() => _ProviderListenerState<T>();
}

class _ProviderListenerState<T extends BaseNotifier>
    extends State<ProviderListener<T>> {
  /// the notifier attached to widget.provider
  late T _notifier;
  Target? _target;
  void Function(dynamic)? _listener;

  ListeneableNotifier get _listeneableNotifier =>
      _notifier as ListeneableNotifier;

  @override
  void initState() {
    super.initState();

    _target = widget.provider is Target ? widget.provider as Target : null;

    if (_target != null) {
      /// read and save the provider
      _notifier = _target!.notifier;
    } else {
      _notifier = (widget.provider as BaseProvider).read;
    }

    /// check if the onChange callback is defined
    if (widget.onChange != null && _target == null) {
      // add a listener for the current notifier
      _listener = _defaultListener;
      (_notifier as ListeneableNotifier).addListener(_listener!);
    } else if (widget.onChange != null && _target != null) {
      _buildTargetListener();
    }

    // check if the onInitState callback needs to be called
    if (widget.onInitState != null) {
      widget.onInitState!(context, _notifier);
    }

    // check if the onAfterFirstLayout callback needs to be called
    if (widget.onAfterFirstLayout != null) {
      // wait after first frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
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
    if (widget.onChange != null && _listener != null) {
      _listeneableNotifier.removeListener(_listener!);
    }

    // check if the onDispose callback
    // needs to be called
    if (widget.onDispose != null) {
      widget.onDispose!(
        context,
        _notifier,
      );
    }
    super.dispose();
  }

  /// listen when the widget is updated
  /// due to the properties has changes or for hot reaload
  @override
  void didUpdateWidget(covariant ProviderListener<T> oldWidget) {
    if (_listener != null) {
      if (oldWidget.onChange == null && widget.onChange != null) {
        _listeneableNotifier.addListener(_listener!);
      } else if (oldWidget.onChange != null && widget.onChange == null) {
        _listeneableNotifier.removeListener(_listener!);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  /// listen all notify events of one notifier
  /// and call to onChange callback
  void _defaultListener(_) {
    if (widget.onChange != null) {
      // before call onChange we need to check
      // if the widget is mounted
      if (mounted) {
        widget.onChange!(context, _notifier);
      }
    }
  }

  void _buildTargetListener() {
    assert(_target != null);
    _target!.rebuild = () => _defaultListener(null);

    if (_notifier is SimpleNotifier) {
      if (_target!.filter == Filter.select) {
        createSimpleSelectListener(_target!);
      }
    } else {
      if (_target!.filter == Filter.select) {
        createStateSelectListener(_target!);
      } else {
        createWhenListener(_target!);
      }
    }
    _listener = _target!.listener;
    _listeneableNotifier.addListener(_listener!);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _notifier);
  }
}
