import 'package:dio/dio.dart';
import 'package:flutter_meedu/providers.dart';

import 'core/http/http.dart';
import 'data/repositories_impl/auth_repository_impl.dart';
import 'data/services/remote/auth_service.dart';
import 'domain/repositories/auth_repository.dart';

void injectRepositories(Dio dio) {
  final http = Http(dio: dio);
  final authService = AuthService(http);
  Repositories.auth.setArguments(authService);
}

class Repositories {
  Repositories._();

  static final auth = Provider.withArguments<AuthRepository, AuthService>(
    (ref) => AuthRepositoryImpl(ref.arguments),
  );
}
