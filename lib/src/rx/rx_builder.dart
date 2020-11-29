import 'dart:async';

import 'package:flutter/widgets.dart';
import 'rx.dart';

class RxBuilder extends StatefulWidget {
  /// a list of observables
  final List<Rx> observables;

  /// the builder function
  final Widget Function() builder;
  RxBuilder({Key key, @required this.observables, @required this.builder})
      : assert(builder != null && observables != null),
        super(key: key);

  @override
  _RxBuilderState createState() => _RxBuilderState();
}

class _RxBuilderState extends State<RxBuilder> {
  /// a list of StreamSubscription for each observable
  List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    _addSubsciptions(); // listen the observable events
  }

  @override
  void dispose() {
    // remove the subsciptions when the widget is destroyed
    _removeSubscriptions();
    super.dispose();
  }

  /// read all observables and creates a subscription for each one
  Future<void> _addSubsciptions() async {
    widget.observables.forEach((e) {
      _subscriptions.add(_addListener(e));
    });
  }

  /// create a [StreamSubscription] of a given Rx [observable]
  StreamSubscription _addListener(Rx observable) {
    return observable.stream.listen((_) {
      setState(() {});
    });
  }

  /// remove all subscriptions
  Future<void> _removeSubscriptions() async {
    final tasks = _subscriptions.map((e) => e.cancel());
    await Future.wait(tasks);
    _subscriptions.clear();
  }

  @override
  void didUpdateWidget(covariant RxBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    _removeSubscriptions().then((_) {
      _addSubsciptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }
}
