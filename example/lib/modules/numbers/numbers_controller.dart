import 'package:meedu/state.dart';
import 'package:meedu/rx.dart';

class NumbersController extends MController {
  Rx<int> counter = 0.obs;
  Rx<List<String>> items = Rx([]);

  void increment() {
    counter.value++;
  }

  void addItem() {
    final prevList = List<String>.from(items.value);
    prevList.add(DateTime.now().toString());
    items.value = prevList;
  }

  @override
  Future<void> onDispose() {
    counter.close();
    return super.onDispose();
  }
}
