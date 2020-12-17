import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meedu/get.dart';
import 'package:meedu/rx.dart';
import 'package:meedu/state.dart';
import 'package:meedu_example/modules/home/home_controller.dart';

class RxExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      controller: RxController(),
      child: SimpleBuilder<RxController>(
        allowRebuild: false,
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RxBuilder(
                  observables: [_.time],
                  builder: (ctx) => Text("-> ${_.time.value}"),
                ),
                SimpleBuilder<RxController>(
                  builder: (_) => TextButton(
                    onPressed: _.onToggle,
                    child: Text(!_.running ? "START" : "STOP"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
  void onInit() {
    super.onInit();
    final HomeController homeController = Get.i.find<HomeController>();
    final int homeCounter = homeController.counter;
    print("homeCunter $homeCounter");
    homeController.incremment();
  }

  @override
  Future<void> onDispose() {
    timer?.cancel();
    return super.onDispose();
  }
}
