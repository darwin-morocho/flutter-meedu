import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_meedu/rx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_meedu/rx_hook.dart';

void main() {
  testWidgets(
    'useRx',
    (tester) async {
      await tester.pumpWidget(
        _Counter(),
      );
      expect(
        find.text('20'),
        findsOneWidget,
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      expect(
        find.text('21'),
        findsOneWidget,
      );
    },
  );
}

class _Counter extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final rx = useRx(20);
    return GestureDetector(
      onTap: () => rx.value++,
      child: RxBuilder(
        (_) => Text(
          rx.value.toString(),
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
