import 'package:example/app/core/my_http_client.dart';
import 'package:example/app/data/data_source/remote/auth_service.dart';
import 'package:example/app/data/repositories_impl/auth_repository_impl.dart';
import 'package:example/app/domain/modules/login/use_cases/login_use_case.dart';
import 'package:example/app/domain/repositories/auth_repository.dart';
import 'package:flutter_meedu/meedu.dart';

Future<void> injectDependencies() async {
  await injectRepositories();
  Get.lazyPut(
    () => LoginUseCase(
      Get.find(),
    ),
    autoRemove: true,
  );
}

Future<void> injectRepositories() async {
  final client = MyHttpClient(
    baseUrl: 'https://reqres.in/',
  );

  Get.lazyPut<AuthRepository>(
    () => AuthRepositoryImpl(
      AuthService(client),
    ),
  );
}
