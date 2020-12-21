import 'package:flutter/widgets.dart';

import 'base_builder.dart';
import '../controllers/simple_controller.dart';

class SimpleBuilder<T extends SimpleController> extends BaseBuilder<T, List<String>> {
  /// When you force rerender using the update() method you can only update certains [MeeduBuilder]
  /// using update(["your_id","other_id"]) so if you want update this [MeeduBuilder] you sould use one id like
  /// "your_id" or "other_id"
  final String id;

  SimpleBuilder({
    Key key,
    @required Widget Function(T) builder,
    this.id,
    VoidCallback initState,
    VoidCallback didChangeDependencies,
    void Function(SimpleBuilder<T> oldWidget) didUpdateWidget,
    VoidCallback dispose,
    bool allowRebuild = true,
  }) : super(
          key: key,
          builder: builder,
          initState: initState,
          didChangeDependencies: didChangeDependencies,
          dispose: dispose,
          didUpdateWidget: didUpdateWidget,
          allowRebuild: allowRebuild,
        );

  @override
  _SimpleBuilderState createState() => _SimpleBuilderState<T>();
}

class _SimpleBuilderState<T extends SimpleController> extends BaseBuilderState<T, List<String>> {
  @override
  void subscribe() {
    // listen the update events
    this.controller.addListener(_subscribe);
  }

  _subscribe() {
    final listeners = this.controller.data;
    if (listeners.isNotEmpty) {
      // if the update method was called with ids
      // if the current MeeduBuilder id is inside the listeners
      final id = (widget as SimpleBuilder).id;
      if (id != null && listeners.contains(id)) {
        setState(() {});
      }
    } else {
      // update the widget if  listeners is empty
      setState(() {});
    }
  }

  @override
  void unsubscribe() {
    this.controller.removeListener(_subscribe);
  }
}
