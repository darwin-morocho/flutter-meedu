import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_failure.freezed.dart';

@freezed
class LoginFailure with _$LoginFailure {
  const LoginFailure._();

  const factory LoginFailure.accessDenied() = LoginAccessDenied;

  const factory LoginFailure.network() = LoginNetworkError;

  const factory LoginFailure.unknown() = LoginUnknownError;

  Left<LoginFailure, void> get asLeft => Left(this);
}
