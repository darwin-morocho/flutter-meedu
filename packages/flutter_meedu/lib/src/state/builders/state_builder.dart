import 'package:flutter/widgets.dart' show Widget, VoidCallback, Key;
import 'package:meedu/state.dart' show StateNotifier;
import 'base_builder.dart';

class StateBuilder<T extends StateNotifier<S>, S> extends BaseBuilder<T, S> {
  /// use this if you want to define a condition to rebuild the widget
  final bool Function(S oldState, S newState)? buildWhen;

  const StateBuilder({
    Key? key,
    this.buildWhen,
    required Widget Function(T) builder,
    VoidCallback? initState,
    VoidCallback? didChangeDependencies,
    void Function(StateBuilder<T, S> oldWidget)? didUpdateWidget,
    VoidCallback? dispose,
    bool allowRebuild = true,
    String? tag,
  }) : super(
          key: key,
          builder: builder,
          initState: initState,
          didChangeDependencies: didChangeDependencies,
          dispose: dispose,
          didUpdateWidget: didUpdateWidget as void Function(BaseBuilder<T, S>)?,
          allowRebuild: allowRebuild,
          tag: tag,
        );

  @override
  _StateBuilderState createState() => _StateBuilderState<T, S>();
}

class _StateBuilderState<T extends StateNotifier<S>, S> extends BaseBuilderState<T, S> {
  /// save the previous state
  late S _oldState;

  /// listener for update events
  ListenerCallback<S>? _listener;

  @override
  void initState() {
    super.initState();
    _oldState = this.controller.state;
  }

  @override
  void subscribe() {
    // listen the update events
    _listener = (S newState) {
      final buildWhen = (widget as StateBuilder<T, S>).buildWhen;
      // if the buildWhen param is defined
      if (buildWhen != null) {
        /// check if the condition allows the rebuild
        if (buildWhen(_oldState, newState)) {
          setState(() {});
        }
      } else {
        setState(() {});
      }
      _oldState = newState;
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
