import 'package:flutter_meedu/meedu.dart';

class HomeController extends SimpleNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notify();
  }
}
  