import 'package:flutter/widgets.dart';
import 'package:meedu/get.dart';
import 'package:meedu/src/state_managment/controllers/base_controller.dart';
import 'package:provider/provider.dart' as p;
import 'package:provider/single_child_widget.dart';

/// class to inject a controller into the widgets tree
///
/// By defaul the [Provider] injects the controller using [Get.i.put] and remove it when the provider is destroyed
class Provider<T extends BaseController> extends SingleChildStatelessWidget {
  /// function that is responsible for
  /// creating the [SimpleController] or [StateController] and a child which will have access
  /// to the instance via `Provider.of<...>(context)`.
  final T Function(BuildContext context) create;

  /// (must be unique, don't use list's index) use this when you have in the same page or widget
  /// mutiples [Provider] that uses controller of the same class for example in lists that you want each item has
  /// its own controller
  final String tag;

  Provider({
    Key key,
    @required this.create,
    this.tag,
    Widget child,
  })  : assert(create != null),
        super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    // use the InheritedProvider to inject the controller and catch the life cycle widget
    return p.InheritedProvider<T>(
      create: (_) {
        final T controller = this.create(_);
        Get.i.put<T>(controller, tag: this.tag);
        return controller;
      },
      child: child,
      lazy: false,
      dispose: (_, controller) {
        Get.i.remove<T>(tag: this.tag);
        return controller.onDispose();
      },
      updateShouldNotify: (_, __) => false,
      startListening: (e, controller) {
        controller.onInit();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // if the controller is not disposed
          if (!controller.disposed) {
            controller.afterFirstLayout();
          }
        });
        return () {};
      },
    );
  }

  /// Search one instance of [BaseController] using the context
  static T of<T extends BaseController>(BuildContext context) {
    return p.Provider.of<T>(context, listen: false);
  }
}
