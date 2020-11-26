class MGet {
  /// private contructor
  MGet._internal();
  static MGet _instance = MGet._internal();
  static MGet get i => _instance;

  Map<String, dynamic> _vars = {};

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

  /// Generates the key based on [type] (and optionally a [name])
  /// to register an Instance Builder in the hashmap.
  String _getKey(Type type, String name) {
    return name == null ? type.toString() : type.toString() + name;
  }
}
