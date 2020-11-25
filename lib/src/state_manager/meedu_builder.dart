import 'dart:async';
import 'package:meedu/meedu.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:meedu/src/state_manager/meedu_controller.dart';

class MBuilder<T extends MController> extends StatefulWidget {
  final String id;
  final Widget Function(T) builder;
  final T controller;
  final void Function(State state) initState, didChangeDependencies, dispose;
  final void Function(MBuilder oldWidget, State state) didUpdateWidget;

  MBuilder({
    Key key,
    this.id,
    @required this.builder,
    this.controller,
    this.initState,
    this.dispose,
    this.didChangeDependencies,
    this.didUpdateWidget,
  })  : assert(builder != null),
        super(key: key);

  @override
  _MBuilderState createState() => _MBuilderState<T>();
}

class _MBuilderState<T extends MController> extends State<MBuilder<T>> {
  StreamSubscription _subscription;
  MController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.initState != null) widget.initState(this);

    _controller = widget.controller ?? context.read<T>(); // get the controller for this MBuilder

    // listen the update events
    _subscription = _controller.stream.listen((List<String> listeners) {
      if (listeners.isNotEmpty) {
        // if the update method was called with ids
        // if the current MBuilder id is inside the listeners
        if (widget.id != null && listeners.contains(widget.id)) {
          setState(() {});
        }
      } else {
        // update the widget if  listeners is empty
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel(); // cancel the listener for updates
    if (widget.dispose != null) widget.dispose(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.didUpdateWidget != null) widget.didUpdateWidget(oldWidget, this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.didChangeDependencies != null) widget.didChangeDependencies(this);
  }

  @override
  Widget build(BuildContext context) {
    // if this MBuilder is the creator
    if (widget.controller != null) {
      return MProvider(controller: widget.controller, child: widget.builder(_controller));
    }
    return widget.builder(_controller);
  }
}
