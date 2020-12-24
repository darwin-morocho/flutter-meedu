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
      child: Builder(builder: (__) {
        final RxController _ = Get.i.find<RxController>();
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RxBuilder(
                  observables: [_.time],
                  builder: (ctx) => Text("--> ${_.time.value}"),
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
      }),
    );
  }
}

class RxController extends SimpleController {
  Rx<int> time = 0.obs;
  Timer timer;
  bool running = false;

  onToggle() {
    timer?.cancel();
    running = !running;
    if (running) {
      time.value = 10;
      timer = Timer.periodic(Duration(seconds: 1), (_) {
        time.value--;
        if (time.value == 0) {
          timer.cancel();
          running = false;
          update();
        }
      });
    }

    update();
  }

  @override
  Future<void> onDispose() {
    timer?.cancel();
    time.close();
    return super.onDispose();
  }
}
