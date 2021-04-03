import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meedu/rx.dart';

class RxBuilder extends StatefulWidget {
  /// the builder function
  final Widget Function() builder;
  RxBuilder(this.builder, {Key? key}) : super(key: key);
  @override
  _RxBuilderState createState() => _RxBuilderState();
}

class _RxBuilderState extends State<RxBuilder> {
  RxNotifier? _observer;
  late StreamSubscription _subscription;
  bool _afterFirstLayout = false;

  _RxBuilderState() {
    _observer = RxNotifier();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _afterFirstLayout = true;
    });
    // listen the observable events
    _subscription = _observer!.listen(this._rebuild);
  }

  @override
  void dispose() {
    _afterFirstLayout = false;
    // remove the subsciptions when the widget is destroyed
    _subscription.cancel();
    _observer?.close();
    super.dispose();
  }

  void _rebuild(_) {
    if (_afterFirstLayout && this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final observer = RxNotifier.proxy;

    RxNotifier.proxy = _observer;
    final result = widget.builder();
    if (!_observer!.canUpdate) {
      throw """
      If you are seeing this error, you probably did not insert any observable variables into RxBuilder   
      """;
    }
    RxNotifier.proxy = observer;
    return result;
  }
}
