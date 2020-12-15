import 'package:flutter/widgets.dart';
import 'package:meedu/get.dart';
import 'meedu_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// classs to inject a controller into the widgets tree
///
/// By defaul the [MeeduProvider] injects the controller using [Get.i.put] and remove it when the provider is destroyed
class MeeduProvider<T extends MeeduController> extends SingleChildStatelessWidget {
  /// instance that extends of MeeduController
  final T controller;

  /// (must be unique, don't use list's index) use this when you have in the same page or widget
  /// mutiples [MeeduProvider] that uses controller of the same class for example in lists that you want each item has
  /// its own controller
  final String tag;

  MeeduProvider({
    Key key,
    @required this.controller,
    this.tag,
    @required Widget child,
  })  : assert(controller != null && child != null),
        super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    // use the InheritedProvider to inject the controller and catch the life cycle widget
    return InheritedProvider<T>(
      create: (_) {
        Get.i.put<T>(this.controller, tag: this.tag);
        return this.controller;
      },
      child: child,
      lazy: false,
      dispose: (_, controller) {
        Get.i.remove<T>(tag: this.tag);
        return controller.onDispose();
      },
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

  /// Search one instance of MeeduController using the context
  static T of<T extends MeeduController>(BuildContext context) {
    return Provider.of<T>(context, listen: false);
  }
}
