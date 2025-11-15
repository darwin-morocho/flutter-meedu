import 'package:flutter_meedu/providers.dart';

import 'city_picker_controller.dart';
import 'city_picker_state.dart';

final cityPickerProvider =
    Provider.state<CityPickerController, CityPickerState>(
  (_) => CityPickerController(),
);
