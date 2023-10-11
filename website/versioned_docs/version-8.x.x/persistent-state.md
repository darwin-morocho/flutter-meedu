# Persistent state

Since `flutter_meedu:^6.2.3` the `StateNotifier` class allows you to keep the state of your Notifiers even if the app was killed (very useful when you want to add OFFLINE support to your apps).

For this just use the `PersistentStateMixin` mixin and the `PersistentStateStorage` class then you must override the all properties and methods necessary to persist the state of your StateNotifier.


Considere the next example you want to build a city picker page and every time that you show that page you have to make an API request to get a list of cities. So, why don't you cache the cities and the next time that you show the city picker you will be using a cached list of cities instead of making a new API request?


## Example using Hive as database

The next class will be used for you state 
```dart

class CityPickerState extends Equatable {
  final bool loading;
  final List<City> cities;

  const CityPickerState({
    required this.loading,
    required this.cities,
  });

  static CityPickerState get initialState => CityPickerState(
        loading: true,
        cities: [],
      );

  CityPickerState copyWith({
    bool? loading,
    List<City>? cities,
  }) {
    return CityPickerState(
      loading: loading ?? this.loading,
      cities: cities ?? this.cities,
    );
  }

  factory CityPickerState.fromJson(Map<String, dynamic> json) {
    return CityPickerState(
      loading: json['loading'],
      cities: (json['cities'] as List)
          .map(
            (e) => City.fromJson(e),
          )
          .toList(),
    );
  }

  /// conver this instance to one JSON map
  Map<String, dynamic> toJson() => {
        'loading': loading,
        'cities': cities
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      };

  @override
  List<Object?> get props => [
        loading,
        cities,
      ];
}

class City extends Equatable {
  final int id;
  final String name;

  const City({
    required this.id,
    required this.name,
  });

  /// convert this instance to one JSON map
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  /// return one instance of City from a JSON map
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
```

Next you have to create your storage
```dart
import 'dart:convert';

import 'package:flutter_meedu/meedu.dart';
import 'package:hive/hive.dart';

class MyPersistentStorage implements PersistentStateStorage {
  final Box _box = Get.find();

  /// delete one specific state
  @override
  Future<void> delete(String key) {
    return _box.delete(key);
  }

  /// delete all states in your storage
  @override
  Future<void> deleteAll() {
    return _box.clear();
  }

  /// check an state with the provided key exists in the
  /// storage and return it as a JSON map
  @override
  Map<String,dynamic>? get(String key) {
    final dataAsString = _box.get(key);
    if (dataAsString != null) {
      return jsonDecode(dataAsString);
    }
    return null;
  }

  @override
  Future<void> save(String key, Map<String,dynamic> json) {
    return _box.put(
      key,
      jsonEncode(json),
    );
  }
}
```

:::note
Note that in the above code we use `jsonEncode` to store the json state as a string to avoid to define custom `TypeAdapters` for Hive. Also we use `jsonDecode` to convert the json string to a Map.

You are free to use any other Database.
:::


Now in your `main` inject a `Hive box` as a dependency.
```dart
void main() async {
  await injectDependencies();
  runApp(const MyApp());
}

.
.
.


Future<void> injectDependencies() async {
  await Hive.initFlutter();

  // box that will be  used to store your states
  final box = await Hive.openBox('states');
  Get.put<Box>(box);
}
```


Now we must create the `StateNotifier` and use the `PersistentStateMixin` mixin.

```dart
class CityPickerController extends StateNotifier<CityPickerState> with PersistentStateMixin {

  CityPickerController() : super(CityPickerState.initialState);


  Future<void> loadCities() async {
    /// if you don't have a cached state
    if (state.cities.isEmpty) {
      final cities = await getCitiesFromYourAPI();
      state = state.copyWith(
        loading: false,
        cities: cities,
      );
    }
  }

  @override
  CityPickerState? fromJson(Map<String,dynamic> json) {
    return CityPickerState.fromJson(json);
  }

  @override
  String get storageKey => 'my_unique_id';

  @override
  PersistentStateStorage get storage => MyPersistentStorage(); // <--YOUR STORAGE

  @override
  Map<String,dynamic>? toJson(CityPickerState state) {
    if (state.cities.isNotEmpty) {
      return state.toJson();
    }
    return null;
  }
}
```

In the above code the `PersistentStateMixin` mixin forces you to override:

-  `storageKey` : an unique string used to idenfier your state in the storage.
- `storage`: one instance of a class that implements `MyPersistentStorage` and all logic to save and read your state.
- `toJson`: a method to parse your current state as a json and save it in the storage. This method will be called every time that the state of your Notifier changes. If `toJson` returns null when the current state saved in your storage won't be modified.
- `fromJson`: This method is called only once when the `PersistentStateMixin` is detecting that your are trying to get your current state for the first time then is the moment to check if a previous state was saved in the storage, next the `fromJson` method will be used to parse the json saved in your storage into one instance of your `State`.


:::note
You can override the `onPersistentStateError` method to listen when a state couldn't be saved or it couldn't be parsed.
:::

:::success
You can check  a complete example using freezed unions
[here](https://github.com/darwin-morocho/flutter-meedu/tree/master/examples/persistent_state)
:::