import 'package:flutter/widgets.dart';
import 'package:meedu/get.dart';
import 'package:meedu/state.dart';
import 'package:provider/provider.dart' as p;
import 'package:provider/single_child_widget.dart';

typedef ProviderCallback<T> = void Function(BuildContext context, T controller);

/// class to inject a controller into the widgets tree
///
/// By defaul the [Provider] injects the controller using [Get.i.put] and remove it when the provider is destroyed
class Provider<T extends BaseController> extends SingleChildStatelessWidget {
  /// function that is responsible for
  /// creating the [SimpleController] or [StateController] and a child which will have access
  /// to the instance via `Provider.of<...>(context)`.
  final T Function(BuildContext context) create;

  /// (must be unique, don't use list's index) use this when you have in the same page or widget
  /// mutiples [Provider] that uses a controller of the same class for example in lists that you want each item has
  /// its own controller
  final String tag;

  /// use this callback to listen when the provider is inserted into the widget tree
  final ProviderCallback<T> onInit;

  /// use this callback to listen when the provider was rendered
  final ProviderCallback<T> onAfterFirstLayout;

  /// use this callback to listen when the provider is disposed
  final ProviderCallback<T> onDispose;

  Provider({
    Key key,
    @required this.create,
    this.tag,
    Widget child,
    this.onInit,
    this.onAfterFirstLayout,
    this.onDispose,
  })  : assert(create != null),
        super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    // use the InheritedProvider to inject the controller and catch the life cycle widget
    return p.InheritedProvider<T>(
      create: (_) {
        final T controller = this.create(context);
        Get.i.put<T>(controller, tag: this.tag);
        return controller;
      },
      child: child,
      lazy: false,
      dispose: (context, controller) {
        Get.i.remove<T>(tag: this.tag);
        controller.onDispose();
        if (this.onDispose != null) this.onDispose(context, controller);
      },
      updateShouldNotify: (_, __) => false,
      startListening: (e, controller) {
        controller.onInit();
        if (this.onInit != null) this.onInit(e, controller);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // if the controller is not disposed
          if (!controller.disposed) {
            controller.onAfterFirstLayout();
            if (this.onAfterFirstLayout != null) this.onAfterFirstLayout(e, controller);
          }
        });
        return () {};
      },
    );
  }

  /// Search one instance of [BaseController]
  static T of<T extends BaseController>({String tag}) {
    return Get.i.find<T>(tag: tag);
  }
}
