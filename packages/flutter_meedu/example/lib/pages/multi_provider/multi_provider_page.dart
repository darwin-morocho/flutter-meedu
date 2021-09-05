import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu_example/controllers/counter_controller.dart';
import 'package:meedu_example/controllers/login_controller.dart';

final _conterProvider = SimpleProvider(
  (_) => CounterController(),
);

final _loginProvider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);

class MultiProviderPage extends StatelessWidget {
  const MultiProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProviderListener(
      items: [
        MultiProviderListenerItem<CounterController>(
          provider: _conterProvider,
          onChange: (_, controller) {
            print("🔥 ${controller.counter}");
          },
        ),
        MultiProviderListenerItem<LoginController>(
          provider: _loginProvider,
          onChange: (_, controller) {
            print("🥶 ${controller.state.email}");
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Consumer(
                    builder: (_, watch, __) {
                      final counter = watch(
                        _conterProvider.ids(() => ['id']),
                      ).counter;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("$counter"),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _conterProvider.read.increment();
                            },
                            child: Icon(Icons.add),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Consumer(
                    builder: (_, watch, __) {
                      final controller = watch(_loginProvider);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${controller.state.email}"),
                            SizedBox(height: 20),
                            CupertinoTextField(
                              onChanged: controller.onEmailChanged,
                            ),
                          ],
                        ),
                      );
                    },
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
