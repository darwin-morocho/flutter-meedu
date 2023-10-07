// ignore_for_file: hash_and_equals

import 'package:flutter_meedu/provider_scope.dart';
import 'package:meta/meta.dart';

import '../notifiers/base_notifier.dart';

typedef Creator<E> = E Function(Ref ref);

abstract class ListeneableProvider<T> {}

abstract class BaseProvider<E> {
  BaseProvider(
    this._creator, {
    this.autoDispose = true,
  });

  final Creator<E> _creator;

  /// callback to override the main creator callback
  Creator<E>? _overriddenCreator;

  final bool autoDispose;
  Ref? _ref;

  /// tell us if the SimpleNotifier or StateNotifier was created
  bool get mounted => _element != null;

  E? _element;

  E get read {
    if (mounted) {
      return _element!;
    }
    _ref ??= Ref();
    // create a new Notifier
    _element = _overriddenCreator != null
        ? _overriddenCreator!(_ref!)
        : _creator(_ref!);

    if (_element is ListeneableNotifier && autoDispose) {
      // ignore: invalid_use_of_protected_member
      (_element as ListeneableNotifier).setDisposableCallback(
        () {
          if (mounted) {
            dispose();
          }
        },
      );
    }
    ProviderScope.instance.add(this);

    return _element!;
  }

  void setArguments<Arguments>(Arguments arguments) {
    _ref ??= Ref();
    _ref?._setArguments(arguments);
  }

  @mustCallSuper
  void dispose() {
    if (!mounted) {
      return;
    }
    _ref?._dispose();
    if (_element is BaseNotifier) {
      (_element as BaseNotifier).dispose();
    }
    _ref = null;
    _element = null;
    _overriddenCreator = null;
  }

  // Custom implementation of hash code optimized for reading providers.
  @override
  int get hashCode => _cachedHash;
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;

  /// overrides the creator function of this provider useful for unit test.
  @visibleForTesting
  void overrideProvider(
    Creator<E> creator, {
    bool? autoDispose,
  }) {
    if (mounted) {
      dispose();
    }
    _overriddenCreator = creator;
  }
}

class Ref {
  Object? _arguments;
  void Function()? _onDispose;
  Object? get arguments => _arguments;

  void _setArguments(Object? arguments) {
    _arguments = arguments;
  }

  void _dispose() => _onDispose?.call();

  void onDispose(void Function() callback) {
    _onDispose = callback;
  }
}
