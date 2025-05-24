// ignore_for_file: hash_and_equals

import 'package:meta/meta.dart';

typedef CreatorCallback<E, A> = E Function(Ref<A> ref);

class Creator<E, A> {
  Creator(this._callback, this._autoDispose);

  final CreatorCallback<E, A> _callback;

  /// callback to override the main creator callback
  CreatorCallback<E, A>? _overriddenCallback;

  final bool _autoDispose;

  /// boolean to override the main autoDispose
  bool? _overriddenAutoDispose;

  CreatorCallback<E, A> get callback => _overriddenCallback ?? _callback;
  bool get autoDispose => _overriddenAutoDispose ?? _autoDispose;

  @protected
  void overrideCreator(
    CreatorCallback<E, A> callback, {
    bool? autoDispose,
  }) {
    _overriddenCallback = callback;
    _overriddenAutoDispose = autoDispose;
  }

  void resetCreator() {
    _overriddenCallback = null;
    _overriddenAutoDispose = null;
  }

  @override // coverage:ignore-line
  int get hashCode => _cachedHash; // coverage:ignore-line
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;
}

/// Base class uses to represents the Element created by a provider
class Element<E> {
  Element({
    required this.ref,
  });

  final Ref ref;
  E? _value;
  E? get value => _value;

  void set(E value) => _value = value;
}

class FactoryElement<E> extends Element<E> {
  FactoryElement({required super.ref});

  @override
  E get value => _value!;

  void dispose() => ref.dispose();
}

class FactoryArgumentsElement<E, A> extends Element<E> {
  FactoryArgumentsElement({required super.ref});

  @override
  E get value => _value!;

  void dispose() => ref.dispose();
}

/// Reference use to store arguments before create an [Element]
/// and listen when an [Element] has been disposed
class Ref<A> {
  Ref({
    required this.tag,
  });

  final String? tag;
  bool _argumentsInitialized = false;

  late A _arguments;
  A get arguments {
    if (!_argumentsInitialized) {
      throw AssertionError(
        'arguments not initialized, make sure to call to yourProvider.setArguments(...) before',
      );
    }

    return _arguments;
  }

  void Function()? _onDisposeCallback;

  void setArguments(A args) {
    _arguments = args;
    _argumentsInitialized = true;
  }

  void onDispose(void Function() callback) => _onDisposeCallback = callback;

  @protected
  void dispose() {
    _argumentsInitialized = false;
    _onDisposeCallback?.call();
  }
}

class ProvidersContainer {
  ProvidersContainer._();

  /// SINGLETON
  static final _instance = ProvidersContainer._();
  static ProvidersContainer get instance => _instance;

  /// store the elements
  final _elements = <String, Element>{};
  Map<String, Element> get elements => _elements;

  final _overriddenCreators = <int, Creator>{};
  Map<int, Creator> get overriddenCreators => _overriddenCreators;

  /// use this function for testing in your
  /// setUp or tearDown
  @visibleForTesting
  static void clear() {
    for (final e in _instance.elements.values) {
      e.ref.dispose();
    }

    for (final creator in _instance._overriddenCreators.values) {
      creator.resetCreator();
    }

    _instance._overriddenCreators.clear();
    _instance.elements.clear();
  }
}
