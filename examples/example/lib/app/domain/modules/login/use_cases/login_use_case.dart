import 'package:dartz/dartz.dart';

import '../../../repositories/auth_repository.dart';
import '../failure/login_failure.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Either<LoginFailure, void>> run(LoginParams params) {
    return _authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
