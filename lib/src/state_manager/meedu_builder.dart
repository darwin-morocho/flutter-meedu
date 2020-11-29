import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'meedu_controller.dart';
import 'meedu_provider.dart';

class MBuilder<T extends MController> extends StatefulWidget {
  /// When you force rerender using the update() method you can only update certains [Mbuilder]
  /// using update(["your_id","other_id"]) so if you want update this [MBuilder] you sould use one id like
  /// "your_id" or "other_id"
  final String id;

  /// builder function
  final Widget Function(T) builder;

  /// One instance of [MeeduController] it could be null, but you must a parent [MBuilder] with a controller
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
