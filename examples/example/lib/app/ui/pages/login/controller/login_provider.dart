import 'package:flutter_meedu/providers.dart';

import '../../../../domain/modules/login/use_cases/login_use_case.dart';
import '../../../../inject_repositories.dart';
import 'login_bloc.dart';
import 'login_state.dart';

final loginProvider = StateNotifierProvider<LoginBloc, LoginState>(
  (_) => LoginBloc(
    loginUseCase: LoginUseCase(
      Repositories.auth.read(),
    ),
  ),
);
