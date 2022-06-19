import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Dio {}

final mockDio = MockHttpClient();

class MockHttp {
  MockHttp._();

  static void loginOk() {
    when(
      () => mockDio.request(
        any(),
        options: any(named: 'options'),
        data: any(named: 'data'),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: {
          'token': '',
        },
        statusCode: 200,
        requestOptions: RequestOptions(
          path: _.positionalArguments.first,
        ),
      ),
    );
  }

  static void loginInvalidCredentials() {
    when(
      () => mockDio.request(
        any(),
        options: any(named: 'options'),
        data: any(named: 'data'),
      ),
    ).thenAnswer(
      (_) {
        final requestOptions = RequestOptions(
          path: _.positionalArguments.first,
        );

        throw DioError(
          type: DioErrorType.response,
          response: Response(
            statusCode: 403,
            requestOptions: requestOptions,
          ),
          requestOptions: requestOptions,
        );
      },
    );
  }

  static void networkError() {
    when(
      () => mockDio.request(
        any(),
        options: any(named: 'options'),
        data: any(named: 'data'),
      ),
    ).thenAnswer(
      (_) async => throw DioError(
        type: DioErrorType.connectTimeout,
        requestOptions: RequestOptions(
          path: _.positionalArguments.first,
        ),
      ),
    );
  }

  static void unhandledError() {
    when(
      () => mockDio.request(
        any(),
        options: any(named: 'options'),
        data: any(named: 'data'),
      ),
    ).thenAnswer(
      (_) {
        throw Exception();
      },
    );
  }
}
