import 'package:meedu/rx.dart';
import 'package:meedu/state.dart';

class SearchController extends SimpleController {
  final Rx<String> _text = "".obs;
  RxWorker? _debounceWorker, _everWorker, _onceWorker, _intervalWorker;

  void onTextChange(String text) {
    _text.value = text;
  }

  @override
  void onAfterFirstLayout() {
    _debounceWorker = _text.debounce(Duration(milliseconds: 500), (value) {
      print("debounce  $value");
    });
    _everWorker = _text.ever(
      (value) {
        print("ever  $value");
      },
      condition: (value) => value.contains("@"),
    );

    _onceWorker = _text.once(
      (value) {
        print("once  $value");
      },
      condition: (value) => value.contains("-"),
    );

    _intervalWorker = _text.interval(Duration(seconds: 2), (value) {
      print("interval  $value");
    });
  }

  @override
  void onDispose() {
    _text.close();
    _debounceWorker?.dispose();
    _everWorker?.dispose();
    _onceWorker?.dispose();
    _intervalWorker?.dispose();
    super.onDispose();
  }
}
