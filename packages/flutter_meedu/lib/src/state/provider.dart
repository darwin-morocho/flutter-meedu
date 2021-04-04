import 'package:flutter/widgets.dart';
import 'package:meedu/get.dart';
import 'package:meedu/state.dart';

typedef ProviderCallback<T> = void Function(BuildContext context, T controller);

/// class to inject a Notifier into the widgets tree
///
/// By defaul the [Provider] injects the controller using [Get.i.put] and remove it when the provider is destroyed
class Provider<T extends BaseNotifier> extends StatefulWidget {
  /// function that is responsible for
  /// creating the [SimpleController] or [StateController] and a child which will have access
  /// to the instance via `Provider.of<...>(context)`.
  final T Function(BuildContext context) create;

  /// (must be unique, don't use list's index) use this when you have in the same page or widget
  /// mutiples [Provider] that uses a controller of the same class for example in lists that you want each item has
  /// its own controller
  final String? tag;

  /// use this callback to listen when the provider is inserted into the widget tree
  final ProviderCallback<T>? onInit;

  /// use this callback to listen when the provider was rendered
  final ProviderCallback<T>? onAfterFirstLayout;

  /// use this callback to listen when the provider is disposed
  final ProviderCallback<T>? onDispose;

  final Widget Function(BuildContext, T notifier) builder;

  Provider({
    Key? key,
    required this.create,
    this.tag,
    this.onInit,
    this.onAfterFirstLayout,
    this.onDispose,
    required this.builder,
  }) : super(key: key);

  @override
  _ProviderState createState() => _ProviderState();

  /// Search one instance of [BaseController]
  static T of<T extends BaseNotifier>({String? tag}) {
    return Get.i.find<T>(tag: tag);
  }
}

class _ProviderState<T extends BaseNotifier> extends State<Provider<T>> {
  late T _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = widget.create(context);
    Get.i.put<T>(_notifier, tag: widget.tag);

    WidgetsBinding.instance!.addPersistentFrameCallback((_) {
      // if the controller is not disposed
      if (!_notifier.disposed) {
        _notifier.onAfterFirstLayout();
        if (widget.onAfterFirstLayout != null) widget.onAfterFirstLayout!(context, _notifier);
      }
    });
  }

  @override
  void dispose() {
    Get.i.remove<T>(tag: widget.tag);
    _notifier.onDispose();
    if (widget.onDispose != null) widget.onDispose!(context, _notifier);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _notifier);
  }
}
