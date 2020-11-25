import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:meedu/src/meedu_controller.dart';

class MeeduBuilder<T extends MeeduController> extends StatefulWidget {
  final String id;
  final Widget Function(BuildContext, T) builder;
  MeeduBuilder({
    Key key,
    this.id,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  _MeeduBuilderState createState() => _MeeduBuilderState<T>();
}

class _MeeduBuilderState<T extends MeeduController> extends State<MeeduBuilder<T>> {
  StreamSubscription _subscription;
  MeeduController _controller;

  @override
  void initState() {
    super.initState();
    _controller = context.read<T>();
    // listen the update events
    _subscription = _controller.stream.listen((List<String> listeners) {
      if (listeners.isNotEmpty) {
        if (widget.id != null && listeners.contains(widget.id)) {
          setState(() {});
        }
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _controller);
  }
}
