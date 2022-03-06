import 'package:meedu/meedu.dart';

/// typedef to present a JSON
typedef Json = Map<String, dynamic>;

/// a mixin to allows you save a state as a JSON in any local database
mixin PersistentStateMixin<State> on StateNotifier<State> {
  State? _state;

  /// the storage sho save and return a cached  state
  PersistentStateStorage get storage;

  ///a unique key to identifier the state into the storage
  String get storageKey;

  /// convert a JSON to one instance of [State]
  State fromJson(Json json);

  /// convert one instance of [State] to a JSON
  /// to be saved into the storage
  Json toJson(State state);

  /// a callback to listen when a cached storage couldn't be parsed
  /// or if the state couldn't be saved
  void onPersistentStateError(Object? e, StackTrace s) {}

  @override
  State get state {
    try {
      if (_state != null) {
        return _state!;
      }
      final cachedState = storage.get(storageKey);
      if (cachedState != null) {
        _state = fromJson(cachedState);
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
    storage
        .save(
          storageKey,
          toJson(currentState),
        )
        .onError(
          onPersistentStateError,
        );
  }
}

/// this class defines a storage interface for any StateNotifier
/// that implements the [PersistentStateMixin]
abstract class PersistentStateStorage {
  /// return a saved state by key
  Json? get(String key);

  /// save the state as a json string
  Future<void> save(String key, Json json);

  /// delete a cached state from the storage
  Future<void> delete(String key);

  /// delete all states in your storage
  Future<void> deleteAll();
}
