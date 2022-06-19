import 'package:dartz/dartz.dart';

import '../../domain/modules/login/failure/login_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/remote/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._service);

  final AuthService _service;

  @override
  Future<Either<LoginFailure, void>> login({
    required String email,
    required String password,
  }) async {
    final result = await _service.login(
      email,
      password,
    );

    return result.map(
      success: (_) => const Right(null),
      cancelled: (_) => const Left(LoginFailure.unknown()),
      networkError: (_) => const Left(LoginFailure.network()),
      serverError: (_) => const Left(LoginFailure.accessDenied()),
      unhandledError: (_) => const Left(LoginFailure.unknown()),
    );
  }
}
