import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'meedu_controller.dart';
import 'meedu_provider.dart';

class MeeduBuilder<T extends MeeduController> extends StatefulWidget {
  /// When you force rerender using the update() method you can only update certains [MeeduBuilder]
  /// using update(["your_id","other_id"]) so if you want update this [MeeduBuilder] you sould use one id like
  /// "your_id" or "other_id"
  final String id;

  /// builder function
  final Widget Function(T) builder;

  /// One instance of [MeeduController] it could be null, but you must a parent [MeeduBuilder] with a controller
  final T controller;

  final void Function(State state) initState, didChangeDependencies, dispose;
  final void Function(MeeduBuilder oldWidget, State state) didUpdateWidget;

  MeeduBuilder({
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
  _MeeduBuilderState createState() => _MeeduBuilderState<T>();
}

class _MeeduBuilderState<T extends MeeduController>
    extends State<MeeduBuilder<T>> {
  StreamSubscription _subscription;
  MeeduController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.initState != null) widget.initState(this);
    // get the controller for this MeeduBuilder
    _controller = widget.controller ?? context.read<T>();

    // listen the update events
    _subscription = _controller.stream.listen((List<String> listeners) {
      if (listeners.isNotEmpty) {
        // if the update method was called with ids
        // if the current MeeduBuilder id is inside the listeners
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
  void didUpdateWidget(covariant MeeduBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.didUpdateWidget != null) widget.didUpdateWidget(oldWidget, this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.didChangeDependencies != null)
      widget.didChangeDependencies(this);
  }

  @override
  Widget build(BuildContext context) {
    // if this MeeduBuilder is the creator
    if (widget.controller != null) {
      return MeeduProvider(
          controller: widget.controller, child: widget.builder(_controller));
    }
    return widget.builder(_controller);
  }
}
