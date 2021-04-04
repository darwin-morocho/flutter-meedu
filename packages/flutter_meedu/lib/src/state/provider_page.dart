import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu/state.dart' show BaseNotifier;

// ignore: must_be_immutable
abstract class ProviderPage<T extends BaseNotifier> extends StatelessWidget {
  /// function that is responsible for
  /// creating the [SimpleController] or [StateController] and a child which will have access
  /// to the instance via `Provider.of<...>(tag:'tag')`.
  T create(BuildContext context);

  /// this function build a widget
  ///
  Widget buildPage(BuildContext context, T notifier);

  /// (must be unique, don't use list's index) use this when you have in the same page or widget
  /// mutiples [Provider] that uses a controller of the same class for example in lists that you want each item has
  /// its own controller
  String? get tag => null;

  ProviderPage({Key? key}) : super(key: key);

  /// overrride this method to listen when the provider is inserted into the widget tree
  void onInit(BuildContext context, T notifier) {}

  /// overrride this method to listen when the provider was rendered
  void onAfterFirstLayout(BuildContext context, T notifier) {}

  /// overrride this method to listen when the provider is disposed
  void onDispose(BuildContext context, T notifier) {}

  @override
  Widget build(BuildContext context) {
    return buildPage(context, this.create(context));
  }
}
