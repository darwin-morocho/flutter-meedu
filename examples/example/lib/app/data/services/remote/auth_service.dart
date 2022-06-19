import '../../../core/http/http.dart';

class AuthService {
  final Http http;

  AuthService(this.http);

  ///
  ///
  /// check the api demo here https://reqres.in/
  ///
  /// return an access token for the current user
  Future<RequestResult<String>> login(
    String email,
    String password,
  ) async {
    return http.request(
      '/api/login',
      method: 'POST',
      data: {
        'email': email,
        'password': password,
      },
      parser: (data) {
        return data['token'];
      },
    );
  }
}
