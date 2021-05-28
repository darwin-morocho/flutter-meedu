typedef _InstanceBuilderCallback<S> = S Function();

/// Singleton to save dependencies
class Get {
  /// private contructor
  Get._();
  static Get i = Get._();

  /// used to save singletons using put or lazyPut
  Map<String, dynamic> _vars = {};

  /// Holds a reference to every registered callback when using
  /// [Get.i.lazyPut()]
  final Map<String, _Lazy> _lazyVars = {};

  /// used to save factory dependencies
  final Map<String, _Lazy> _factoryVars = {};

  /// check if one dependency is available to call to the find method
  bool has<T>({String? tag}) {
    final String key = _getKey(T, tag);
    final inVars = _vars.containsKey(key);
    if (inVars) return true;
    final inFactoryVars = _factoryVars.containsKey(key);
    if (inFactoryVars) return true;
    final inLazyVars = _lazyVars.containsKey(key);
    return inLazyVars;
  }

  /// Insert a Instance into the hashmap
  void put<T>(T value, {String? tag}) {
    final String key = _getKey(T, tag);
    _vars[key] = value;
  }

  /// Search and return one instance T from the hashmap
  T find<T>({String? tag}) {
    final String key = _getKey(T, tag);
    // check if the dependency is a factory
    final inFactoryVars = _factoryVars.containsKey(key);
    if (inFactoryVars) {
      return _factoryVars[key]!.builder();
    }
    // check if the dependency was already injected
    final inVars = _vars.containsKey(key);
    if (inVars) {
      return _vars[key];
    }
    // if the dependency is a lazy
    final inLazyVars = _lazyVars.containsKey(key);
    if (inLazyVars) {
      final dependency = _lazyVars[key]!.builder();
      _vars[key] = dependency;
      return dependency;
    }

    throw "Cannot find $key, make sure call to Get.i.put<${T.toString()}>(), Get.i.lazyPut<${T.toString()}>(), or Get.i.factoryPut<${T.toString()}>() before call find.";
  }

  /// removes an instance from the hasmap
  void remove<T>({String? tag}) {
    final String key = _getKey(T, tag);
    _vars.remove(key);
  }

  /// removes an instance from the lazy hasmap
  void lazyRemove<T>({String? tag}) {
    final String key = _getKey(T, tag);
    _lazyVars.remove(key);
  }

  /// Generates the key based on [type] (and optionally a [name])
  /// to register an Instance Builder in the hashmap.
  String _getKey(Type type, String? name) {
    return name == null ? type.toString() : type.toString() + name;
  }

  /// Creates a new Instance<S> lazily from the [<S>builder()] callback.
  void lazyPut<T>(
    _InstanceBuilderCallback<T> builder, {
    String? tag,
  }) {
    final key = _getKey(T, tag);
    _lazyVars.putIfAbsent(key, () => _Lazy(builder));
  }

  /// Creates a new Instance<S> from the [<S>builder()] callback.
  void factoryPut<T>(
    _InstanceBuilderCallback<T> builder, {
    String? tag,
  }) {
    final key = _getKey(T, tag);
    _factoryVars.putIfAbsent(key, () => _Lazy(builder));
  }

  /// delete all dependencies
  void clear() {
    _factoryVars.clear();
    _vars.clear();
    _lazyVars.clear();
  }
}

class _Lazy {
  _InstanceBuilderCallback builder;
  _Lazy(this.builder);
}
