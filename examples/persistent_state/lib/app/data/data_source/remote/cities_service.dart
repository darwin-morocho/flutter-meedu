import 'dart:convert';

import 'package:persistent_state/app/domain/models/city.dart';
import 'package:http/http.dart' as http;

class CitiesService {
  Future<List<City>?> get() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://gist.githubusercontent.com/Miserlou/c5cd8364bf9b2420bb29/raw/2bf258763cdddd704f8ffd3ea9a3e81d25e2c6f6/cities.json',
        ),
      );

      if (response.statusCode == 200) {
        final list = jsonDecode(response.body) as List;
        return list
            .map(
              (e) => City.fromJson(e),
            )
            .toList();
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
