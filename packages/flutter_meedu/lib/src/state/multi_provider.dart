import 'package:flutter/widgets.dart';
import 'package:meedu/get.dart';
import 'package:meedu/state.dart';
import 'provider.dart';

/// [MultiProvider] converts the [Provider] list into a tree of nested
/// [Provider] widgets.
/// As a result, the only advantage of using [MultiProvider] is improved
/// readability due to the reduction in nesting and boilerplate.
class MultiProvider extends StatefulWidget {
  final Widget child;
  final List<MultiProviderItem> providers;
  MultiProvider({Key? key, required this.child, required this.providers})
      : assert(providers.length > 0),
        super(key: key);

  @override
  _MultiProviderState createState() => _MultiProviderState();
}

class _MultiProviderState extends State<MultiProvider> {
  Map<BaseNotifier, MultiProviderItem> _providers = {};

  @override
  void initState() {
    super.initState();

    for (final provider in widget.providers) {
      final notifier = provider.create(context);
      provider.saveNotifierIntoDependencies(notifier);
      _providers[notifier] = provider;
      notifier.onInit();
    }

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // if the controller is not disposed
      _providers.forEach((notifier, provider) {
        if (!notifier.disposed && this.mounted) {
          notifier.onAfterFirstLayout();
          if (provider.onAfterFirstLayout != null)
            provider.onAfterFirstLayout!(context, notifier);
        }
      });
    });
  }

  @override
  void dispose() {
    _providers.forEach((notifier, provider) {
      if (!notifier.disposed) {
        notifier.onDispose();
        if (provider.onDispose != null) provider.onDispose!(context, notifier);
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class MultiProviderItem<T extends BaseNotifier> {
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

  MultiProviderItem({
    required this.create,
    this.tag,
    this.onInit,
    this.onAfterFirstLayout,
    this.onDispose,
  });

  void saveNotifierIntoDependencies(T value, {String? tag}) {
    Get.i.put<T>(value, tag: tag);
  }
}
