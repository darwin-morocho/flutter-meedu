import 'package:flutter_meedu/meedu.dart';
import 'package:persistent_state/app/domain/repositories/cities_repository.dart';
import 'package:persistent_state/app/ui/global_widgets/my_persistent_storage.dart';
import 'city_picker_state.dart';

class CityPickerController extends StateNotifier<CityPickerState> with PersistentStateMixin {
  CityPickerController() : super(CityPickerState.initialState);

  Future<void> load() async {
    if (state is! Loaded) {
      state = const Loading();
      final cities = await Get.find<CitiesRepository>().getAll();
      if (cities != null) {
        state = Loaded(cities: cities);
      } else {
        state = const Error();
      }
    }
  }

  @override
  CityPickerState? fromJson(Map<String, dynamic> json) {
    return Loaded.fromJson(json);
  }

  @override
  PersistentStateStorage get storage => MyPersistentStorage();

  @override
  String get storageKey => 'cities';

  @override
  Map<String, dynamic>? toJson(CityPickerState state) {
    return state.mapOrNull(
      loaded: (state) => state.toJson(),
    );
  }

  @override
  void onPersistentStateError(Object? e, StackTrace s) {
    print(e);
    print(s);
  }
}
