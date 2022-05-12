import 'dart:convert';

import 'package:example/app/core/failure.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final http.Client client;

  AuthService(this.client);

  ///
  ///
  /// check the api demo here https://reqres.in/
  ///
  /// return an access token for the current user
  Future<String> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('/api/login'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['token'];
    }
    throw ServerException(response.statusCode);
  }
}
