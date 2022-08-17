import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

import 'app/inject_dependencies.dart';
import 'app/inject_repositories.dart';
import 'app/my_app.dart';
import 'package:dio_logger/dio_logger.dart';

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
  injectDependencies();
  router.setDefaultTransition(
    Transition.fadeIn,
  );
  runApp(
    const MyApp(),
  );
}
