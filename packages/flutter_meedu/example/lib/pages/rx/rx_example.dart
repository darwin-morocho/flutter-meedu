import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meedu/get.dart';
import 'package:meedu/state.dart';
import 'package:meedu/rx.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/rx.dart';

class RxExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<RxController>(
      create: (_) => RxController(),
      builder: (_, __) {
        final RxController _ = Get.i.find<RxController>();
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RxBuilder(
                  () => Text("--> ${_.time}"),
                ),
                SimpleBuilder<RxController>(
                  allowRebuild: true,
                  builder: (_) => TextButton(
                    onPressed: _.onToggle,
                    child: Text(!_.running ? "START" : "STOP"),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class RxController extends SimpleNotifier {
  Rx<int> _time = 0.obs;
  int get time => _time.value;
  Timer? timer;
  bool running = false;

  onToggle() {
    timer?.cancel();
    running = !running;
    if (running) {
      _time.value = 10;
      timer = Timer.periodic(Duration(seconds: 1), (_) {
        _time.value = time - 1;
        if (time == 0) {
          timer!.cancel();
          running = false;
          update();
        }
      });
    }

    update();
  }

  @override
  void onDispose() {
    timer?.cancel();
    _time.close();
    super.onDispose();
  }
}
