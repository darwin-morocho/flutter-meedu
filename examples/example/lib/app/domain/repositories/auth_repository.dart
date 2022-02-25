import 'package:dartz/dartz.dart';

import '../modules/login/failure/login_failure.dart';

abstract class AuthRepository {
  Future<Either<LoginFailure, void>> login({
    required String email,
    required String password,
  });
}
