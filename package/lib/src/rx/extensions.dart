import 'rx.dart';

/// creates an int observable using for example 0.obs
extension RxInt on int {
  Rx<int> get obs => Rx<int>(this);
}

/// creates a bool observable using for example false.obs
extension RxBool on bool {
  Rx<bool> get obs => Rx<bool>(this);
}

/// creates a double observable using for example 0.0.obs
extension RxDouble on double {
  Rx<double> get obs => Rx<double>(this);
}

/// creates a String observable using for example "".obs
extension RxString on String {
  Rx<String> get obs => Rx<String>(this);
}
