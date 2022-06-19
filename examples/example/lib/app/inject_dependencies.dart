import 'package:example/app/domain/modules/login/use_cases/login_use_case.dart';
import 'package:flutter_meedu/meedu.dart';

void injectDependencies() {
  Get.lazyPut(
    () => LoginUseCase(
      Get.find(),
    ),
    autoRemove: true,
  );
}



class UsesCases {
  UsesCases._();

  static LoginUseCase get login => Get.find();
}
