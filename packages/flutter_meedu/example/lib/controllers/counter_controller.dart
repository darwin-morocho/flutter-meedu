import 'package:equatable/equatable.dart';
import 'package:flutter_meedu/meedu.dart';

class CounterController extends SimpleNotifier {
  int _counter = 0;
  int get counter => _counter;
  Demo _demo = Demo(100);
  Demo get demo => _demo;

  void increment() {
    _counter++;
    notify(['id']);
  }

  void incrementDemo() {
    _demo = _demo.update(_demo.counter + 1);
    notify();
  }

  @override
  void onDispose() {
    print("counter disposed");
    super.onDispose();
  }
}

class Demo extends Equatable {
  final int counter;

  Demo(this.counter);

  Demo update(int counter) => Demo(counter);

  @override
  List<Object?> get props => [counter];
}
