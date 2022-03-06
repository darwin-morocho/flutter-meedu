import 'package:flutter_meedu/meedu.dart';
import 'city_picker_controller.dart';
import 'city_picker_state.dart';

final cityPickerProvider = StateProvider<CityPickerController,CityPickerState>(
  (_) => CityPickerController(),
);
  