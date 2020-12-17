import 'package:flutter/widgets.dart';

import '../controllers/state_controller.dart';
import 'base_builder.dart';

class StateBuilder<T extends StateController<S>, S> extends BaseBuilder<T, S> {
  final bool Function(S oldController, S controller) buildWhen;

  const StateBuilder({
    Key key,
    this.buildWhen,
    @required Widget Function(T) builder,
    VoidCallback initState,
    VoidCallback didChangeDependencies,
    void Function(StateBuilder<T, S> oldWidget) didUpdateWidget,
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
  _StateBuilderState createState() => _StateBuilderState<T, S>();
}

class _StateBuilderState<T extends StateController<S>, S> extends BaseBuilderState<T, S> {
  S _oldState;

  @override
  void initState() {
    super.initState();
    _oldState = this.controller.state;
  }

  @override
  void subscribe() {
    // listen the update events
    this.subscription = this.controller.stream.listen((newState) {
      final buildWhen = (widget as StateBuilder<T, S>).buildWhen;
      if (buildWhen != null) {
        if (buildWhen(_oldState, newState)) {
          setState(() {});
        }
      } else {
        setState(() {});
      }
      _oldState = newState;
    });
  }
}
