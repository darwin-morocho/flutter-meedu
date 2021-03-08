import 'package:meedu/get.dart';
import 'package:meedu/state.dart' show BaseController;
import 'package:flutter/widgets.dart'
    show
        Widget,
        VoidCallback,
        required,
        Key,
        StatefulWidget,
        State,
        BuildContext;

typedef ListenerCallback<T> = void Function(T);

/// this widget define the basic Builder properties and render logic for [SimpleBuilder] and [StateBuilder]
abstract class BaseBuilder<T extends BaseController<S>, S>
    extends StatefulWidget {
  /// the builder function that render the widget when the controller notify changes
  final Widget Function(T) builder;

  /// use this if you don't want rebuild this widget when update() is called
  final bool allowRebuild;

  /// callback when initState is called
  final VoidCallback initState;

  /// callback when didChangeDependencies is called
  final VoidCallback didChangeDependencies;

  /// callback when dispose is called
  final VoidCallback dispose;

  /// callback when didUpdateWidget is called
  final void Function(BaseBuilder<T, S> oldWidget) didUpdateWidget;

  final String tag;

  const BaseBuilder({
    Key key,
    @required this.builder,
    this.initState,
    this.didChangeDependencies,
    this.dispose,
    this.didUpdateWidget,
    this.allowRebuild,
    this.tag,
  })  : assert(builder != null),
        super(key: key);

  @override
  BaseBuilderState createState();
}

/// this calss define the State's logic for [SimpleBuilder] and [StateBuilder]
abstract class BaseBuilderState<T extends BaseController<S>, S>
    extends State<BaseBuilder<T, S>> {
  bool _initialized = false;

  T _controller;
  T get controller => _controller;

  /// this methods must be override to implement the subscribe events
  void subscribe();

  /// this methods must be override to implement the unsubscribe logic
  void unsubscribe();

  @override
  void initState() {
    if (!_initialized) {
      // get the controller for this MeeduBuilder
      _controller = Get.i.find<T>(tag: widget.tag);

      // if the widget is allowed to listening update events
      if (widget.allowRebuild) {
        subscribe();
      }
      if (widget.initState != null) widget.initState();
    }

    _initialized = true;
    super.initState();
  }

  @override
  void dispose() {
    unsubscribe(); // cancel the listener for updates
    if (widget.dispose != null) widget.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BaseBuilder<T, S> oldWidget) {
    if (widget.didUpdateWidget != null) widget.didUpdateWidget(oldWidget);
    if (oldWidget.allowRebuild != widget.allowRebuild) {
      if (widget.allowRebuild) {
        subscribe();
      } else {
        unsubscribe(); // cancel the listener for updates
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.didChangeDependencies != null) widget.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_controller);
  }
}
