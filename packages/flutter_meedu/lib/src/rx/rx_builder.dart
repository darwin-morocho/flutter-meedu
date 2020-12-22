import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meedu/rx.dart';

class RxBuilder extends StatefulWidget {
  /// a list of observables
  final List<Rx> observables;

  /// the builder function
  final Widget Function(BuildContext context) builder;
  RxBuilder({Key key, @required this.observables, @required this.builder})
      : assert(builder != null && observables != null),
        super(key: key);

  @override
  _RxBuilderState createState() => _RxBuilderState();
}

class _RxBuilderState extends State<RxBuilder> {
  /// a list of StreamSubscription for each observable
  List<StreamSubscription> _subscriptions = [];

  List<int> _hashes(List<Rx> observables) => observables.map((e) => e.hashCode).toList();

  bool _observablesHasBeenChanged(List<int> oldHashes, List<int> newHashes) {
    return listEquals(oldHashes, newHashes);
  }

  @override
  void initState() {
    super.initState();
    _addSubscriptions(); // listen the observable events
  }

  @override
  void dispose() {
    // remove the subsciptions when the widget is destroyed
    _removeSubscriptions();
    super.dispose();
  }

  /// read all observables and creates a subscription for each one
  Future<void> _addSubscriptions() async {
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
    final oldHashes = _hashes(oldWidget.observables);
    final newHashes = _hashes(widget.observables);
    final bool hasBeenChanged = !_observablesHasBeenChanged(oldHashes, newHashes);
    if (hasBeenChanged) {
      _removeSubscriptions().then((_) {
        _addSubscriptions();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
