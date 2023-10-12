
import 'package:example/app/inject_repositories.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/http_client.dart';

void setUpTests() {
  setUp(
    () async {
      ProvidersContainer.clear();

      injectRepositories(mockDio);
      registerFallbackValue(Uri.parse(''));
    },
  );
}
