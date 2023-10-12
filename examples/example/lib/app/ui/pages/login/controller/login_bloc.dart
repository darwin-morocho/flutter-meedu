import 'package:dartz/dartz.dart';
import 'package:flutter_meedu/notifiers.dart';


import '../../../../domain/modules/login/failure/login_failure.dart';
import '../../../../domain/modules/login/use_cases/login_use_case.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.loginUseCase,
  }) : super(LoginState.initialState) {
    on<LoginEventEmailChanged>(
      (event, emit) => emit(
        state.copyWith(email: event.email),
      ),
    );
    on<LoginEventPasswordChanged>(
      (event, emit) => emit(
        state.copyWith(password: event.password),
      ),
    );
  }

  final LoginUseCase loginUseCase;

  Future<Either<LoginFailure, void>> submit() {
    return loginUseCase.run(state.loginParams);
  }
}
