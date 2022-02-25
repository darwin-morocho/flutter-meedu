import 'dart:convert';

import 'package:http/http.dart' as http;

class MyHttpClient extends http.BaseClient {
  final String? baseUrl;

  MyHttpClient({
    this.baseUrl,
  }) {
    if (baseUrl != null) {
      assert(
        baseUrl!.startsWith("http://") || baseUrl!.startsWith("https://"),
      );
    }
  }

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return super.post(
      getUrl(url),
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
  }) {
    return super.get(
      getUrl(url),
      headers: headers,
    );
  }

  @override
  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return super.put(
      getUrl(url),
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<http.Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return super.patch(
      getUrl(url),
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return super.delete(
      getUrl(url),
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return request.send();
  }

  Uri getUrl(Uri url) {
    if (baseUrl != null && !url.toString().startsWith("http")) {
      String baseUrl = this.baseUrl!;
      if (!baseUrl.endsWith("/")) {
        baseUrl += '/';
      }
      if (url.path.startsWith("/")) {
        baseUrl = baseUrl.substring(0, baseUrl.length - 1);
      }

      final newUrl = Uri.parse("$baseUrl${url.path}");

      return url.replace(
        host: newUrl.host,
        path: newUrl.path,
        scheme: newUrl.scheme,
      );
    }
    return url;
  }
}
