import '../../../../inject_dependencies.dart';
import 'package:flutter_meedu/meedu.dart';
import 'login_bloc.dart';
import 'login_state.dart';

final loginProvider = StateProvider<LoginBloc, LoginState>(
  (_) => LoginBloc(
    loginUseCase: UsesCases.login,
  ),
);
