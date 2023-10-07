import 'rx.dart';

/// creates an int observable using the prefix .obx
///
/// examples:
/// final query =  ''.obs;  // is equals to final Rx<String> query = Rx('');
/// final loading =  true.obs;  // is equals to final Rx<bool> query = Rx(true);
/// final price =  0.0.obs;  // is equals to final Rx<double> query = Rx(0.0);
/// final counter =  0.obs;  // is equals to final Rx<int> query = Rx(0);
/// final counter =  MyClass().obs;  // is equals to final Rx<MyClass> query = Rx(MyClass);
extension RxExtension<T> on T {
  Rx<T> get obs => Rx<T>(this);
}
