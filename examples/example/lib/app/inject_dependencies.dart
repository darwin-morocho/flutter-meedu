import 'package:example/app/data/data_source/remote/auth_service.dart';
import 'package:example/app/data/repositories_impl/auth_repository_impl.dart';
import 'package:example/app/domain/modules/login/use_cases/login_use_case.dart';
import 'package:example/app/domain/repositories/auth_repository.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:http/http.dart' as http;

void injectDependencies() {
  Get.lazyPut(
    () => LoginUseCase(
      Get.find(),
    ),
    autoRemove: true,
  );
}

void injectRepositories(http.Client client) {
  Get.lazyPut<AuthRepository>(
    () => AuthRepositoryImpl(
      AuthService(client),
    ),
  );
}
