import 'package:dio/dio.dart';
import 'package:example/app/ui/pages/login/controller/login_bloc.dart';
import 'package:example/app/ui/pages/login/controller/login_event.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/http_client.dart';
import '../../../../set_up.dart';

void main() {
  setUpTests();

  late LoginBloc controller;

  setUp(
    () {
      controller = LoginBloc(
        loginUseCase: Get.find(),
      );
      registerFallbackValue(
        Options(),
      );
    },
  );

  test(
    'LoginController > ok',
    () async {
      MockHttp.loginOk();

      expect(controller.state.email, '');
      expect(controller.state.password, '');
      controller.add(LoginEvent.emailChanged('test@test.com'));
      controller.add(LoginEvent.passwordChanged('test'));
      expect(controller.state.email, 'test@test.com');
      expect(controller.state.password, 'test');

      bool ok = false;

      final result = await controller.submit();
      result.fold(
        (l) => null,
        (r) => ok = true,
      );

      expect(ok, true);
    },
  );

  test(
    'LoginController > network error',
    () async {
      MockHttp.networkError();

      controller.add(LoginEvent.emailChanged('test@test.com'));
      controller.add(LoginEvent.passwordChanged('test'));

      bool ok = false;

      final result = await controller.submit();
      result.fold(
        (l) => null,
        (r) => ok = true,
      );

      expect(ok, false);
    },
  );

  test(
    'LoginController > invalid credentials',
    () async {
      MockHttp.loginInvalidCredentials();

      controller.add(LoginEvent.emailChanged('test@test.com'));
      controller.add(LoginEvent.passwordChanged('test'));

      bool ok = false;

      final result = await controller.submit();
      result.fold(
        (l) => null,
        (r) => ok = true,
      );

      expect(ok, false);
    },
  );

  test(
    'LoginController > internal error',
    () async {
      MockHttp.unhandledError();
      controller.add(LoginEvent.emailChanged('test@test.com'));
      controller.add(LoginEvent.passwordChanged('test'));

      bool ok = false;

      final result = await controller.submit();
      result.fold(
        (l) => null,
        (r) => ok = true,
      );

      expect(ok, false);
    },
  );
}
