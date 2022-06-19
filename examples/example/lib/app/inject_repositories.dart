import 'package:dio/dio.dart';
import 'package:flutter_meedu/meedu.dart';

import 'core/http/http.dart';
import 'data/repositories_impl/auth_repository_impl.dart';
import 'data/services/remote/auth_service.dart';
import 'domain/repositories/auth_repository.dart';

void injectRepositories(Dio dio) {
  final http = Http(dio: dio);
  Get.lazyPut<AuthRepository>(
    () => AuthRepositoryImpl(
      AuthService(http),
    ),
  );
}
