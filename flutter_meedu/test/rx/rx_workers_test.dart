import 'dart:async';

import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('RxReaction', () async {
    var completer = Completer();
    late Timer timer;
    const times = 10;
    var i = 0;
    final c = SearchController();
    expect(c.text, '');
    expect(c.hasListeners, false);
    c.init();
    timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (i == 1) {
        c.onTextChange('${c.text}-');
      } else if (i < times - 1) {
        c.onTextChange('${c.text}@');
      } else {
        c.onTextChange('${c.text}-');
      }

      i++;
      print('$i ---    ${c.text}');
      if (i == times) {
        timer.cancel();
        completer.complete();
      }
    });
    expect(c.once, '');
    await completer.future;

    expect(c.debounce, '');
    await Future.delayed(const Duration(milliseconds: 100));
    expect(c.once, '@-');
    expect(c.onceWithOutCondition, '@');
    expect(c.interval.length >= 9, true);
    expect(c.debounce, '@-@@@@@@@-');
    expect(c.everWithOutCondition, '@-@@@@@@@-');
    expect(c.ever, '@-@@@@@@@');
    expect(c.hasListeners, true);
    c.dispose();
    expect(c.hasListeners, false);
  });
}

class SearchController {
  final Rx<String> _text = ''.obs;
  String? get text => _text.value;

  bool get hasListeners => _text.hasListeners;

  RxReaction? _debounce,
      _ever,
      _everWithOutCondition,
      _once,
      _onceWithOutCondition,
      _interval;
  String debounce = '',
      ever = '',
      everWithOutCondition = '',
      once = '',
      onceWithOutCondition = '',
      interval = '';

  void onTextChange(String text) {
    _text.value = text;
  }

  void init() {
    _debounce = _text.debounce(
      const Duration(milliseconds: 100),
      (value) {
        debounce = value;
      },
    );
    _ever = _text.ever(
      (value) {
        ever = value;
      },
      condition: ((value) => value[value.length - 1] == '@'),
    );

    _everWithOutCondition = _text.ever(
      (value) {
        everWithOutCondition = value;
      },
    );

    _onceWithOutCondition = _text.once(
      (value) {
        onceWithOutCondition = value;
      },
    );

    _once = _text.once(
      (value) {
        once = value;
      },
      condition: ((value) => value.contains('-')),
    );

    _interval = _text.interval(
      const Duration(milliseconds: 50),
      (value) {
        interval = value;
      },
    );
  }

  void dispose() {
    _text.close();
    _debounce?.dispose();
    _ever?.dispose();
    _once?.dispose();
    _interval?.dispose();
    _onceWithOutCondition?.dispose();
    _everWithOutCondition?.dispose();
  }
}
