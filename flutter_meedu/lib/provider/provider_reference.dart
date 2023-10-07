part of 'base_provider.dart';

class Element<T> {
  Element({
    required this.reference,
  });

  T? _value;
  final ProviderReference reference;
}

class ProvidersContainer {
  final _elements = <String, Element>{};
  Map<String, Element> get elements => _elements;
}

class ProviderReference {
  ProviderReference({
    required ProvidersContainer container,
  }) : _container = container;

  Object? _arguments;
  Object? get arguments => _arguments;

  final ProvidersContainer _container;

  void Function()? _disposeCallback;

  String _key = '';

  @protected
  static String getKey<T>(BaseProvider<T> provider, String? tag) {
    return '${provider.hashCode}${tag ?? ''}';
  }

  T read<T>(
    BaseProvider<T> provider, {
    String? tag,
  }) {
    final key = getKey(provider, tag);
    return _container._elements.putIfAbsent(
      key,
      () {
        final element = _getElement(provider, tag);
        final value = provider.creator(
          element.reference,
        );
        if (value is ListeneableNotifier && provider.autoDispose) {
          // ignore: invalid_use_of_protected_member
          value.setDisposableCallback(dispose);
        }
        element._value = value;
        return element;
      },
    )._value;
  }

  Element<T> _getElement<T>(BaseProvider<T> provider, String? tag) {
    final key = getKey(provider, tag);
    late final ProviderReference ref;
    if (_key.isNotEmpty && _key != key) {
      ref = ProviderReference(container: _container).._key = key;
    } else {
      _key = key;
      ref = this;
    }
    return _container.elements[key] as Element<T>? ?? Element(reference: ref);
  }

  void setArguments<T>({
    required BaseProvider<T> provider,
    required dynamic arguments,
    String? tag,
  }) {
    _getElement(provider, tag);
    _arguments = arguments;
  }

  bool mounted<T>(
    BaseProvider<T> provider, {
    String? tag,
  }) {
    return _container._elements[getKey(provider, tag)]?._value != null;
  }

  void onDispose(void Function() callback) {
    _disposeCallback = callback;
  }

  void dispose<T>() {
    _disposeCallback?.call();
    if (_key.isNotEmpty) {
      _container._elements.remove(_key);
    }
  }
}
