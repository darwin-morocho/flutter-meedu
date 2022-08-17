import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'http.freezed.dart';

class Http {
  Http({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  Future<RequestResult<T>> request<T>(
    String pathOrUrl, {
    String method = 'GET',
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> headers = const {},
    dynamic data,
    T Function(dynamic responseData)? parser,
    int retry = 1,
    int intents = 0,
  }) async {
    try {
      final response = await _dio.request(
        pathOrUrl,
        options: Options(
          method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: data,
      );

      return RequestResult.success(
        statusCode: response.statusCode!,
        data: parser != null ? parser(response.data) : response.data,
      );
    } on DioError catch (e, s) {
      if ([
        DioErrorType.connectTimeout,
        DioErrorType.receiveTimeout,
        DioErrorType.sendTimeout,
      ].contains(e.type)) {
        return RequestResult.networkError(stackTrace: s);
      }

      if (e.type == DioErrorType.response && e.response != null) {
        if (intents + 1 < retry) {
          return request<T>(
            pathOrUrl,
            intents: intents + 1,
            headers: headers,
            parser: parser,
            queryParameters: queryParameters,
            data: data,
          );
        }
        return RequestResult.serverError(
          statusCode: e.response!.statusCode!,
          data: e.response!.data,
          message: e.message,
          stackTrace: s,
        );
      }

      if (e.type == DioErrorType.cancel) {
        return RequestResult.cancelled(stackTrace: s);
      }

      return RequestResult.networkError(stackTrace: s);
    } catch (e, s) {
      return RequestResult.unhandledError(
        exception: e,
        stackTrace: s,
      );
    }
  }
}

@freezed
class RequestResult<T> with _$RequestResult<T> {
  factory RequestResult.success({
    required int statusCode,
    required T data,
  }) = _Success;

  factory RequestResult.cancelled({
    required StackTrace stackTrace,
  }) = _Cancelled;

  factory RequestResult.networkError({
    required StackTrace stackTrace,
  }) = _NetworkError;

  factory RequestResult.serverError({
    required int statusCode,
    dynamic data,
    String? message,
    required StackTrace stackTrace,
  }) = _ResponseError;

  factory RequestResult.unhandledError({
    required Object exception,
    required StackTrace stackTrace,
  }) = _UnhandledException;
}
