import 'package:meta/meta.dart';

class Element<E> {
  Element({
    required this.ref,
  });

  final Ref ref;
  E? _value;
  E? get value => _value;

  void set(E value) => _value = value;
}

class Ref<A> {
  Ref({
    required this.tag,
  });

  final String? tag;

  A? _arguments;
  A get arguments {
    assert(
      _arguments != null,
      'arguments not initialized, make sure to call to ypurProvoder.setArguments(...) before',
    );
    return _arguments!;
  }

  void Function()? _onDisposeCallback;

  void setArguments(A args) => _arguments = args;

  void onDispose(void Function() callback) => _onDisposeCallback = callback;

  @protected
  void dispose() => _onDisposeCallback?.call();
}

class ProvidersContainer {
  ProvidersContainer._();

  /// SINGLETON
  static final _instance = ProvidersContainer._();
  static ProvidersContainer get instance => _instance;

  /// store the elements
  final _elements = <String, Element>{};
  Map<String, Element> get elements => _elements;

  /// use this function for testing in your
  /// setUp or tearDown
  @visibleForTesting
  static void clear() {
    for (final e in _instance.elements.values) {
      e.ref.dispose();
    }
    _instance.elements.clear();
  }
}
