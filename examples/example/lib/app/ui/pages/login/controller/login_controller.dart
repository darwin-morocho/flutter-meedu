import 'package:dartz/dartz.dart';
import 'package:example/app/domain/modules/login/use_cases/login_use_case.dart';
import 'package:flutter_meedu/meedu.dart';
import '../../../../domain/modules/login/failure/login_failure.dart';
import 'login_state.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController({
    required this.loginUseCase,
  }) : super(LoginState.initialState);

  final LoginUseCase loginUseCase;

  void onEmailChanged(String text) {
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text) {
    state = state.copyWith(password: text);
  }

  Future<Either<LoginFailure, void>> submit() {
    return loginUseCase.run(state.loginParams);
  }
}
