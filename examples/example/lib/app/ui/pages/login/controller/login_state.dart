import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/modules/login/use_cases/login_use_case.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
  }) = _LoginState;

  static LoginState get initialState => const LoginState();

  LoginParams get loginParams => LoginParams(
        email: email,
        password: password,
      );
}
