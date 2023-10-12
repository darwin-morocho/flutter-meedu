import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter/material.dart';

import 'app/inject_repositories.dart';
import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  injectRepositories(
    Dio(
      BaseOptions(
        baseUrl: 'https://reqres.in',
      ),
    )..interceptors.add(
        dioLoggerInterceptor,
      ),
  );
  runApp(
    const MyApp(),
  );
}
