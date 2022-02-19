import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:meedu/rx.dart';

/// A widget to be used with Observables (instances of Rx)
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_meedu/meedu.dart';
/// import 'package:flutter_meedu/rx.dart';
///
/// class RxPage extends StatefulWidget {
///   @override
///   _RxPageState createState() => _RxPageState();
/// }
///
/// class _RxPageState extends State<RxPage> {
///   final _counter = Rx<int>(0); // create an observable
///
///   @override
///   void dispose() {
///     _counter.close(); // You must call to close when you don't need the observable any more
///     super.dispose();
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: RxBuilder(
///           (_) => Text("${_counter.value}"),
///         ),
///       ),
///       floatingActionButton: FloatingActionButton(
///         onPressed: () {
///           _counter.value++;
///         },
///       ),
///     );
///   }
/// }
/// ```
class RxBuilder extends StatefulWidget {
  // ignore: public_member_api_docs
  RxBuilder(this.builder, {Key? key}) : super(key: key);

  /// the builder function
  final Widget Function(BuildContext context) builder;

  @override
  _RxBuilderState createState() => _RxBuilderState();
}

class _RxBuilderState extends State<RxBuilder> {
  _RxBuilderState() {
    _observer = RxNotifier();
  }

  RxNotifier? _observer;
  late StreamSubscription _subscription;
  bool _afterFirstLayout = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _afterFirstLayout = true;
    });
    // listen the observable events
    _subscription = _observer!.listen(_rebuild);
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
    if (_afterFirstLayout && mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final observer = RxNotifier.proxy;

    RxNotifier.proxy = _observer;
    final result = widget.builder(context);
    if (!_observer!.canUpdate) {
      throw FlutterError(
        '''
      If you are seeing this error, you probably did not insert any observable variables into RxBuilder   
      ''',
      );
    }
    RxNotifier.proxy = observer;
    return result;
  }
}
