import 'dart:async';

import 'package:meedu/meedu.dart';
import 'package:test/test.dart';

void main() {
  test("RxWorkers", () async {
    Completer completer = Completer();
    late Timer timer;
    final times = 10;
    int i = 0;
    final c = SearchController();
    expect(c.text, "");
    expect(c.hasListeners, false);
    c.onAfterFirstLayout();
    timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      if (i == 1) {
        c.onTextChange("${c.text}-");
      } else if (i < times - 1) {
        c.onTextChange("${c.text}@");
      } else {
        c.onTextChange("${c.text}-");
      }

      i++;
      print("$i ---    ${c.text}");
      if (i == times) {
        timer.cancel();
        completer.complete();
      }
    });
    expect(c.once, "");
    await completer.future;

    expect(c.debounce, "");
    await Future.delayed(Duration(milliseconds: 100));
    expect(c.once, "@-");
    expect(c.onceWithOutCondition, "@");
    expect(c.interval.length >= 9, true);
    expect(c.debounce, "@-@@@@@@@-");
    expect(c.everWithOutCondition, "@-@@@@@@@-");
    expect(c.ever, "@-@@@@@@@");
    expect(c.hasListeners, true);
    c.onDispose();
    expect(c.hasListeners, false);
  });
}

class SearchController extends SimpleController {
  final Rx<String> _text = "".obs;
  String? get text => _text.value;
  bool get hasListeners => _text.hasListeners;
  RxWorker? _debounceWorker,
      _everWorker,
      _everWithOutConditionWorker,
      _onceWorker,
      _onceWithOutConditionWorker,
      _intervalWorker;
  String debounce = "",
      ever = "",
      everWithOutCondition = "",
      once = "",
      onceWithOutCondition = "",
      interval = "";

  void onTextChange(String text) {
    _text.value = text;
  }

  @override
  void onAfterFirstLayout() {
    _debounceWorker = _text.debounce(
      Duration(milliseconds: 100),
      (value) {
        debounce = value!;
      },
    );
    _everWorker = _text.ever(
      (value) {
        ever = value!;
      },
      condition: ((value) => value![value.length - 1] == "@"),
    );

    _everWithOutConditionWorker = _text.ever(
      (value) {
        everWithOutCondition = value!;
      },
    );

    _onceWithOutConditionWorker = _text.once(
      (value) {
        onceWithOutCondition = value!;
      },
    );

    _onceWorker = _text.once(
      (value) {
        once = value!;
      },
      condition: ((value) => value.contains("-")) as bool Function(String?)?,
    );

    _intervalWorker = _text.interval(
      Duration(milliseconds: 50),
      (value) {
        interval = value!;
      },
    );
  }

  @override
  void onDispose() {
    _text.close();
    _debounceWorker?.dispose();
    _everWorker?.dispose();
    _onceWorker?.dispose();
    _intervalWorker?.dispose();
    _onceWithOutConditionWorker?.dispose();
    _everWithOutConditionWorker?.dispose();
    super.onDispose();
  }
}
