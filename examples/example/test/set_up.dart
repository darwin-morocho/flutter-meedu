import 'package:example/app/inject_dependencies.dart';
import 'package:example/app/inject_repositories.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/http_client.dart';

void setUpTests() {
  setUp(
    () async {
      router.dispose();
      Get.clear();
      ProviderScope.clear();

      injectRepositories(mockDio);
      injectDependencies();
      registerFallbackValue(Uri.parse(''));
    },
  );
}
