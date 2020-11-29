typedef InstanceBuilderCallback<S> = S Function();

class MGet {
  /// private contructor
  MGet._internal();
  static MGet _instance = MGet._internal();
  static MGet get i => _instance;

  Map<String, dynamic> _vars = {};

  /// Holds a reference to every registered callback when using
  /// [MGet.i.lazyPut()]
  final Map<String, _Lazy> _lazyVars = {};

  /// Insert a Instance into the hashmap
  void put<T>(T value, {String tag}) {
    final String key = _getKey(T, tag);
    _vars[key] = value;
  }

  /// Search and return one instance T from the hashmap
  T find<T>({String tag}) {
    final String key = _getKey(T, tag);
    if (!_vars.containsKey(key)) {
      throw "Cannot find $key, make sure call to MGet.i.put<${T.toString()}>() before call find.";
    }
    return _vars[key];
  }

  /// removes an instance from the hasmap
  void remove<T>({String tag}) {
    final String key = _getKey(T, tag);
    _vars.remove(key);
  }

  /// removes an instance from the lazy hasmap
  void lazyRemove<T>({String tag}) {
    final String key = _getKey(T, tag);
    _lazyVars.remove(key);
  }

  /// Generates the key based on [type] (and optionally a [name])
  /// to register an Instance Builder in the hashmap.
  String _getKey(Type type, String name) {
    return name == null ? type.toString() : type.toString() + name;
  }

  /// Creates a new Instance<S> lazily from the [<S>builder()] callback.
  void lazyPut<T>(
    InstanceBuilderCallback<T> builder, {
    String tag,
  }) {
    final key = _getKey(T, tag);
    _lazyVars.putIfAbsent(key, () => _Lazy(builder));
  }

  /// Returns a new Instance<S> lazily from the [<S>builder()] callback.
  T lazyFind<T>({
    String tag,
  }) {
    final key = _getKey(T, tag);
    if (!_lazyVars.containsKey(key)) {
      throw "Cannot find $key, make sure call to MGet.i.lazyPut<${T.toString()}>() before call lazyFind.";
    }
    return _lazyVars[key].builder();
  }
}

class _Lazy {
  bool permanent = false;
  InstanceBuilderCallback builder;
  _Lazy(this.builder);
}
