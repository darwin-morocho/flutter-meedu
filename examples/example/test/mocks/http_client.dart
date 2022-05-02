import 'dart:io';

import 'package:example/app/core/my_http_client.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements MyHttpClient {}

final mockHttpClient = MockHttpClient();
