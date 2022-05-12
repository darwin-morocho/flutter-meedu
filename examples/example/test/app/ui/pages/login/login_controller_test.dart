import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:example/app/ui/pages/login/controller/login_controller.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/http_client.dart';
import '../../../../set_up.dart';

void main() {
  setUpTests();

  late LoginController controller;

  setUp(
    () {
      controller = LoginController(
        loginUseCase: Get.find(),
      );
    },
  );

  test(
    'LoginController > ok',
    () async {
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode(
            {
              'token': '',
            },
          ),
          200,
        ),
      );

      expect(controller.state.email, '');
      expect(controller.state.password, '');
      controller.onEmailChanged('test@test.com');
      controller.onPasswordChanged('test');
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
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => throw const SocketException('mocked error'),
      );

      controller.onEmailChanged('test@test.com');
      controller.onPasswordChanged('test');

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
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode(
            {},
          ),
          403,
        ),
      );

      controller.onEmailChanged('test@test.com');
      controller.onPasswordChanged('test');

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
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => throw Exception(),
      );

      controller.onEmailChanged('test@test.com');
      controller.onPasswordChanged('test');

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
