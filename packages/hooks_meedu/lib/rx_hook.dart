import 'package:flutter/widgets.dart' show BuildContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_meedu/meedu.dart';

class _RxHook<T> extends Hook<Rx<T>> {
  const _RxHook({
    super.keys,
    required this.initialValue,
  });

  final T initialValue;

  @override
  _RxHookState<T> createState() => _RxHookState();
}

class _RxHookState<T> extends HookState<Rx<T>, _RxHook<T>> {
  late final _rx = Rx(hook.initialValue);

  @override
  void dispose() {
    _rx.close();
    super.dispose();
  }

  @override
  Rx<T> build(BuildContext context) => _rx;
}

Rx<T> useRx<T>(T initialValue) {
  return use(
    _RxHook<T>(
      initialValue: initialValue,
    ),
  );
}
