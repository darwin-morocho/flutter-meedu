import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';

import 'controller/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (_, ref, __) {
            final controller = ref.watch(homeProvider);
            return Text("${controller.counter}");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: homeProvider.read.increment,
      ),
    );
  }
}
  