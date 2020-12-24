import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu/state.dart' show BaseController;
import 'package:provider/single_child_widget.dart';

// ignore: must_be_immutable
abstract class ProviderPage<T extends BaseController>
    extends SingleChildStatelessWidget {
  /// function that is responsible for
  /// creating the [SimpleController] or [StateController] and a child which will have access
  /// to the instance via `Provider.of<...>(context)`.
  T create(BuildContext context);

  Widget buildPage(BuildContext context, T controller);

  /// (must be unique, don't use list's index) use this when you have in the same page or widget
  /// mutiples [Provider] that uses a controller of the same class for example in lists that you want each item has
  /// its own controller
  final String tag;

  ProviderPage({Key key, this.tag}) : super(key: key);

  /// overrride this method to listen when the provider is inserted into the widget tree
  void onInit(BuildContext context, T controller) {}

  /// overrride this method to listen when the provider was rendered
  void onAfterFirstLayout(BuildContext context, T controller) {}

  /// overrride this method to listen when the provider is disposed
  void onDispose(BuildContext context, T controller) {}

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return Provider<T>(
      create: this.create,
      onInit: this.onInit,
      onAfterFirstLayout: this.onAfterFirstLayout,
      onDispose: this.onDispose,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return this.buildWithChild(
      context,
      Builder(
        builder: (context) {
          return this.buildPage(
            context,
            Provider.of<T>(context),
          );
        },
      ),
    );
  }
}
