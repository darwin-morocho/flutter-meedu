import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/rx.dart';

class RxPage extends StatefulWidget {
  @override
  _RxPageState createState() => _RxPageState();
}

class _RxPageState extends State<RxPage> {
  final _counter = Rx<int>(0);

  @override
  void dispose() {
    _counter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RxBuilder(
          (_) => Text("${_counter.value}"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counter.value++;
        },
      ),
    );
  }
}
