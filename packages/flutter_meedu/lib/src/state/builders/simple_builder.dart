import 'package:flutter/widgets.dart' show Widget, VoidCallback, Key;
import 'package:meedu/state.dart' show SimpleNotifier;
import 'base_builder.dart';

class SimpleBuilder<T extends SimpleNotifier> extends BaseBuilder<T, List<String>> {
  /// When you force rerender using the update() method you can only update certains [MeeduBuilder]
  /// using update(["your_id","other_id"]) so if you want update this [MeeduBuilder] you sould use one id like
  /// "your_id" or "other_id"
  final String? id;

  SimpleBuilder({
    Key? key,
    required Widget Function(T) builder,
    this.id,
    VoidCallback? initState,
    VoidCallback? didChangeDependencies,
    void Function(SimpleBuilder<T> oldWidget)? didUpdateWidget,
    VoidCallback? dispose,
    bool allowRebuild = true,
    String? tag,
  }) : super(
          key: key,
          builder: builder,
          initState: initState,
          didChangeDependencies: didChangeDependencies,
          dispose: dispose,
          didUpdateWidget: didUpdateWidget as void Function(BaseBuilder<T, List<String>>)?,
          allowRebuild: allowRebuild,
          tag: tag,
        );

  @override
  _SimpleBuilderState createState() => _SimpleBuilderState<T>();
}

class _SimpleBuilderState<T extends SimpleNotifier> extends BaseBuilderState<T, List<String>> {
  /// listener for update events
  ListenerCallback<List<String>>? _listener;

  @override
  void subscribe() {
    // listen the update events
    _listener = (List<String> listeners) {
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
    };
    this.controller.addListener(_listener!);
  }

  @override
  void unsubscribe() {
    if (_listener != null) {
      this.controller.removeListener(_listener!);
    }
  }
}
