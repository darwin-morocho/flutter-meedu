import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:example/app/core/failure.dart';
import 'package:example/app/data/data_source/remote/auth_service.dart';
import 'package:example/app/domain/modules/login/failure/login_failure.dart';
import 'package:example/app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._service);

  final AuthService _service;

  @override
  Future<Either<LoginFailure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _service.login(email, password);
      return const Right(null);
    } on ServerException catch (e) {
      return const LoginFailure.accessDenied().asLeft;
    } on SocketException {
      return const LoginFailure.network().asLeft;
    } catch (e, s) {
      return const LoginFailure.unknown().asLeft;
    }
  }
}
