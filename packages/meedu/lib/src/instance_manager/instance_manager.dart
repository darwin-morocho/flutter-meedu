typedef InstanceBuilderCallback<S> = S Function();

class Get {
  /// private contructor
  Get._();
  static Get i = Get._();

  Map<String, dynamic> _vars = {};

  /// Holds a reference to every registered callback when using
  /// [Get.i.lazyPut()]
  final Map<String, _Lazy> _lazyVars = {};

  /// check if one dependency is available to call to the find method
  bool has<T>({String? tag, bool lazy = false}) {
    final String key = _getKey(T, tag);
    final inVars = _vars.containsKey(key);
    if (inVars) return true;

    if (lazy) {
      return _lazyVars.containsKey(key);
    }
    return false;
  }

  /// Insert a Instance into the hashmap
  void put<T>(T value, {String? tag}) {
    final String key = _getKey(T, tag);
    _vars[key] = value;
  }

  /// Search and return one instance T from the hashmap
  T find<T>({String? tag, bool lazy = false}) {
    final String key = _getKey(T, tag);
    final inVars = _vars.containsKey(key);
    if (inVars) {
      return _vars[key];
    }
    if (lazy) {
      if (!_lazyVars.containsKey(key)) {
        throw "Cannot find $key, make sure call to Get.i.lazyPut<${T.toString()}>() before call lazyFind.";
      }
      final dependency = _lazyVars[key]!.builder();
      _vars[key] = dependency;
      return dependency;
    }
    throw "Cannot find $key, make sure call to Get.i.put<${T.toString()}>() before call find.";
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
    InstanceBuilderCallback<T> builder, {
    String? tag,
  }) {
    final key = _getKey(T, tag);
    _lazyVars.putIfAbsent(key, () => _Lazy(builder));
  }
}

class _Lazy {
  InstanceBuilderCallback builder;
  _Lazy(this.builder);
}
