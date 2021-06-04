import 'package:flutter_meedu/meedu.dart';

class CounterController extends SimpleNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notify();
  }

  @override
  void onDispose() {
    print("counter disposed");
    super.onDispose();
  }
}
