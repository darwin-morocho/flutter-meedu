import 'package:meedu/meedu.dart';

/// a mixin to allows you save a state as a JSON in any local database
mixin PersistentStateMixin<State> on StateNotifier<State> {
  State? _state;

  /// the storage sho save and return a cached  state
  PersistentStateStorage get storage;

  ///a unique key to identifier the state into the storage
  String get storageKey;

  /// convert a JSON to one instance of [State]
  State? fromJson(Map<String, dynamic> json);

  /// convert one instance of [State] to a JSON
  /// to be saved into the storage
  ///
  /// **IMPORTANT** if this method returns `null` the current state saved
  /// won't be modified
  Map<String, dynamic>? toJson(State state);

  /// a callback to listen when a cached storage couldn't be parsed
  /// or if the state couldn't be saved
  void onPersistentStateError(Object? e, StackTrace s) {}

  @override
  State get state {
    try {
      if (_state != null) {
        return _state!;
      }
      final cachedStateAsJson = storage.get(storageKey);

      final cachedState = cachedStateAsJson != null
          ? fromJson(
              cachedStateAsJson,
            )
          : null;

      if (cachedState != null) {
        _state = cachedState;
        return _state!;
      }
      _state = super.state;
      return _state!;
    } catch (e, s) {
      _state = super.state;
      onPersistentStateError(e, s);
      return _state!;
    }
  }

  @override
  void onStateChanged(State oldState, State currentState) {
    _state = currentState;
    final json = toJson(currentState);
    if (json != null) {
      storage
          .save(
            storageKey,
            json,
          )
          .onError(
            onPersistentStateError,
          );
    }
  }
}

/// this class defines a storage interface for any StateNotifier
/// that implements the [PersistentStateMixin]
abstract class PersistentStateStorage {
  /// return a saved state by key
  Map<String, dynamic>? get(String key);

  /// save the state as a json string
  Future<void> save(String key, Map<String, dynamic> json);

  /// delete a cached state from the storage
  Future<void> delete(String key);

  /// delete all states in your storage
  Future<void> deleteAll();
}
