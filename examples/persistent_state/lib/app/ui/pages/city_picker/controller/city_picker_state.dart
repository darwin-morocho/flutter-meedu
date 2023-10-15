import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/city.dart';
part 'city_picker_state.freezed.dart';
part 'city_picker_state.g.dart';

@freezed
sealed class CityPickerState with _$CityPickerState {
  const CityPickerState._();


  /// unions
  const factory CityPickerState.loading() = Loading;
  const factory CityPickerState.loaded({
    required List<City> cities,
  }) = Loaded;
  const factory CityPickerState.error() = Error;

  static CityPickerState get initialState => const Loading();

  factory CityPickerState.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CityPickerStateFromJson(json);
}
