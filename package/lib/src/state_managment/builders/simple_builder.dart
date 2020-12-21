import 'package:flutter/widgets.dart';
import 'package:meedu/src/state_managment/controllers/base_controller.dart';

import 'base_builder.dart';
import '../controllers/simple_controller.dart';

class SimpleBuilder<T extends SimpleController>
    extends BaseBuilder<T, List<String>> {
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

class _SimpleBuilderState<T extends SimpleController>
    extends BaseBuilderState<T, List<String>> {
  BaseListener<List<String>> _listener;

  @override
  void subscribe() {
    // listen the update events
    _listener = BaseListener<List<String>>(
      (listeners) {
        if (listeners.isNotEmpty) {
          // if the update method was called with ids
          // if the current MeeduBuilder id is inside the listeners
          final id = (widget as SimpleBuilder<T>).id;
          if (id != null && listeners.contains(id)) {
            setState(() {});
          }
        } else {
          // update the widget if  listeners is empty
          setState(() {});
        }
      },
    );
    this.controller.addListener(_listener);
  }

  @override
  void unsubscribe() {
    this.controller.removeListener(_listener);
  }
}
